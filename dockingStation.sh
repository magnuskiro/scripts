#!/bin/sh

# script to configure my laptop to use the setup I have at home.

if [ -z "$1" ];
then

# standard docking
    if ( xrandr | grep "VGA1 connected" > /dev/null );
    then # if there is a vga1 screen connected.
    # disengade docking. 
     
    	echo "INFO-- Laptop only mode." 
    	# disconnects keyboard and mouse. 
        #killall synergyc
    
        # reset screen resolutions.
    	xrandr --output VGA1 --off --output LVDS1 --auto
    
    else # if there are no vga1 screen connected.
    # engade docking 
    
    	# screen setup
   		xrandr --output LVDS1 --auto --output VGA1 --primary --auto --left-of LVDS1
    	echo "INFO-- Docking mode."
    
    	# have to connect to synergy after setting the scrren resolutions. 	
    	# connects stationary keyboard and mouse. 
    	#synergyc -n kiro-tp 193.71.111.23
    fi

else 
# projector mode.
	if [ "$1" = "-p" ];
	then
		echo "INFO-- Projector mode."
		xrandr --output LVDS1 --auto --output VGA1 --auto --same-as LVDS1
	elif [ "$1" = "-d" ];
	then
    	echo "INFO-- Docking mode."
   		xrandr --output LVDS1 --auto --output VGA1 --primary --auto --left-of LVDS1
	else
		echo "ERROR: Not a valid param. Use '-p' or nothing"
	fi
	
fi

# TODO set screen resolutions for multiple docking screens

exit 1
