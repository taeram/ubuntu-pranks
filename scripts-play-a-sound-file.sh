#!/bin/bash

SCRIPT_DIR=$(dirname $(readlink -f $0))
source $SCRIPT_DIR/utils.sh

SOUND_FILE="$1"
$COMMAND_PREFIX play "$SOUND_FILE"
