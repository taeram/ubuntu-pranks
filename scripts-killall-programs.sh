#!/bin/bash

##
# Kill all programs matching a specific string
##

SCRIPT_DIR=$(dirname $(readlink -f $0))
source $SCRIPT_DIR/utils.sh

PROGRAM_NAME="$1"
ps aux | grep "$PROGRAM_NAME" | grep -v grep | grep -v `basename $0` | awk '{print "sudo kill -9 "$2}' | sh
