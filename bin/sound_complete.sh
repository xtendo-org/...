#!/bin/sh
echo "[$(date --iso-8601=seconds)] "$@ >> /tmp/sound_complete.log
case "$1" in
  volumecontrol)
    ;;
  Firefox)
    case "$2" in
      *"Text Channels"*)
        ;;
      *)
        mplayer /usr/share/sounds/freedesktop/stereo/message-new-instant.oga
        ;;
    esac
    ;;
  *)
    mplayer /usr/share/sounds/freedesktop/stereo/message-new-instant.oga
    ;;
esac
