if xrandr | grep -q "^HDMI1 connected"; then
    xrandr --output HDMI1 --auto && xrandr --output eDP1 --off
else
    if grep -q 'Xft\.dpi: 192' ~/.Xresources; then
        xrandr --output eDP1 --mode 1920x1080 --scale 2x2 --panning 3840x2160
    else
        xrandr --output eDP1 --auto
    fi
fi
