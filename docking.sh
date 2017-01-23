#!/bin/bash

: <<'END'

Comments, requirements and userguide here. 

## Description
Script to configure external screens with xrandr.

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

print_help () {
    echo "Use 'dock' with: "
    echo "    '-b' battle station configuration"
    echo "    '-h' help, print this help text"
    echo "    '-k' kudos configuration"
    echo "    '-p' projector mode, same picture on both laptop and VGA1"
    echo "    '-w' work configuration"
    echo "    '' (no parameters) reset screens"
}

reset_screen () {
    echo INFO-- Reset configuration to first screen only. 
    screens=( $(xrandr | grep "connected" | grep -o "^[^ ]*") )

    # turn off all other screens. 
    for screen in "${screens[@]}"
    do
        # not the first in the array, that is usually the laptop screen. 
        if [ "$screen" != "${screens[0]}" ];
        then 
            echo "$screen --off"
            xrandr --output $screen --off
        fi
    done
    
    # set the first screen to what it should be.
    echo ${screens[0]}
    xrandr --output ${screens[0]} --primary --auto

    # set the brightness of the display to low.
    BrightnessHPElitebook.sh 150
}

projector_mode () {
    # gets the name of the connected screens for this computer. 
    screens=( $(xrandr | grep " connected" | grep -o "^[^ ]*") )
    
    # set the first screen to what it should be.
    echo ${screens[0]}
    xrandr --output ${screens[0]} --auto

    # set the rest as the same as the first one. 
    for screen in "${screens[@]}"
    do
        if [ "$screen" != "${screens[0]}" ];
        then 
            echo $screen --same as ${screens[0]}
            xrandr --output $screen --same-as ${screens[0]}
        fi
    done
    echo "INFO-- Projector mode. Same image on all screens."
}

# no arguments 
if [ $# -eq 0 ];
then
    # reset screen resolution to standard.
    reset_screen
    exit 1
fi

# Parsing input arguments 
while getopts "bdhkpwsp:" opt; do
  case $opt in
    b)  # battle station configuration
        xrandr --output HDMI-0 --mode 1920x1080 --left-of DVI-0 --noprimary --output DVI-0 --auto --output DVI-1 --auto --right-of
    ;;
    d)
        dual_screen
    ;;
    h)  # print help info.
        print_help
    ;;
    k)  # Kudos configuration
        xrandr --output DP2 --auto --above eDP1
    ;;
    p)  # Projector
        projector_mode
    ;;
    w)  # work configuration
        xrandr --output DP1 --auto --primary --output eDP1 --auto --left-of DP1
        BrightnessHPElitebook.sh 475 # adjust brightness of elitebook 
    ;;
    s)
        xrandr --output DP1 --auto --primary --output DP2 --auto --right-of DP1
    ;;
    \?) # default / invalid option
        echo "Invalid option: -$OPTARG, use '-h' for help." >&2 
    ;;
  esac
done 

exit 1
