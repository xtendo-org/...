#!/bin/bash
while ! swaymsg -t get_version > /dev/null 2>&1; do sleep 0.1; done
swayidle -w \
  timeout 600 'swaymsg output * dpms off' \
  resume 'swaymsg output * dpms on' \
  timeout 1200 "waylock -fork-on-lock" \
  before-sleep "waylock -fork-on-lock"
