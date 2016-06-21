#!/usr/bin/env bash
if xrandr | grep -q "3840"; then
    sed -i "s/^Xft\.dpi: .*$/Xft.dpi: 192/g" ~/.Xresources
else
    sed -i "s/^Xft\.dpi: .*$/Xft.dpi: 96/g" ~/.Xresources
fi
