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
#echo "start"

# add additional message body here.
# 'ip987321' is the name of the temp file used to store the page containing my current ip. 
# the perl program prints the ip addresses in the file. 
# then the temp file is removed. 
externalIP=`wget -q -O ip987321 http://checkip.dyndns.org/ && perl /home/kiro/repos/scripts/perl/echoAllIPsFromFile.pl ip987321`
echo "External IP: $externalIP" >> $EMAILMESSAGE
rm ip987321

#echo "between ips"

# get the local IP 
localIP=( $(/sbin/ifconfig | grep -A 2 "eth0" | grep -oP "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}") )
echo "Local IP: $localIP" >> $EMAILMESSAGE

# this used to work. 
#lynx --dump http://ipecho.net/plain >> $EMAILMESSAGE


# print number of pending updates to the message body
#echo "updates"
echo "" >> $EMAILMESSAGE
echo "Updates: " >> $EMAILMESSAGE
sudo apt-get update >> /dev/null
echo `apt-get -s upgrade | grep "newly install"` >> $EMAILMESSAGE

# print login status and session data to message body
#echo "logins"
echo "" >> $EMAILMESSAGE
echo "Status: " >> $EMAILMESSAGE
w >>$EMAILMESSAGE

# send an email using /bin/mail
/usr/sbin/ssmtp magnuskiro@gmail.com < $EMAILMESSAGE
  
