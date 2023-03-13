#!/usr/bin/env bash
# man synaptics
# http://www.x.org/archive/X11R7.5/doc/man/man4/synaptics.4.html

synclient PalmDetect=1
synclient PalmMinWidth=1
synclient PalmMinZ=1

synclient PressureMotionMinZ=2
synclient EmulateTwoFingerMinZ=80
synclient EmulateTwoFingerMinW=1

synclient FingerLow=1
synclient FingerHigh=10

synclient AccelFactor=25
synclient MinSpeed=5
synclient MaxSpeed=50

synclient MaxTapTime=100
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

# LeftEdge                = 144
# RightEdge               = 3473
# TopEdge                 = 113
# BottomEdge              = 1989

synclient AreaLeftEdge=868
synclient AreaRightEdge=2605
