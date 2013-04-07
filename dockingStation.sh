#!/bin/sh

# script to configure my laptop to use the setup I have at home.

# TODO dock only on local network.  
# if ip is in range 192.168.1.0/24
if ! pidof synergyc ; then
	# connects stationary keyboard and mouse. 
	synergyc -n kiro-tp 193.71.111.23

	# screen setup 
else 
	# disconnects keyboard and mouse. 
	killall synergyc

	# reset screen resolutions.
	
fi



# TODO set screen resolutions for multiple docking screens

# TODO add different profiles for different docking places. (undocked, home, school, work)

