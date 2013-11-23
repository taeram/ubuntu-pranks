#!/bin/bash

##
# Sensitivity can be from 1 (fastest) to 10 (slowest)
##

SCRIPT_DIR=$(dirname $(readlink -f $0))
source $SCRIPT_DIR/utils.sh

MOUSE_SENSITIVITY=$1
xinput --set-prop $MOUSE_ID 'Device Accel Constant Deceleration' $MOUSE_SENSITIVITY
