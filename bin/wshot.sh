#!/bin/bash
screenshot_path="$HOME/screenshots/$(date --iso-8601=seconds).png"
grim -s 1 -g "$(swaymsg -t get_tree | jq -r '.. | select(.focused? == true) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')" $screenshot_path
notify-send "Saved to $screenshot_path"
echo -n $screenshot_path | wl-copy
firefox -P Reset --private-window $screenshot_path
