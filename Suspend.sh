#!/bin/bash

# sudo, so we can enter the password for suspending.
sudo echo "Screen reset, locking and Suspending"

# reset screens to laptop only.
~/repos/scripts/docking.sh
sleep 2

# activating screen saver and locking computer.
xscreensaver-command -lock & 
sleep 2

# Suspending.
sudo pm-suspend

echo "Woke from sleep."

# old suspend code. Worked with thinkpad x201 on LMDE 1 
#xscreensaver-command -lock &&
#dbus-send --system --print-reply --dest=org.freedesktop.Hal \
#    /org/freedesktop/Hal/devices/computer \
#    org.freedesktop.Hal.Device.SystemPowerManagement.Suspend int32:0 \

