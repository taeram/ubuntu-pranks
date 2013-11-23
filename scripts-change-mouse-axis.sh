#!/bin/bash

##
# Swap the mouse axes (1), or switch back to normal (0)
##

SCRIPT_DIR=$(dirname $(readlink -f $0))
source $SCRIPT_DIR/utils.sh

SWAP_MOUSE_AXES=$1
xinput --set-prop $MOUSE_ID 'Evdev Axes Swap' $SWAP_MOUSE_AXES
