#!/bin/bash

: <<'END'

magnuskiro - 17.12.13

## Description
Script to backup my home folder to my backup server. 

## Requirements
* rsync
* defined an excludelist. 

## Use: 
* Sitting at home where s.magnuskiro.no doesnt work. Using the IP adress instead:
SynchronizeHome.sh -h
* Normal: 
SynchronizeHome.sh

# TODO
* update excludelist
* -b backup
* -s synchronize
* -a all
* -f spesific folder 

END

#variables
host="kiro@s.magnuskiro.no"
port="40596"
excludelist="$HOME/repos/configs/backup_excludelist"
backupdir="~/backup/`hostname`_home_`date +%F`"
source_dir="$HOME/"
ssh="'ssh -p $port'"

synchronize () {
	host=$1
	# echo rsync -avzr $ssh /home/kiro/Steam $host:~/backup/new
	rsync -rauvzPe 'ssh -p 40596' --exclude-from $excludelist $source_dir $host:$backupdir  
}

# Input gathering. 
while getopts "he:" opt; do
  case $opt in
	e)
		excludelist=$OPTARG
	;;
	# -h, home. On the local net. DNS name doesn't work. 
    h)  
		host="kiro@192.168.10.20"
	;;
	# invalid options 
    \?) 
		echo "Invalid option: -$OPTARG" >&2 
		exit 1
	;;
  esac
done 

synchronize $host

exit 1