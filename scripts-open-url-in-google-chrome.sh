#!/bin/bash

##
# Open an URL in Google Chrome
##

SCRIPT_DIR=$(dirname $(readlink -f $0))
source $SCRIPT_DIR/utils.sh

URL="$1"
google-chrome "$URL"
