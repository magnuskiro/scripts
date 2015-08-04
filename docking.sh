#!/bin/bash

: <<'END'

Comments, requirements and userguide here. 

## Description
This is a bash script template. To quickly create good and powerfull scripts.  

## Requirements
You need these packages or programs for this script to work. 

## Use: 
* one parameter
bash_program -a
* multiple parameters without extra input.
bash_program -bac
* multiple parameters with input. 
bash_program -a a-param-input -b another_input_value

END

dual_screen () {
	#xrandr --output LVDS1 --off --output VGA1 --primary --auto --left-of LVDS1
    xrandr --output LVDS1 --off
    xrandr --output HDMI1 --primary --auto --output VGA1 --auto --left-of HDMI1
    echo "INFO-- Dual screens. Full resolution both screens, laptop screen off."
}

external_screen () {
	xrandr --output LVDS1 --off --output VGA1 --primary --auto
}

print_help () {
	echo "Use 'dock' with: "
	echo "	'-e' external screen, laptop off."
	echo "	'-d' dual screen, laptop off."
	echo "	'-h' help, print this help text."
	echo "	'-r' reset, laptop opnly,"
	echo "	'-p' projector mode, same picture on both laptop and VGA1"
	echo "	'-s' external vga1 main + laptop"
	echo "	'' no parameter, toggle VGA1 auto on/off"
}

reset_screen () {
	# reset screen resolutions.
    xrandr --output HDMI1 --off
    xrandr --output VGA1 --off
	xrandr --output DP1 --off
	xrandr --output DP2 --off
    xrandr --output LVDS1 --auto # thinkpad x201 laptop screen.
    xrandr --output eDP1 --auto # netlight-kiro laptop screen.
}

projector_mode () {
	if [ -n "$1" ];  
    then 
	# resolution input as arg
        xrandr --output LVDS1 --mode $1 --output VGA1 --mode $1 --same-as LVDS1
    else 
	# standard resolution
        std='1024x768'
        xrandr --output LVDS1 --mode $std --output VGA1 --mode $std --same-as LVDS1
    fi
    echo "INFO-- Projector mode. Same image on both screens."
}

single_screen () {
	xrandr --output LVDS1 --auto --output VGA1 --primary --auto --right-of LVDS1
    echo "INFO-- Input External Screen - VGA"
}

# no arguments 
if [ $# -eq 0 ];
then
	# reset screen resolution to standard.
	reset_screen
    exit 1
fi

# Parsing input arguments 
while getopts "wdhrpp:s" opt; do
  case $opt in
	# dual
    d)
		dual_screen
	;;
	# External screen only	
	e) 
		external_screen
	;;
	# help
	h)
		print_help
	;;
	# reset
	r)
		reset_screen
	;;
	# projector
	p)
		projector_mode $2
	;;
	# single screen + laptop. 
    s)  
		single_screen
	;;
	w)
	xrandr --output DP2 --auto --primary --output HDMI1 --auto --right-of DP2 --output eDP1 --auto --left-of DP2
	;;
	# default / invalid option
    \?) 
		echo "Invalid option: -$OPTARG, use '-h' for help." >&2 
	;;
  esac
done 

exit 1
