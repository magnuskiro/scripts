#!/bin/bash

# sudo apt install fwupd

# list firmware devices
fwupdmgr get-devices

# download updates for the devices/HW
fwupdmgr get-updates

# apply the firmware updates
fwupdmgr update

