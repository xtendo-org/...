#!/bin/bash
swayidle timeout 1 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' &
pid=$!
echo "pid=$pid"
waylock
kill "$pid"
wait "$pid"
echo "exit=$?"
