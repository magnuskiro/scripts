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
while getopts "imsu" opt; do
# -u(pdate), -i(nstall),-s(server) 
  case $opt in
	# -install
    i) 
		# install stuff. 
		# and configure everything 
		echo "-a was specified"  
	;;
	# -minimal
	m)
		echo "minimal"
		# install a bare minimum to work. 
		# vim, git, htop
	;;
	# -server 
    s)  
		# install minimum for running, quite like minila
		# download configs, and setup vim, gitconfig and such.
		echo "arg given to b is $OPTARG" 
	;;
	# -upgrade
    u)  
		# and another one. 
		echo "INFO -- Upgrading"
		#sudo apt-get update
		#sudo apt-get dist-upgrade -y
	;;
	# invalid options 
    \?) echo "Invalid option: -$OPTARG" >&2 ;;
  esac
done 

exit()

