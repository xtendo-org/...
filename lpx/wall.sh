#!/usr/bin/env bash

while sleep $(echo 3600 - `date +%s` % 3600 | bc); do
  if grep -q 'Xft\.dpi: 192' ~/.Xresources; then
    width=3838
    height=2158
  else
    width=1918
    height=1078
  fi

  date +'%H:%M:%S' | dzen2 -title-name "job finished" -x 1 -y 1 -w $width -h $height -p 1 -bg black -fg white -fn 'Lato-300' &
  espeak-ng -v en+f4 -a 20 "It's "$(date +%H:%M) &
  wait
done
