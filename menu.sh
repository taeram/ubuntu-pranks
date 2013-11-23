# Who are we running these commands as
if [ -z "$SPOOFED_USER" ]; then
    cat << EOF
Usage: export SPOOFED_USER=[username]
   * [username] is the user on the machine we are pranking
EOF
    exit 1
fi

# Include the variables
source $SCRIPT_DIR/utils.sh

# Print the menu
while [ "$PRANK_ID" != "q" ]; do
    cat << EOF

================================================================================
                             Available Pranks
================================================================================

    1. Activate Screensaver
    2. Swap Mouse Axes (enable)
    3. Swap Mouse Axes (disable)
    4. Change Mouse Sensitivity (incredibly slow)
    5. Change Mouse Sensitivity (normal)
    6. Kill a program
    7. Renice a program with the lowest priority (slowest operation)
    8. Play some white noise
    9. Change volume to 0%
    a. Change volume to 50%
    b. Change volume to 100%
    c. Open an URL in Google Chrome
    d. Change the wallpaper

    q. Quit

EOF

    PRANK_ID=$(ask "Choose a prank" 1)
    echo

    SCRIPT=""
    case $PRANK_ID in
        1)
            SCRIPT="$SCRIPT_DIR/scripts-activate-screensaver.sh"
            ;;
        2)
            SCRIPT="$SCRIPT_DIR/scripts-change-mouse-axis.sh 1"
            ;;
        3)
            SCRIPT="$SCRIPT_DIR/scripts-change-mouse-axis.sh 0"
            ;;
        4)
            SCRIPT="$SCRIPT_DIR/scripts-change-mouse-sensitivity.sh 10"
            ;;
        5)
            SCRIPT="$SCRIPT_DIR/scripts-change-mouse-sensitivity.sh 1"
            ;;
        6)
            PROCESS_NAME=$( ask "Enter a program process name" )
            if [ -z "$PROCESS_NAME" ]; then
                echoc "danger" "No process name specified"
            else
                SCRIPT="$SCRIPT_DIR/scripts-killall-programs.sh $PROCESS_NAME"
            fi
            ;;
        7)
            PROCESS_NAME=$( ask "Enter a program process name" )
            if [ -z "$PROCESS_NAME" ]; then
                echoc "danger" "No process name specified"
            else
                SCRIPT="$SCRIPT_DIR/scripts-renice-programs.sh $PROCESS_NAME"
            fi
            ;;
        8)
            SCRIPT="$SCRIPT_DIR/scripts-play-a-sound-file.sh $SCRIPT_DIR/media-whisper.wav"
            ;;
        9)
            SCRIPT="$SCRIPT_DIR/scripts-change-volume.sh 0DB"
            ;;
        a)
            SCRIPT="$SCRIPT_DIR/scripts-change-volume.sh 32DB"
            ;;
        b)
            SCRIPT="$SCRIPT_DIR/scripts-change-volume.sh 64DB"
            ;;
        c)
            URL=$( ask "What's the URL?" )
            SCRIPT="$SCRIPT_DIR/scripts-open-url-in-google-chrome.sh $URL"
            ;;
        d)
            WALLPAPER_PATH=$( ask "Enter the (local) path to the new wallpaper")

            # Does our new wallpaper exist
            if [ ! -e "$WALLPAPER_PATH" ]; then
                echoc "danger" "Can't find new wallpaper at: $WALLPAPER_PATH"
            else
                # Chown the wallpaper properly
                TEMP_WALLPAPER=`mktemp`
                cp "$WALLPAPER_PATH" $TEMP_WALLPAPER
                chown $SPOOFED_USER:$SPOOFED_USER "$TEMP_WALLPAPER"

                SCRIPT="$SCRIPT_DIR/scripts-change-wallpaper.sh $TEMP_WALLPAPER $SPOOFED_USER"
            fi
            ;;
        q)
            echoc "info" "Exiting..."
            exit 0;
            ;;
        *)
            echo
            echoc "danger" "Unknown Prank ID: $PRANK_ID"
            echo
            ;;
    esac

    if [ ! -z "$SCRIPT" ]; then
        sudo su -s /bin/sh -c 'exec "$0" "$@"' $SPOOFED_USER $SCRIPT
    fi
done
