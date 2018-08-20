#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

export GTK_OVERLAY_SCROLLING=1
export XMODIFIERS=@im=uim
export GTK_IM_MODULE="uim"
export QT_IM_MODULE="uim"

# set DPI depending on resolution
source ~/.../lpx/init_monitor.sh
source ~/.../lpx/monitor.sh

# if HDMI2 is connected, turn off the laptop monitor
xrandr | grep '^HDMI2 connected' && xrandr --output eDP1 --off

# xrdb -merge ~/.Xresources

# launch basic apps
xscreensaver -no-splash &
# gnome-terminal &

xmodmap ~/.Xmodmap

# keyboard repetition
xset r rate 300 40

# stop xscreensaver for when a full screen app is running
bash ~/.../arch/xscreensaverstopper.sh &

# fullscreen clock
# ~/.../lpx/wall.sh &

# touchpad
source ~/.../lpx/configure_touchpad.sh
syndaemon -i 1 -t -k -R -d

# notification
/usr/lib/notification-daemon-1.0/notification-daemon --debug -r > ~/notification-daemon.txt &

gnome-terminal &

# suppress blue light that is bad for sleeping and long-term vision
redshift -O 4500K

xset -b
compiz --replace
