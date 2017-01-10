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

