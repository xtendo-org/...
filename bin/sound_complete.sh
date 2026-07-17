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
        ffplay -nodisp -autoexit -loglevel quiet /usr/share/sounds/freedesktop/stereo/message-new-instant.oga
        ;;
    esac
    ;;
  *)
    ffplay -nodisp -autoexit -loglevel quiet /usr/share/sounds/freedesktop/stereo/message-new-instant.oga
    ;;
esac
