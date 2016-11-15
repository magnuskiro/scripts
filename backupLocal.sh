#!/bin/bash

: <<'END'

magnuskiro - 17.12.13

## Description
Script to backup my home folder to my backup server. 

## Requirements
* rsync
* defined an excludelist. 

## Use: 
* Sitting at home where magnuskiro.no doesnt work. Using the IP adress instead:
backuLocal.sh -h
* Normal: copy this folder to the same folder on the server.  
backupLocal.sh
* exclude: sets specific exclude list. This disregards the predefined excludelist.
backupLocal.sh -e .cpan .bashrc Downloads


* -b backup - full backup of the home directory. 
* -e exclude following parameters. 
* -h home - defines that the backup takes place on my home network. 

END

# connection variables
host="kiro@magnuskiro.no"
port="40596"
ssh="'ssh -p $port'"

# exclude list
excludelist="$HOME/repos/configs/backup_excludelist"

# directories
destination_dir=`pwd` # copying to this, standard: the current directory. Same as ./
source_dir="./" # copying from this, standard: the current directory, ~= ./

synchronize () {
    echo "Info -- source:      $source_dir"
    echo "Info -- destination: $host:$destination_dir"
    rsync -auvzPe 'ssh -p 40596' --exclude-from $excludelist $source_dir $host:$destination_dir  
}

# Input parameter handling. 
while getopts "bhe:" opt; do
  case $opt in
    b)
        echo "Info -- Backup options: local home folder to backup folder to server backup folder. "
        destination_dir="~/backup/`hostname`_home_`date +%F`"
        source_dir="$HOME/"
    ;;
    e)
        excludelist=$OPTARG
    ;;
    # -h, home. On the local net. DNS name doesn't work. 
    h)  
        echo "Info -- Using the local IP"    
        host="kiro@192.168.10.20"
    ;;
    # invalid options 
    \?) 
        echo "Invalid option: -$OPTARG" >&2 
        exit 1
    ;;
  esac
done 

# basic functionality (without parameters) is that the current folder gets
# synchronized with the same location on the remote server. 
synchronize

exit 1
