#!/bin/bash

# if input argument, change to single screen gaming mode. 
if [ -n "$1" ];
then 
    xrandr --output DisplayPort-0 --off 
else
	# reset Stout standard display settings. 
	xrandr --output HDMI-0 --auto --primary
	xrandr --output DisplayPort-0 --mode 1920x1080 --right-of HDMI-0
fi


