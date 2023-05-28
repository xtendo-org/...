while true; do
    sinkname=$(pactl get-default-sink)
    muted=$(pactl get-sink-mute $sinkname)
    echo '^fn(Lato-10)' \
      $(date +'%Y-%m-%d (%a) %H:%M') · \
      $(uptime -p) · \
      $(ip --brief addr show | grep '\s\+UP\s\+' | sed -e 's|\([0-9a-z]\{4,\}\)\s\+\([A-Z]\+\)\s\+\([.0-9]\+\)\?\+.*|\1 \3|' | head -c -1 | tr '\n' '/' | sed -e 's|/| / |g') \
      $(iwctl station wlan0 show | grep -m 1 'Connected' | sed -e 's/Connected network/· /') \
      $(iwctl station wlan0 show | grep -m 1 RSSI | grep -o '\-\?[0-9]\+') · \
      $(if [[ $muted =~ "Mute: yes" ]]; then echo MUTE; else pactl get-sink-volume $sinkname | rg -m 1 -o '[0-9]*%' | head -n 1; fi) · \
      $(acpi | sed -e 's/Battery 0: //');
    sleep 3
done | dzen2 -title-name top -y -1 -bg $( [ $(( $(date +%_j) % 2 )) -eq 0 ] && echo black || echo white ) -fg $( [ $(( $(date +%_j) % 2 )) -eq 0 ] && echo white || echo black ) -h 23
