#!/bin/sh

# Find mouse device id
pointer_id=$(xinput list | grep -m 1 'Mouse  ' | grep -o '[0-9]\+' | head -n 1)

echo $pointer_id

# Disable mouse input
xinput disable $pointer_id

# Lock (blocks until unlock)
xsecurelock

# Enable mouse input
xinput enable $pointer_id
