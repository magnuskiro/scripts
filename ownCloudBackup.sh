#!/bin/bash

: <<'END'

magnuskiro - 15.03.15

## Description
backup of owncloud databse dir. 

This might look like a security issue to have the password here, but the server only responds to queries from localhost.

## Requirements
* rsync

## Use: 
ownCloudBackup.sh

## Added to cron: 
'0 5 * * 1 ownCloudBackup.sh'

## TODO

END

#variables
backupdir="/home/kiro/backup/owncloud"
server="localhost"
username="owncloud"
password="X7pzv59UszXEBCQs"
db_name=$username

synchronize () {
	backupfile="$backupdir/owncloud-sqlbkp_`date +%F`.sql"
	mysqldump --lock-tables --databases $db_name -u$username -p$password > $backupfile
}

synchronize

exit 1
