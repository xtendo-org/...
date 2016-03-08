(xinput list-props 13 | awk '/Device Enabled/ {print $4}' | xargs test 1 ==) && xinput set-prop 13 "Device Enabled" 0 || xinput set-prop 13 "Device Enabled" 1
