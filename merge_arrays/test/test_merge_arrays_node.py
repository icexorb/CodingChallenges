import rclpy
from unittest.mock import Mock
import pytest
from merge_arrays.merge_arrays_node import MergeArraysNode

@pytest.fixture
def node():
    rclpy.init()
    merge_arrays_node = MergeArraysNode()
    merge_arrays_node.publisher = Mock()
    yield merge_arrays_node
    rclpy.shutdown()

def test_array_merge(node):
    node.array1 = [1, 4, 8, 12, 26]
    node.array2 = [3, 9, 18, 20, 30]
    node.merge_and_publish()
    
    # Check if the publish method was called with the correct data
    expected_data = [1, 3, 4, 8, 9, 12, 18, 20, 26, 30]
    actual_data = list(node.publisher.publish.call_args[0][0].data)
    assert actual_data == expected_data, "The arrays were not merged correctly."
