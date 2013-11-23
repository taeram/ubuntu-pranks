#!/bin/bash

##
# Renice a running process with the lowest (slowest) priority
##

SCRIPT_DIR=$(dirname $(readlink -f $0))
source $SCRIPT_DIR/utils.sh

PROGRAM_NAME="$1"
ps aux | grep "$PROGRAM_NAME" | grep -v grep | awk '{print "sudo renice "$2" 19"}'
