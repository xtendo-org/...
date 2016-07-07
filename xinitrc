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

# set DPI depending on resolution
bash ~/.../lpx/init_monitor.sh

xrdb -merge ~/.Xresources

# launch basic apps
xscreensaver -no-splash &
gnome-terminal &

xmodmap ~/.Xmodmap

# keyboard repetition
xset r rate 300 40

# screen off will be managed by xscreensaver
xset -dpms
xset s off
xset s off -dpms

# stop xscreensaver for when a full screen app is running
bash ~/.../arch/xscreensaverstopper.sh &

# touchpad
source ~/.../lpx/configure_touchpad.sh
syndaemon -i 1 -t -k -R -d
compiz --replace
