#!/usr/bin/env python3

import rospy
import cv2
import heapq
import math
import numpy as np
from std_msgs.msg import String
from geometry_msgs.msg import PoseArray, Pose, PoseStamped
from visualization_msgs.msg import Marker, MarkerArray
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError

from unitree_legged_sdk.example_py.example_walk_test.py import set_path

class AStarPlannerNode:
    def __init__(self):
        rospy.init_node('path_planning', anonymous=True)
        
        # Subscribers
        rospy.Subscriber("/target_position", PoseStamped, self.target_pose_callback)
        rospy.Subscriber("/target_command", String, self.command_callback)
        rospy.Subscriber("/camera/image_raw", Image, self.image_callback)  # Add camera subscriber

        # Publishers
        self.path_pub = rospy.Publisher("/planned_path", PoseArray, queue_size=10)
        self.marker_pub = rospy.Publisher("/grid_markers", MarkerArray, queue_size=10)

        self.grid = self.create_grid()
        self.start = (0, 0)  # Starting position of the robot
        self.goal = None  # Will be set by the detected target
        
        # Initialize target_position to None (no target initially)
        self.target_position = None

        self.bridge = CvBridge()  # OpenCV bridge for converting ROS images
        self.obstacle_color_lower = np.array([0, 0, 100])  # Example: lower bound for red obstacles
        self.obstacle_color_upper = np.array([10, 255, 255])  # Example: upper bound for red obstacles

        # Optionally, publish the grid periodically (every 1 second)
        rospy.Timer(rospy.Duration(1), self.publish_grid)

    def image_callback(self, data):
        try:
            # Convert the ROS Image message to OpenCV format
            cv_image = self.bridge.imgmsg_to_cv2(data, "bgr8")
        except CvBridgeError as e:
            rospy.logerr(f"Error converting image: {e}")
            return

        # Process the image to detect obstacles
        self.detect_obstacles(cv_image)

    def detect_obstacles(self, cv_image):
        # Convert the image to HSV color space
        hsv_image = cv2.cvtColor(cv_image, cv2.COLOR_BGR2HSV)

        # Threshold the image to detect obstacles by color
        mask = cv2.inRange(hsv_image, self.obstacle_color_lower, self.obstacle_color_upper)
        
        # Find contours of the obstacles
        contours, _ = cv2.findContours(mask, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
        
        for cnt in contours:
            # Draw contours for obstacles
            cv2.drawContours(cv_image, [cnt], 0, (0, 255, 0), 3)  # Green contours for obstacles
            
            # Calculate the center of the obstacle
            M = cv2.moments(cnt)
            if M['m00'] != 0:
                cx = int(M['m10'] / M['m00'])
                cy = int(M['m01'] / M['m00'])

                # Draw the obstacle center in red
                cv2.circle(cv_image, (cx, cy), 5, (0, 0, 255), -1)  # Red for obstacles

                # Convert pixel coordinates to grid coordinates
                grid_x, grid_y = self.camera_coords_to_grid(cx, cy, 0)
                
                # Mark the obstacle in the grid
                if 0 <= grid_x < len(self.grid) and 0 <= grid_y < len(self.grid[0]):
                    self.grid[grid_x][grid_y] = 1  # Mark as obstacle

        # Highlight the target
        if self.target_position:
            cv2.circle(cv_image, self.target_position, 10, (255, 0, 0), -1)  # Blue circle for the target

        # Display the image with detected obstacles and target in a window
        cv2.imshow("Obstacle Detection and Target", cv_image)
        cv2.waitKey(1)  # Small delay to update the OpenCV window



    def target_pose_callback(self, data):
        # Receive target position from topic
        x = data.pose.position.x
        y = data.pose.position.y
        z = data.pose.position.z  # Not used in grid planning, but useful for info
        
        # Convert camera coordinates to grid coordinates
        self.goal = self.camera_coords_to_grid(x, y, z)

        # Once we have the goal, visualize the target
        if self.goal:
            rospy.loginfo(f"Target selected at {self.goal}")
            
            # Mark the target in OpenCV image visualization
            self.target_position = (int(x), int(y))  # Store the raw target position (in pixel coordinates)
            
            # Perform A* pathfinding if the goal is valid
            path = self.astar(self.start, self.goal)
            if path:
                self.publish_path(path)
            else:
                rospy.logwarn("No path found!")


    def command_callback(self, data):
        # Handle received commands (like "go_to_human" or "go_to_ball")
        command = data.data
        rospy.loginfo(f"Received command: {command}")
        # You can implement logic here if needed based on the command.

    def camera_coords_to_grid(self, x, y, z):
        # Convert pixel coordinates from camera frame to grid coordinates
        # This needs to be done based on camera setup and environment scaling
        grid_x = int(x / 10)  # Simplified conversion example
        grid_y = int(y / 10)
        return (grid_x, grid_y)

    def create_grid(self):
        # Create a static or dynamic grid representing the environment
        grid = [[0 for _ in range(50)] for _ in range(50)]  # Simple 50x50 grid
        return grid

    def heuristic(self, node, goal):
        # Euclidean distance heuristic
        return math.sqrt((node[0] - goal[0])**2 + (node[1] - goal[1])**2)

    def get_neighbors(self, node):
        neighbors = []
        x, y = node
        for nx, ny in [(x+1, y), (x-1, y), (x, y+1), (x, y-1)]:
            if 0 <= nx < len(self.grid) and 0 <= ny < len(self.grid[0]) and self.grid[nx][ny] == 0:
                neighbors.append((nx, ny))
        return neighbors

    def cost(self, current, neighbor):
        return 1  # Uniform cost for simplicity

    def astar(self, start, goal):
        open_list = []
        heapq.heappush(open_list, (0, start))
        came_from = {}
        g_score = {start: 0}
        f_score = {start: self.heuristic(start, goal)}

        while open_list:
            current = heapq.heappop(open_list)[1]

            if current == goal:
                return self.reconstruct_path(came_from, current)

            for neighbor in self.get_neighbors(current):
                tentative_g_score = g_score[current] + self.cost(current, neighbor)

                if neighbor not in g_score or tentative_g_score < g_score[neighbor]:
                    came_from[neighbor] = current
                    g_score[neighbor] = tentative_g_score
                    f_score[neighbor] = tentative_g_score + self.heuristic(neighbor, goal)
                    heapq.heappush(open_list, (f_score[neighbor], neighbor))

        return None

    def reconstruct_path(self, came_from, current):
        path = [current]
        while current in came_from:
            current = came_from[current]
            path.append(current)
        return path[::-1]

    def publish_path(self, path):
        pose_array = PoseArray()
        pose_array.header.frame_id = "map"  # Ensure this matches your RViz setup
        for waypoint in path:
            pose = Pose()
            pose.position.x = waypoint[0] * 0.1  # Adjust the scale if needed
            pose.position.y = waypoint[1] * 0.1
            pose.position.z = 0
            pose_array.poses.append(pose)
        self.path_pub.publish(pose_array)

    def publish_grid(self, event=None):
        marker_array = MarkerArray()
        marker_id = 0
        for i in range(len(self.grid)):
            for j in range(len(self.grid[i])):
                marker = Marker()
                marker.header.frame_id = "map"  # Set your frame of reference
                marker.id = marker_id
                marker.type = Marker.CUBE  # Choose cube markers to represent grid cells
                marker.action = Marker.ADD
                marker.scale.x = 0.1  # Adjust the scale to match your grid
                marker.scale.y = 0.1
                marker.scale.z = 0.01  # Flat 2D grid, small height
                
                # Set color based on whether it's an obstacle or free space
                if self.grid[i][j] == 0:  # Free space
                    marker.color.r = 0.0
                    marker.color.g = 1.0  # Green for free space
                    marker.color.b = 0.0
                    marker.color.a = 0.6  # Adjust transparency
                else:  # Obstacle
                    marker.color.r = 1.0  # Red for obstacle
                    marker.color.g = 0.0
                    marker.color.b = 0.0
                    marker.color.a = 0.6
                
                marker.pose.position.x = i * 0.1  # Grid position scaled
                marker.pose.position.y = j * 0.1
                marker.pose.position.z = 0

                marker_array.markers.append(marker)
                marker_id += 1

        self.marker_pub.publish(marker_array)

if __name__ == '__main__':
    try:
        AStarPlannerNode()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass
