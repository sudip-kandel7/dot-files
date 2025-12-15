#!/bin/bash

# Launch VS Code
code >/dev/null 2>&1 &
sleep 1
hyprctl dispatch movetoworkspace 1 $(hyprctl activewindow | awk '{print $1}')

# Launch Chrome
google-chrome-stable >/dev/null 2>&1 &
sleep 2
hyprctl dispatch movetoworkspace 2 $(hyprctl activewindow | awk '{print $1}')

# Launch Kitty
kitty >/dev/null 2>&1 &
sleep 1
hyprctl dispatch movetoworkspace 3 $(hyprctl activewindow | awk '{print $1}')

# Finally, switch to workspace 1
hyprctl dispatch workspace 1

