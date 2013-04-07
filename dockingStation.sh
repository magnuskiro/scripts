#!/bin/sh

# script to configure my laptop to use the setup I have at home.

# if ip is in range 192.168.1.0/24
if ! pidof synergyc ; then

	# screen setup
	xrandr --output LVDS1 --primary
	xrandr --output VGA1 --auto --left-of LVDS1 

	# have to connect to synergy after setting the scrren resolutions. 	
	# connects stationary keyboard and mouse. 
	synergyc -n kiro-tp 193.71.111.23
else 
	# disconnects keyboard and mouse. 
	killall synergyc

	# reset screen resolutions.
	xrandr --output VGA1 --off
fi



# TODO set screen resolutions for multiple docking screens

# TODO add different profiles for different docking places. (undocked, home, school, work)

