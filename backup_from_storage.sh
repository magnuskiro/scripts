#!/bin/bash

rsync -auvzPe 'ssh -p 40596'  --exclude "media" kiro@192.168.10.20:/home/ /srv > /srv/backup.log 2>&1

#rsync -auvzPe 'ssh -p 40596' --exclude "media" \
#192.168.10.20:/home/kiro/owncloud /srv/kiro/owncloud
