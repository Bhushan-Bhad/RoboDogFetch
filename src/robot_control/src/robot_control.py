# ~/RoboDogFetch/src/robot_control/src/robot_control.py

#!/usr/bin/env python
import rospy
from std_msgs.msg import String

class RobotControl:
    def __init__(self):
        self.sub = rospy.Subscriber('path_planning/output', String, self.callback)

    def callback(self, data):
        rospy.loginfo("Controlling robot to: %s", data.data)

if __name__ == '__main__':
    rospy.init_node('robot_control')
    control = RobotControl()
    rospy.spin()
