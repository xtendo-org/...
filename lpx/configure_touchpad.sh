#!/usr/bin/env bash
# man synaptics
# http://www.x.org/archive/X11R7.5/doc/man/man4/synaptics.4.html
synclient PalmDetect=1
synclient PalmMinWidth=8
synclient PalmMinZ=1

synclient PressureMotionMinZ=30
synclient EmulateTwoFingerMinZ=100
synclient EmulateTwoFingerMinW=1

synclient FingerLow=5
synclient FingerHigh=15

synclient AccelFactor=0.15
synclient MinSpeed=0.5
synclient MaxSpeed=6

synclient MaxTapTime=100
synclient MaxTapMove=50
synclient SingleTapTimeout=200

synclient TapButton2=3
synclient TapButton3=2

synclient VertScrollDelta=-76
synclient HorizScrollDelta=-76
synclient VertTwoFingerScroll=1
synclient HorizTwoFingerScroll=1
