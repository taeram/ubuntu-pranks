#!/bin/bash

##
# Activate the gnome screensaver
##

SCRIPT_DIR=$(dirname $(readlink -f $0))
source $SCRIPT_DIR/utils.sh

gnome-screensaver-command --activate
