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

#TODO create array of possible images to choose from
#images=[array with image names]

imageLocation="http://magnuskiro.no/distroImages/"
imageName="distro.image.gz"

installDisk=""
installPart=""
storagePart=""

# info:
# http://unixgeek.wordpress.com/2007/07/08/scripting-partition-creation-in-linux-using-fdisk/
fdiskInput="n
p
1

+90000M
n
p
2


w
"

install () {
echo $1
	# verify disk image name
		# abort if not a valid image
		$imageName=""

	# select hdd to install on
    read -p "Which disk to work on? eg: /dev/sda" $installDisk
	installPart=$installDisk"1"
	storagePart=$installDisk"2"

	# partition disk
	# 90gb + rest.
	fdisk $installDisk < $fdiskInput	

	# format partitions with ntfs filesystem	
	mkntfs -Q $installPart
	mkntfs -Q $storagePart

	# write image to disk partition
	# info: 'http://www.linuxweblog.com/dd-image' point 7
	gunzip -c $imageLocation$imageName | dd of=$installPart conv=sync,noerror bs=64K 
  
}

createImage (){
	echo "INFO - image name: "$1

	# get the location to create image from
	read -p "What disk to create image of?  eg: /dev/sda1 " installPart
	echo "INFO - image source partition: '$installPart'"
	# get the location where the disk image should be stored
	read -p "Where to store the image? eg: /dev/sda2 " storagePart
	echo "INFO - image storage partition: '$storagePart'"

	#imageName=$1".image.gz"
	# the folder to mount the storage partition
	storageMountFolder="/media/storage/"	

	# mount storage place for image to be created.
	mkdir $storageMountFolder
    mount $storagePart $storage
	echo "INFO - mounted storage location"
		
	# make byte image
	# info: 'http://www.linuxweblog.com/dd-image' point 5
	echo "INFO - creating image file"
	#dd if=$installPart conv=sync,noerror bs=64K | gzip -c > $storage$imageName
	echo "INFO - finished"
}

# Input gathering. 
# "ab:c:" is the allowed input parameters. 
# 'b:' means that we have a possible -b parameter with a following variable. 
# 'a' means that we have a possible parameter without a following input.
# the sequence of options matters. '-b input -a' might give faulty results. 
while getopts "c:d:" opt; do
  case $opt in
	# -c - create image
	c)
		createImage $2
	;;
	# -d - distro
    d)  
		# here we do stuffs 
		echo "-a was specified"  
		install $2 
	;;
	# invalid options 
    \?) 
		echo "Invalid option: -$OPTARG" >&2 
		echo "Use: '-d imageName'"
	;;
  esac
done 

exit

