#!/bin/bash

VIDEO_DIR="/home/sudipk/Videos"
PID_FILE="/tmp/livewallpaper.pid"

# Function to stop wallpaper
stop_wallpaper() {
    if [[ -f "$PID_FILE" ]]; then
        OLD_PID=$(cat "$PID_FILE")
        if kill -0 "$OLD_PID" 2>/dev/null; then
            kill "$OLD_PID"
            rm "$PID_FILE"
            echo "Live wallpaper stopped."
        else
            rm "$PID_FILE"
        fi
    else
        echo "No live wallpaper running."
    fi
}

# Check if argument is given
if [[ -z "$1" ]]; then
    echo "Usage: $0 <number> or s"
    exit 1
fi

# If argument is 's', stop the wallpaper
if [[ "$1" == "s" ]]; then
    stop_wallpaper
    exit 0
fi

# If argument is a number
if [[ "$1" =~ ^[0-9]+$ ]]; then
    VIDEO_FILE="$VIDEO_DIR/$1.mp4"
    if [[ ! -f "$VIDEO_FILE" ]]; then
        echo "Video $VIDEO_FILE not found."
        exit 1
    fi

    # Stop old wallpaper if running
    stop_wallpaper

    # Start new wallpaper
    mpv --loop --no-audio --fullscreen --no-border --ontop --wid=$(xdotool getactivewindow) "$VIDEO_FILE" &
    echo $! > "$PID_FILE"
    echo "Playing wallpaper: $VIDEO_FILE"
else
    echo "Should be number or 's'"
fi

