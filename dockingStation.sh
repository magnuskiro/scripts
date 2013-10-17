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
		if [ -z "$2" ];
		then # std resolution
			std='1024x768'
			xrandr --output LVDS1 --mode $std --output VGA1 --mode $std --same-as LVDS1
		else # resolution input as arg
			xrandr --output LVDS1 --mode $2 --output VGA1 --mode $2 --same-as LVDS1
		fi
		echo "INFO-- Projector mode. Same image on both screens."
	# TODO create mode for single, external screen only. 
	elif [ "$1" = "-d" ]; # Home. 
	then
   		xrandr --output LVDS1 --off --output VGA1 --primary --auto --left-of LVDS1
    	echo "INFO-- Docking mode at home. Only external screen, Full resolution."
	elif [ "$1" = "-h" ]; # Help
	then
		echo "Use 'dock' with '-p', '-d' or no parameter" 
	else
		echo "ERROR: Not a valid param. 'dock -h' for help"
	fi
	
fi

# TODO set screen resolutions for multiple docking screens

exit 1
