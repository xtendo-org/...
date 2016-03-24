#!/usr/bin/env bash
(xinput list-props 13 | awk '/Device Enabled/ {print $4}' | xargs test 1 ==) && export TOUCHPAD=0 || export TOUCHPAD=1
xinput set-prop 13 "Device Enabled" $TOUCHPAD
echo $TOUCHPAD | sudo tee "/sys/class/leds/input0::capslock/brightness" > /dev/null
