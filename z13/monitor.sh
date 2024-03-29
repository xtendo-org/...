#!/bin/bash

if xrandr | rg -q "^DP-1 connected"; then
    xrandr --output DP-1 --auto --primary && xrandr --output eDP-1 --mode 1920x1080 --scale 2x2 --panning 3840x2160 && xrandr --output eDP-1 --off
    exit
fi

if xrandr | rg -q "^DP-2 connected"; then
    xrandr --output DP-2 --auto --primary && xrandr --output eDP-1 --off
    exit
fi

if grep -q 'Xft\.dpi: 192' ~/.Xresources; then
    xrandr --output eDP-1 --mode 1920x1200 --scale 2x2 # --panning 3840x2160
    exit
fi

xrandr --output eDP-1 --auto
