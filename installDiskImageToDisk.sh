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

## Oneliner: 
wget https://raw.githubusercontent.com/magnuskiro/scripts/master/installDiskImageToDisk.sh && chmod 755 installDiskImageToDisk.sh && ./installDiskImageToDisk.sh

END

#TODO create array of possible images to choose from
#images=[array with image names]

imageLocation="http://magnuskiro.no/distroImages/"
imageName="distro.image.gz"

# the folder to mount the storage partition
storageMountFolder="/media/storage/"

# info:
# http://unixgeek.wordpress.com/2007/07/08/scripting-partition-creation-in-linux-using-fdisk/
fdiskInput="o\n\
n\n\
p\n\
1\n\
\n\
+90000M\n\
n\n\
p\n\
2\n\
\n\
\n\
w\n\
"

install () {
	echo $1
	# verify disk image name
		# abort if not a valid image

	# select hdd to install on
	read -p "Which disk to work on? eg: /dev/sda " installDisk
	echo "INFO - The device is: '$installDisk'"
	installPart=$installDisk"1"
	echo "INFO - The install partition is: '$installPart'"
	storagePart=$installDisk"2"
	echo "INFO - The storage partition is '$storagePart'"

	# partition disk
	# 90gb + rest.
	echo "INFO - Creating partitions"
	printf $fdiskInput >> fdisk.input
	fdisk $installDisk < fdisk.input
	rm fdisk.input

	# format partitions with ntfs filesystem	
	echo "INFO - Formatting partitions"
	mkntfs -Q $installPart
	mkntfs -Q $storagePart

    # mount storage place for image.
    mkdir $storageMountFolder
    `mount $storagePart $storageMountFolder`
    echo "INFO - Mounted storage location"	

	# download image file
	cd $storageMountFolder
	echo "INFO - Downloading image"
	`wget $imageLocation$imageName` 

	# write image to disk partition
	# info: 'http://www.linuxweblog.com/dd-image' point 7
	echo "INFO - Writing image to partition"
	gunzip -c $storageMountFolder$imageName | dd of=$installPart conv=sync,noerror bs=64K
  
	echo "INFO - Finished"
}

createImage (){
	echo "INFO - Image name: "$1
	#imageName=$1".image.gz"

	# get the location to create image from
	read -p "What disk to create image of?  eg: /dev/sda1 " installPart
	echo "INFO - Image source partition: '$installPart'"
	# get the location where the disk image should be stored
	read -p "Where to store the image? eg: /dev/sda2 " storagePart
	echo "INFO - Image storage partition: '$storagePart'"

	# mount storage place for image to be created.
	mkdir $storageMountFolder
	`mount $storagePart $storageMountFolder`
	echo "INFO - Mounted storage location"
		
	# make byte image
	# info: 'http://www.linuxweblog.com/dd-image' point 5
	echo "INFO - Creating image file"
	`dd if=$installPart conv=sync,noerror bs=64K | gzip -c > $storageMountFolder$imageName`
	echo "INFO - Finished"
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
	# -d - install image to disk
    d)  
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

