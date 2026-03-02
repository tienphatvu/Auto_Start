#!/bin/bash

# kill all running processes under the current user
# killall -u $USER 
# # xterm -e "killall -u mic-730ai -w; sleep 20s" &
# sleep 20s

FLEET_DIR="$(dirname "$(pwd)")"
echo "FLEET_DIR is: ${FLEET_DIR}"

MODE=$1
echo "MODE is: ${MODE}"

#---------------
# WINDOWS TITLEs
#---------------
ROBOT_NODE_NM="ROBOT_NODES"
BRIDGE_NODE_NM="BRIDGE_NODES"

#---------------
# ROS ENVIRONMENT
#---------------
sleep 2s
ROS_WS="/opt/ros/humble"
ROS_BIN="$ROS_WS/bin/ros2"
ROS_ENV="$ROS_WS/setup.bash"
AMR_WS=$(dirname $(dirname $(readlink -f "$0")))
AMR_VAR_ENV="$AMR_WS/amr_variables.bash"
source $AMR_VAR_ENV
source $AMR_WS/log_dir.bash


# start all the nodes
sleep 15s
if [[ "$MODE" == "DEBUG" ]]; then
    echo "DEBUG mode is active"
    sleep 5s
    xterm -hold -T "${ROBOT_NODE_NM}" -e "cd $AMR_DIR; source ${ROS_ENV}; source ${AMR_ENV}; ros2 launch scripts fleet.launch.py; bash" &
    echo "Done in launching all nodes"
else
    echo "DEBUG mode is unactive"
    $ROS_BIN launch scripts fleet.launch.py &> $AMR_LOG_NOW/fleet.txt &
    sleep 5s
    echo "Done in launching all nodes"
fi