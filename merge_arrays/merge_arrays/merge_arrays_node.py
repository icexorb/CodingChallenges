import rclpy
from rclpy.node import Node
from std_msgs.msg import Int32MultiArray

class MergeArraysNode(Node):
    def __init__(self):
        super().__init__('merge_arrays_node')
        self.subscription1 = self.create_subscription(
            Int32MultiArray,
            '/input/array1',
            self.array_callback1,
            10)
        self.subscription2 = self.create_subscription(
            Int32MultiArray,
            '/input/array2',
            self.array_callback2,
            10)
        self.publisher = self.create_publisher(Int32MultiArray, '/output/array', 10)
        self.array1 = []
        self.array2 = []

    def array_callback1(self, msg):
        self.array1 = msg.data
        self.merge_and_publish()

    def array_callback2(self, msg):
        self.array2 = msg.data
        self.merge_and_publish()

    def merge_and_publish(self):
        if not self.array1 or not self.array2:
            return
        merged_array = sorted(self.array1 + self.array2)
        msg = Int32MultiArray()
        msg.data = merged_array
        self.publisher.publish(msg)

if __name__ == '__main__':
    rclpy.init()
    node = MergeArraysNode()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()
