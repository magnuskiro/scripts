#!/bin/sh

rsync -qrauzPe 'ssh -p 40596' /home/kiro/ kiro@192.168.10.20:/home/kiro/backup/
# another one
#rsync -rauzPe 'ssh -p 40596' /media/9016-4EF8/DCIM/100CANON/* kiro@192.168.10.20:/home/kiro/Photos/roma_26-29.04.13
