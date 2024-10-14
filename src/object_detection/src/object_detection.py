#!/usr/bin/env python3

import rospy
import os
import sys
import platform
import ctypes
import numpy as np
import cv2
import mediapipe as mp
from ultralytics import YOLO
from sensor_msgs.msg import Image
from std_msgs.msg import String
from cv_bridge import CvBridge, CvBridgeError
from geometry_msgs.msg import PoseStamped
from distance_calc_MonocularDepthEstimation import estimate_depth
import time  # To limit the frame rate

# Known real-world sizes (in meters)
HUMAN_HEIGHT = 1.7  # Approximate average height of a human in meters
BALL_DIAMETER = 0.24  # Diameter of a soccer ball in meters

# Camera calibration parameters (adjust according to your camera calibration)
FOCAL_LENGTH = 600  # This is a placeholder, adjust based on your camera calibration

# Function to initialize the YOLO model
def initialize_model():
    return YOLO("yolo-Weights/yolov8n.pt")  # Ensure the correct path to your YOLOv8 weights

# Function to estimate distance using the bounding box height
def estimate_distance(focal_length, real_height, pixel_height):
    if pixel_height == 0:  # To avoid division by zero
        return float('inf')
    return (focal_length * real_height) / pixel_height

# Main function for human and sports ball detection with hand gesture recognition and distance calculation
def human_detection():
    # Force libgomp to be loaded before other libraries consuming dynamic TLS
    if platform.system() == "Linux":
        try:
            ctypes.cdll.LoadLibrary("/usr/lib/aarch64-linux-gnu/libgomp.so.1")
        except OSError as e:
            rospy.logerr(f"Error loading libgomp: {e}")

    # Initialize ROS node
    rospy.init_node('object_detection', anonymous=True)

    # Initialize the YOLO model
    model = initialize_model()

    # Initialize MediaPipe Hands module
    mp_hands = mp.solutions.hands
    mp_drawing = mp.solutions.drawing_utils

    # Initialize CvBridge for converting ROS Image messages to OpenCV images
    bridge = CvBridge()
    target_position_pub = rospy.Publisher('/target_position', PoseStamped, queue_size=10)
    target_command_pub = rospy.Publisher('/target_command', String, queue_size=10)


    global last_detected_position
    global frame_counter
    # Define global variables
    last_detected_position = None
    frame_counter = 0  # To process every N-th frame
    frame_rate_limit = 5  # Process 1 frame out of every 5 (adjust as necessary)

    def process_frame(ros_image):
        global last_detected_position
        global frame_counter

        # Increment frame counter and skip frames to limit processing rate
        frame_counter += 1
        if frame_counter % frame_rate_limit != 0:
            return  # Skip frame

        start_time = time.time()  # Track time for performance measurement

        # Convert ROS Image message to OpenCV format
        try:
            frame = bridge.imgmsg_to_cv2(ros_image, "bgr8")
        except CvBridgeError as e:
            rospy.logerr(f"CvBridge Error: {e}")
            return

        # Resize frame to reduce computational load
        frame = cv2.resize(frame, (640, 480))  # Adjust resolution to reduce processing

        # YOLOv8 to detect objects (including humans)
        results = model(frame)
        image_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        
        with mp_hands.Hands(min_detection_confidence=0.7, min_tracking_confidence=0.5) as hands:
            
            if results is None or len(results) == 0 or not results[0].boxes:
                rospy.logwarn("No detections found.")
                cv2.imshow('Human Detection', frame)
                if cv2.waitKey(1) & 0xFF == ord('q'):
                    rospy.signal_shutdown("User exit.")
                return

            frame_height, frame_width, _ = frame.shape
            humans = [r for r in results if r.boxes and r.boxes.cls[0].item() == 0]

            for human in humans:
                box = human.boxes.xyxy[0].cpu().numpy()
                x1, y1, x2, y2 = map(int, box)

                x1, x2 = max(0, x1), min(frame_width - 1, x2)
                y1, y2 = max(0, y1), min(frame_height - 1, y2)

                x_center = (x1 + x2) // 2
                y_center = (y1 + y2) // 2

                # Gesture detection within cropped region of interest (ROI)
                roi = image_rgb[y1:y2, x1:x2]
                roi_contiguous = np.ascontiguousarray(roi)
                hand_results = hands.process(roi_contiguous)

                if hand_results.multi_hand_landmarks:
                    for hand_landmarks, hand_handedness in zip(hand_results.multi_hand_landmarks, hand_results.multi_handedness):
                        landmarks = hand_landmarks.landmark
                        wrist = landmarks[0]
                        middle_finger_tip = landmarks[12]
                        thumb_tip = landmarks[4]
                        pinky_tip = landmarks[20]

                        hand_label = hand_handedness.classification[0].label
                        vertical = abs(wrist.x - middle_finger_tip.x) < 0.1

                        if hand_label == "Right":
                            palm_open = thumb_tip.x < wrist.x < pinky_tip.x
                        else:
                            palm_open = pinky_tip.x < wrist.x < thumb_tip.x

                        fingers_open = all(landmarks[tip].y < landmarks[tip - 2].y for tip in [8, 12, 16, 20])

                        # If "Hi" gesture detected
                        if vertical and palm_open and fingers_open:
                            cv2.putText(frame, f"Hi Gesture Detected! ({hand_label} hand)", (x1, y1 - 30), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)

                            try:
                                depth_map = estimate_depth(frame)
                                x_center_scaled = int((x_center / frame_width) * depth_map.shape[1])
                                y_center_scaled = int((y_center / frame_height) * depth_map.shape[0])

                                # Get depth at the scaled coordinates
                                depth_at_person = depth_map[y_center_scaled, x_center_scaled]
                                calibration_scale = 0.0013
                                calibrated_distance = depth_at_person * calibration_scale

                                rospy.loginfo(f"Estimated distance to human: {calibrated_distance:.2f} meters")

                                # If the person's position has changed, update the last detected position and publish it
                                new_position = (x_center_scaled, y_center_scaled, calibrated_distance)
                                if last_detected_position is None or np.linalg.norm(np.array(new_position) - np.array(last_detected_position)) > 0.1:
                                    last_detected_position = new_position
                                    
                                    # Publish the new target position
                                    target_msg = PoseStamped()
                                    target_msg.header.stamp = rospy.Time.now()
                                    target_msg.header.frame_id = "map"
                                    #target_msg.header.frame_id = "camera_frame"
                                    target_msg.pose.position.x = x_center_scaled * 0.1
                                    target_msg.pose.position.y = y_center_scaled * 0.1
                                    target_msg.pose.position.z = calibrated_distance
                                    target_position_pub.publish(target_msg)

                                    # Publish the command
                                    target_command_pub.publish("go_to_human")

                            except Exception as e:
                                rospy.logerr(f"Error in depth estimation: {e}")
                                continue

            # Show the frame with detections
            cv2.imshow('Human and Sports Ball Detection', frame)
            if cv2.waitKey(1) & 0xFF == ord('q'):
                rospy.signal_shutdown("User exit.")
    
        end_time = time.time()  # For performance tracking
        rospy.loginfo(f"Frame processing time: {end_time - start_time:.2f} seconds")

    # Subscribe to the camera topic
    rospy.Subscriber("/camera/image_raw", Image, process_frame)

    # Keep the node running
    rospy.spin()
    cv2.destroyAllWindows()

if __name__ == '__main__':
    try:
        human_detection()
    except rospy.ROSInterruptException:
        pass
