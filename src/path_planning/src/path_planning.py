import rospy
import heapq
import math
from std_msgs.msg import String
from geometry_msgs.msg import PoseArray

class AStarPlannerNode:
    def __init__(self):
        rospy.init_node('path_planner', anonymous=True)
        rospy.Subscriber("/object_detection", String, self.person_callback)
        self.path_pub = rospy.Publisher("/planned_path", PoseArray, queue_size=10)
        self.grid = self.create_grid()
        self.start = (0, 0)  # Initialize with some starting position of the robot
        self.goal = None  # Will be set by the detected person

    def person_callback(self, data):
        # Receive person coordinates
        person_coords = data.data.split(',')
        x, y = int(person_coords[0]), int(person_coords[1])
        self.goal = self.camera_coords_to_grid(x, y)

        # Once we have the goal, run A* algorithm
        if self.goal:
            path = self.astar(self.start, self.goal)
            if path:
                self.publish_path(path)

    def camera_coords_to_grid(self, x, y):
        # Convert person coordinates from camera frame to grid coordinates
        # This needs to be done based on camera setup and environment scaling
        grid_x = int(x / 10)  # Simplified conversion example
        grid_y = int(y / 10)
        return (grid_x, grid_y)

    def create_grid(self):
        # Create a static or dynamic grid representing the environment
        grid = [[0 for _ in range(50)] for _ in range(50)]  # Simple 50x50 grid
        # Optionally, update the grid with obstacles detected by the camera
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
        # Convert path to ROS PoseArray message
        pose_array = PoseArray()
        # Populate pose_array with the waypoints in the path
        for waypoint in path:
            pose = Pose()
            pose.position.x = waypoint[0] * 0.1  # Scale it back to real-world units
            pose.position.y = waypoint[1] * 0.1
            pose_array.poses.append(pose)
        self.path_pub.publish(pose_array)

if __name__ == '__main__':
    planner = AStarPlannerNode()
    rospy.spin()
