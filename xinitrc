#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

export GTK_OVERLAY_SCROLLING=1
export XMODIFIERS=@im=uim
export GTK_IM_MODULE="uim"
export QT_IM_MODULE="uim"

xrdb -merge ~/.Xresources
xmodmap ~/.Xmodmap

# keyboard repetition
xset r rate 300 40

# touchpad
source ~/.../lpx/configure_touchpad.sh
syndaemon -i 2 -t -k &

xscreensaver &
gnome-terminal &
compiz --replace
