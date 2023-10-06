resolution=$(xrandr | rg '\*' | awk '{print $1}')

case $resolution in
  1920x1080)
    thickness=24
    ;;
  1920x1200)
    thickness=25
    ;;
  3840x2160)
    thickness=46
    ;;
  *)
    thickness=24
esac

if [ $(( $(date +%_j) % 2 )) -eq 0 ]; then
  BGCOLOR="black"
  FGCOLOR="white"
else
  BGCOLOR="white"
  FGCOLOR="black"
fi

echo "Resolution is $resolution. Bar thickness is $thickness."

while true; do
    sinkname=$(pactl get-default-sink)
    muted=$(pactl get-sink-mute $sinkname)
    echo '^fn(Lato-10)' \
      $(date +'%Y-%m-%d (%a) %H:%M') \
      '^fn(Noto Emoji-10)⏳^fn(Lato-10)' $(uptime -p) \
      $(ip --brief addr show | grep '\s\+UP\s\+' | grep -v '\(docker\|veth\)' | sed -e 's|\([0-9a-z]\{4,\}\)\s\+\([A-Z]\+\)\s\+\([.0-9]\+\)\?\+.*|\1 ^fn(Noto Emoji-10)📪^fn(Lato-10) \3|' | head -c -1 | tr '\n' '/' | sed -e 's|/| / |g' -e 's|^|\^fn(Noto Emoji-10)🌏^fn(Lato-10) |') \
      $(iwctl station wlan0 show | grep -m 1 'Connected' | sed -e 's/Connected network/^fn(Noto Emoji-10)🛜^fn(Lato-10) /') \
      $(iwctl station wlan0 show | grep -m 1 RSSI | grep -o '\-\?[0-9]\+' | sed -e 's|^-|^fn(Noto Emoji-10)📶^fn(Lato-10) -|') \
      $(if [[ $muted =~ "Mute: yes" ]]; then echo '^fn(Noto Emoji-10)🔇^fn(Lato-10) MUTE'; else echo '^fn(Noto Emoji-10)🔊^fn(Lato-10)'; pactl get-sink-volume $sinkname | rg -m 1 -o '[0-9]*%' | head -n 1; fi) \
      $(acpi | sed -e 's/Battery 0: /^fn(Noto Emoji-10)🔋^fn(Lato-10)/' -e 's/Discharging/\^bg(red) Discharging/');
    sleep 3
done | dzen2 -title-name top -y -1 -bg $BGCOLOR -fg $FGCOLOR -h $thickness
