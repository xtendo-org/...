#!/usr/bin/env python

import datetime
import subprocess

def dpms_off():
    subprocess.run(['xset', '-dpms'], check=False)
    subprocess.run(['xset', 's', 'off'], check=False)
    subprocess.run(['xset', 's', 'off', '-dpms'], check=False)
    subprocess.run(['bash', '-c', 'echo "DPMS off" | dzen2 -title-name "job finished" -x 10 -y 10 -w 200 -h 50 -p 2 -bg orange -fg black -fn Lato-10'])

dpms_off()

acpi_listen = subprocess.Popen(['acpi_listen'], stdout=subprocess.PIPE)
while True:
    line = acpi_listen.stdout.readline().decode('ascii')
    if line.startswith('ac_adapter '):
        dpms_off()
