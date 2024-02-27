#!/bin/bash

# Source the ROS2 environment
source /opt/ros/humble/setup.bash

# Build your package
colcon build --packages-select merge_arrays

# Source the local workspace setup file
source install/setup.bash

# Run your node in the background
ros2 run merge_arrays merge_arrays_node &
NODE_PID=$!

# Give the node some time to start
sleep 2

# Publish test messages to the input topics
ros2 topic pub /input/array1 std_msgs/msg/Int32MultiArray "data: [1, 4, 8, 12, 26]" -1 &
PUB1_PID=$!
ros2 topic pub /input/array2 std_msgs/msg/Int32MultiArray "data: [3, 9, 18, 20, 30]" -1 &
PUB2_PID=$!

# Listen to the output topic for a short time to verify the output
timeout 5 ros2 topic echo /output/array

# Cleanup: kill the node and publisher processes
kill $NODE_PID $PUB1_PID $PUB2_PID

echo "Test completed. Check the output above for the merged array."
