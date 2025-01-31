#!/bin/bash
echo -n 'i2c-ELAN06A0:00' > /sys/bus/i2c/drivers/i2c_hid_acpi/unbind
