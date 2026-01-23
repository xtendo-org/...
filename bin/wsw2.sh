#!/usr/bin/env bash
row=$(swaymsg -t get_tree | jq -r '
    ..
    | objects
    | select(.type == "workspace") as $ws
    | ..
    | objects
    | select(has("app_id"))
    | (if .focused == true then "*" else " " end) as $asterisk
    | (
        if .window_properties.class == "Spotify" then "spotify-client" 
        elif .window_properties.class == "LM Studio" then "lm-studio" 
        else .app_id // .window_properties.class // .name 
      end ) as $icon_name
    | "[\($ws.name)] \($asterisk) <span weight=\"bold\">\(.app_id // .window_properties.class)</span>  - \(.name) <!-- \(.id) -->\u0000icon\u001f\($icon_name)"
    ' |
	sed 's/&/&amp;/g' |
	rofi -dmenu -show-icons -markup-rows -p "window")

if [ ! -z "$row" ]; then
	winid=$(echo "$row" | sed 's/.*<!-- \([0-9]*\) -->.*/\1/')
	swaymsg "[con_id=$winid] focus"
fi
