#!/bin/bash
if pamixer --get-mute | grep -q true; then
 pamixer -u
else
 pamixer -i 5
fi
