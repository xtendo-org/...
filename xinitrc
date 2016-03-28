#!/bin/sh

export GTK_OVERLAY_SCROLLING=1
export XMODIFIERS=@im=uim
export GTK_IM_MODULE="uim"
export QT_IM_MODULE="uim"

xrdb -merge ~/.Xresources
xmodmap ~/.Xmodmap

# keyboard repetition
xset r rate 300 40
# idle screen off
xset s 300 300

# touchpad
source ~/.../lpx/configure_touchpad.sh
syndaemon -i 2 -t -k &

gnome-screensaver &
source ~/.../lpx/monitor.sh
compiz --replace
