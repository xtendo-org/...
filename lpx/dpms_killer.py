#!/usr/bin/env python

import datetime
import subprocess

acpi_listen = subprocess.Popen(['acpi_listen'], stdout=subprocess.PIPE)
while True:
    line = acpi_listen.stdout.readline().decode('ascii')
    print('[%s]' % datetime.datetime.now().isoformat(), line, end='')
    if line.startswith('ac_adapter '):
        print('Turning DPMS off...')
        subprocess.run(['xset', '-dpms'], check=False)
        subprocess.run(['xset', 's', 'off'], check=False)
        subprocess.run(['xset', 's', 'off', '-dpms'], check=False)
