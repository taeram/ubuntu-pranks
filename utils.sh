############################
# Configuration
############################

##
# Get the id of the currently running X windows process. e.g. ":0"
##
export DISPLAY=$( ps aux | grep \/usr\/bin\/X | grep -v grep | sed -e 's/^.*\/X \(:[0-9]*\).*$/\1/' )

##
# Get the id of the mouse, according to xinput
##
export MOUSE_ID=$( xinput list | grep -i mouse | sed -e  's/^.*id=\([0-9]\)*.*$/\1/' )

##
# Print coloured text
#
# @param string $1 The text type. Must be one of: success, info, warning, danger
# @param string $1 The string to echo
##
function echoc {
    BLUE='\e[0;34m'
    RED='\e[0;31m'
    GREEN='\e[0;32m'
    YELLOW='\e[1;33m'
    NORMAL='\e[0m'

    if [ "$1" = "success" ]; then
        echo -e "$GREEN$2$NORMAL"
    elif [ "$1" = "info" ]; then
        echo -e "$BLUE$2$NORMAL"
    elif [ "$1" = "warning" ]; then
        echo -e "$YELLOW$2$NORMAL"
    elif [ "$1" = "danger" ]; then
        echo -e "$RED$2$NORMAL"
    fi
}

############################
# Ask a question and return the response
#
# @param string $1 The question
# @param integer $2 The number of characters to accept as input
#
# @return string
############################
function ask {
    if [ ! -n "$1" ]; then
        echoc "danger" "ask() requires a question to ask"
        exit 1;
    fi

    if [ -z "$2" ]; then
        READ_OPTIONS=""
    else
        READ_OPTIONS="-n $2"
    fi

    YELLOW='\e[1;33m'
    NORMAL='\e[0m'

    read $READ_OPTIONS -p "`echo -en "$YELLOW>>> $1 $NORMAL"`" ANSWER
    echo $ANSWER
}
