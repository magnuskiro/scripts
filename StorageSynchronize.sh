#!/bin/bash

# script to automatically synchronize to my storage device. 

# TODO fix profiles
# -b backup
# -a all
# -s synchronize

host="kiro@s.magnuskiro.no"
port="40596"
excludelist="$HOME/repos/configs/backup_excludelist"
backupdir="~/backup/`hostname`_home_`date +%F`"
source_dir="$HOME/"
ssh="'ssh -p $port'"
cmd="-avzr $ssh --exclude-from $excludelist /home/kiro/ $host:$backupdir"

# echo rsync -avzr $ssh /home/kiro/Steam $host:~/backup/new
rsync -avzr -e 'ssh -p 40596' --exclude-from $excludelist $source_dir $host:$backupdir  

