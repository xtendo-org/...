font="source han sans kr"

checkFullscreen()
{
  # enumerate all the attached screens
  displays=""
  while read id
  do
    displays="$displays $id"
  done< <(xvinfo | sed -n 's/^screen #\([0-9]\+\)$/\1/p')

  # loop through every display looking for a fullscreen window
  for display in $displays
  do
    #get id of active window and clean output
    activ_win_id=`DISPLAY=:0.${display} xprop -root _NET_ACTIVE_WINDOW`
    activ_win_id=${activ_win_id:40:9}
    # Check if Active Window (the foremost window) is in fullscreen state
    isActivWinFullscreen=`DISPLAY=:0.${display} xprop -id $activ_win_id | grep _NET_WM_STATE_FULLSCREEN`
    if [[ "$isActivWinFullscreen" == *NET_WM_STATE_FULLSCREEN* ]];then
      echo '^lower()'
    else
      echo '^raise()'
    fi
  done
}

command -v iwctl > /dev/null && iwctl_exists=true

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
    short_sinkname=$(echo $sinkname | sed -e 's/.*\.//')

    if [ "$iwctl_exists" = true ]; then
      wireless_info=$(iwctl station wlan0 show)
    fi
    echo "^fn($font-10)" \
      $(date +'%Y-%m-%d (%a) %H:%M') \
      "^fn(Noto Emoji-10)⏳^fn($font-10)" $(uptime -p) \
      "^fn(Noto Emoji-10)💾^fn($font-10)" $(free -h | awk '/^Mem:/ {mem=$4} /^Swap:/ {swap=$4} END {print mem " / " swap}') \
      $(ip --brief addr show | grep '\s\+UP\s\+' | grep -v '^\(docker\|veth\|br-\)' | sed -e "s|\([0-9a-z]\{4,\}\)\s\+\([A-Z]\+\)\s\+\([.0-9]\+\)\?\+.*|\1 ^fn(Noto Emoji-10)📪^fn($font-10) \3|" | head -c -1 | tr '\n' '/' | sed -e 's|/| / |g' -e 's|^|\^fn(Noto Emoji-10)🌏^fn($font-10) |') \
      $(if [ "$iwctl_exists" = true ]; then
        echo "$wireless_info" | grep -m 1 'Connected' | sed -e "s/Connected network/^fn(Noto Emoji-10)🛜^fn($font-10) /"
        echo "$wireless_info" | grep -m 1 RSSI | grep -o '\-\?[0-9]\+' | sed -e "s|^-|^fn(Noto Emoji-10)📶^fn($font-10) -|"
      fi) \
      $(if [[ $muted =~ "Mute: yes" ]]; then echo "^fn(Noto Emoji-10)🔇^fn($font-10) MUTE"; else echo "^fn(Noto Emoji-10)🔊^fn($font-10)"; pactl get-sink-volume $sinkname | rg -m 1 -o '[0-9]*%' | head -n 1; fi) \
      "^fg(#999999)$short_sinkname^fg($FGCOLOR)" \
      $(acpi | sed -e "s/Battery 0: /^fn(Noto Emoji-10)🔋^fn($font-10)/" -e 's/Discharging/\^bg(red)^fg(white) Discharging/') \
      '';
    checkFullscreen
    sleep 3
done | dzen2 -title-name top -y -1 -bg $BGCOLOR -fg $FGCOLOR -h $thickness
