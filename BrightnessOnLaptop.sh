#!/bin/bash

# usage:
# 'BrightnessOnLapton.sh -inc 1220'
# 'BrightnessOnLapton.sh -dec 1220'

set -e
file="/sys/class/backlight/intel_backlight/brightness"
current=$(cat "$file")
new="$current"
if [ "$1" = "-inc" ]
then
	new=$(( current + $2 ))
fi
if [ "$1" = "-dec" ]
then
new=$(( current - $2 ))
fi
echo "$new" | tee "$file"

