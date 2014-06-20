#!/bin/bash

: <<'END'
Script to sent statusmail to myself from any computer with the script in cron
and ssmtp installed. 

Requirements: 
* ssmtp
* ~/repos/configs/ssmtp.conf

Edit crontab: 
crontab -e

Add this: 
0 7 * * * /home/kiro/repos/scripts/statusMail.sh

This will execute the statusMail script each day at 07:00. 

And update the /etc/ssmtp/ssmtp.conf with the config file. 

END

EMAILMESSAGE="/tmp/emailmessage.txt"
if [ -e "$EMAILMESSAGE" ]
then  
	rm $EMAILMESSAGE 
fi

hostname=`hostname`

echo "To:magnuskiro@gmail.com
From:magnuskiro@gmail.com
Subject: Status from '$hostname'
" >>$EMAILMESSAGE

# add additional message body here.
echo "Current IP: " >> $EMAILMESSAGE
# 'ip987321' is the name of the temp file used to store the page containing my current ip. 
# the perl program prints the ip addresses in the file. 
# then the temp file is removed. 
wget -q -O ip987321 http://ipecho.net/ && perl /home/kiro/repos/scripts/echoAllIPsFromFile.pl ip987321 >> $EMAILMESSAGE && rm ip987321

# this used to work. 
#lynx --dump http://ipecho.net/plain >> $EMAILMESSAGE

echo "" >> $EMAILMESSAGE

echo "Status: " >> $EMAILMESSAGE
w >>$EMAILMESSAGE

# send an email using /bin/mail
/usr/sbin/ssmtp magnuskiro@gmail.com < $EMAILMESSAGE
  
