xrandr | grep -q "^HDMI1 connected" && (xrandr --output eDP1 --off; xrandr --output HDMI1 --auto) || xrandr --output eDP1 --auto --scale 2x2
