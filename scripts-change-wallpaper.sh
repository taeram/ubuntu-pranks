#!/bin/bash

##
# Backup, and then change a users wallpaper
##

SCRIPT_DIR=$(dirname $(readlink -f $0))
source $SCRIPT_DIR/utils.sh

WALLPAPER_PATH="$1"
SPOOFED_USER="$2"
WALLPAPER_DESTINATION=$( sudo cat /home/$SPOOFED_USER/.config/gnome-control-center/backgrounds/last-edited.xml | grep filename | sed -e 's/^.*<filename>//' -e 's/<\/filename>.*$//' )
WALLPAPER_BACKUP="$SCRIPT_DIR/media-wallpaper.bak"

# Did we find the users wallpaper path?
if [ -z "$WALLPAPER_DESTINATION" ]; then
    echoc "danger" "Can't detect current wallpaper setting for $SPOOFED_USER"
    exit 1;
fi
echoc "info" "Found current wallpaper at $WALLPAPER_DESTINATION"

# Have we already created a backup of the orignial wallpaper?
if [ ! -e "$WALLPAPER_BACKUP" ]; then
    echoc "info" "Backing up original wallpaper to $WALLPAPER_BACKUP"
    sudo cp "$WALLPAPER_DESTINATION" "$WALLPAPER_BACKUP"
fi

# Copy over the new wallpaper
cp "$WALLPAPER_PATH" "$WALLPAPER_DESTINATION"
