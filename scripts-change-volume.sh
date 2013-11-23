#!/bin/bash

##
# Change the current master volume from lowest (0DB) to maximum (64DB)
##

SCRIPT_DIR=$(dirname $(readlink -f $0))
source $SCRIPT_DIR/utils.sh

SOUND_LEVEL="$1"
amixer set Master $SOUND_LEVEL
