#!/bin/bash
swayidle timeout 1 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' &
pid=$!
echo "pid=$pid"
pactl set-sink-mute @DEFAULT_SINK@ 1
waylock
kill "$pid"
wait "$pid"
echo "exit=$?"
