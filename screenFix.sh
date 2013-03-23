# This script should fix the screens of for my laptopsetup.

# Tools
xfce4-display-settings -m(inimal)
xfce4-display-settings

# turn OFF additinal scrren
xrandr --output VGA1 --off
# turn ON additional screen with name VGA1, and putting it to the right of the laptop screen.  
xrandr --output VGA1 --right-of LVDS1


# future work / psudo code:

detect displays
	if  more then one?
		if param "-projector"
			duplicate scrrens
		else
			activate additional screens
			adjust scrrens according to wanted setup.
			potentially have more setups/profiles. -docking -one -right -left -masterspace -whatnot 
	else
		set default laptop screen only.
		xrandr --output VGA1 --off
		 	
