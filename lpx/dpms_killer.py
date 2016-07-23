#!/usr/bin/env python

import subprocess


def dpms_off():
    subprocess.run(['xset', '-dpms'], check=False)
    subprocess.run(['xset', 's', 'off'], check=False)
    subprocess.run(['xset', 's', 'off', '-dpms'], check=False)
    subprocess.run([
        'bash', '-c', 'echo "DPMS off"'
        ' | dzen2 -title-name "job finished"'
        ' -x 10 -y 10 -w 200 -h 50 -p 2 -bg orange -fg black -fn Lato-10'
    ])

dpms_off()

acpi_listen = subprocess.Popen(['acpi_listen'], stdout=subprocess.PIPE)
while True:
    try:
        line = acpi_listen.stdout.readline().decode('ascii')
        if line == 'battery PNP0C0A:03 00000080 00000001\n':
            continue
        if line == 'battery PNP0C0A:03 00000081 00000001\n':
            continue
        if (
            line.startswith('ac_adapter ') or
            line.startswith('battery ') or
            line.startswith('button/lid ')
        ):
            print(line, end='')
            dpms_off()
    except KeyboardInterrupt:
        break
    except Exception as e:
        print(e)
        pass
