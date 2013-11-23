#!/bin/bash

SCRIPT_DIR=$(dirname $(readlink -f $0))
source $SCRIPT_DIR/utils.sh

# Where we'll hide our script, to make it less obvious while running
HIDDEN_SCRIPT_PATH=/usr/local/bin/psx

SPOOFED_USER=$(ask "What is the account name of the user we're pranking?")

if [ -z `cat /etc/passwd | grep $SPOOFED_USER` ]; then
    echoc "danger" "User \"$SPOOFED_USER\" does not exist on this machine"
    exit 1;
fi

sudo tee $HIDDEN_SCRIPT_PATH << EOF
#!/bin/bash
export SPOOFED_USER="$SPOOFED_USER"
export SCRIPT_DIR="$SCRIPT_DIR"
source $SCRIPT_DIR/menu.sh
EOF

sudo chmod 755 $HIDDEN_SCRIPT_PATH

echo "Now, when you want to run the prank script, simply run $HIDDEN_SCRIPT_PATH instead"
