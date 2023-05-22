while true; do
    echo '^fn(Lato-12)' \
      $(date +'%Y-%m-%d (%a) %H:%M') · \
      $(uptime -p) · \
      $(ip --brief addr show | grep '\s\+UP\s\+' | sed -e 's|\([0-9a-z]\{4,\}\)\s\+\([A-Z]\+\)\s\+\([.0-9]\+\)\?\+.*|\1 \3|' | head -c -1 | tr '\n' '/' | sed -e 's|/| / |g') \
      $(iwctl station wlan0 show | grep -m 1 'Connected' | sed -e 's/Connected network/· /') \
      $(iwctl station wlan0 show | grep -m 1 RSSI | grep -o '\-\?[0-9]\+') · \
      $(acpi | sed -e 's/Battery 0: //');
    sleep 3
done | dzen2 -title-name up -y -1 -bg $( [ $(( $(date +%_j) % 2 )) -eq 0 ] && echo black || echo white ) -fg $( [ $(( $(date +%_j) % 2 )) -eq 0 ] && echo white || echo black ) -h 32
