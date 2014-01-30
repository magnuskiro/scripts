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

Function () {
    a="variable"
    echo $a printed
}

anotherOne () {
	echo "bach functions"
}

# Input gathering. 
# "ab:c:" is the allowed input parameters. 
# 'b:' means that we have a possible -b parameter with a following variable. 
# 'a' means that we have a possible parameter without a following input.
# the sequence of options matters. '-b input -a' might give faulty results. 
while getopts "ab:c:" opt; do
  case $opt in
	# -a
    a)  
		# here we do stuffs 
		echo "-a was specified"  
	;;
	# -b 
    b)  
		# here we do something else.
		echo "arg given to b is $OPTARG" 
	;;
	# -c
    c)  
		# and another one. 
		echo "-c was specified"  
	;;
	# invalid options 
    \?) echo "Invalid option: -$OPTARG" >&2 ;;
  esac
done 

exit()

