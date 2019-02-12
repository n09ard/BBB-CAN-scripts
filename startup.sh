#!/bin/bash
#################
#
# Script for starting up workspace
#
#################

echo "Try mounting SD-Card"
mount -t ext4 /dev/mmcblk0p1 /media

echo "Try to set time"
./update_time.sh
