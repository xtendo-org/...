#!/usr/bin/env bash
# man synaptics
# http://www.x.org/archive/X11R7.5/doc/man/man4/synaptics.4.html
synclient PalmDetect=0
synclient PalmMinWidth=10
synclient PalmMinZ=1

synclient PressureMotionMinZ=4
synclient EmulateTwoFingerMinZ=80
synclient EmulateTwoFingerMinW=1

synclient FingerLow=1
synclient FingerHigh=1

synclient AccelFactor=0.1
synclient MinSpeed=0.1
synclient MaxSpeed=7

synclient MaxTapTime=50
synclient MaxTapMove=60
synclient SingleTapTimeout=150
synclient MaxDoubleTapTime=50

synclient TapButton1=1
synclient TapButton2=3
synclient TapButton3=2

synclient VertScrollDelta=-76
synclient HorizScrollDelta=-76
synclient VertTwoFingerScroll=1
synclient HorizTwoFingerScroll=1
