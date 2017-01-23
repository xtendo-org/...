#!/usr/bin/env bash

if grep -q 'Xft\.dpi: 192' ~/.Xresources; then
    width=3838
    height=2158
else
    width=1918
    height=1078
fi

while sleep $(echo 120 - `date +%s` % 120 | bc); do
    date +'%H:%M:%S' | dzen2 -title-name "job finished" -x 1 -y 1 -w $width -h $height -p 1 -bg black -fg white -fn 'Lato-300'
done
