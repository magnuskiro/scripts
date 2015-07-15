#!/bin/bash

# usage:
# 'BrightnessHPElitebook.sh 500'

#get input arg, number 100 =< x >= 937
number=$@

# set brightness
echo $number > /sys/class/backlight/intel_backlight/brightness

# debug
echo "Set brightness to $number"

