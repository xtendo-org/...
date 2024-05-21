#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xsettingsd &

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

export GTK_OVERLAY_SCROLLING=1
export XMODIFIERS=@im=uim
export GTK_IM_MODULE="uim"
export QT_IM_MODULE="uim"

# set DPI depending on resolution
# source ~/.../lpx/init_monitor.sh
# source ~/.../lpx/monitor.sh

# # if HDMI2 is connected, turn off the laptop monitor
# xrandr | grep '^HDMI2 connected' && xrandr --output eDP1 --off
# xrandr | grep '^HDMI2 connected' && xrandr --output HDMI2 --primary && xrandr --output eDP1 --below HDMI2

# launch basic apps
gnome-terminal --maximize -e ~/.../bin/attachtmux.sh &

export XSECURELOCK_BLANK_TIMEOUT=5
xss-lock xsecurelock &

xmodmap ~/.Xmodmap

# keyboard repetition
xset r rate 300 40

# stop xscreensaver for when a full screen app is running
bash ~/.../arch/xscreensaverstopper.sh &

# # notification
# /usr/lib/notification-daemon-1.0/notification-daemon --debug -r > ~/notification-daemon.txt &

# suppress blue light that is bad for sleeping and long-term vision
# redshift -O 4500K

# xset b 10 30 500
xset -b
# NOTE: configure xkbevd with xkbevd.cf
xkbevd -bg

# feh --bg-fill ~/Desktop/bg.jpg &

pkill xfce4-notifyd
/usr/lib/xfce4/notifyd/xfce4-notifyd &

[ -f ~/.local/xinitrc ] && source ~/.local/xinitrc

compiz --replace
# xmonad
# awesome
