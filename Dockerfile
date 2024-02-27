# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Avoid user interaction with tzdata
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    lsb-release \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Add the ROS 2 apt repository
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/ros2.list

# Install ROS 2 Humble Hawksbill
RUN apt-get update && apt-get install -y ros-humble-ros-base && rm -rf /var/lib/apt/lists/*

# Source the ROS 2 environment
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc \
    apt update \
    apt install python3-colcon-common-extensions



# Run the docker container by mounting merge_array directory!