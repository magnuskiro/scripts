#!/bin/bash
# script to send simple email 
 
rm /tmp/emailmessage.txt 
EMAILMESSAGE="/tmp/emailmessage.txt"

echo "To:magnuskiro@gmail.com
From:magnuskiro@gmail.com
Subject: Status
" >>$EMAILMESSAGE



# add additional message body here.
echo "Current IP: " >> $EMAILMESSAGE
# 'ip987321' is the name of the temp file used to store the page containing my current ip. 
# the perl program prints the ip addresses in the file. 
# then the temp file is removed. 
wget -q -O ip987321 http://ipecho.net/ && perl echoAllIPsFromFile.pl ip987321 >> $EMAILMESSAGE && rm ip987321

# this used to work. 
#lynx --dump http://ipecho.net/plain >> $EMAILMESSAGE

echo "" >> $EMAILMESSAGE

echo "Status: " >> $EMAILMESSAGE
w >>$EMAILMESSAGE

# send an email using /bin/mail
/usr/sbin/ssmtp magnuskiro@gmail.com < $EMAILMESSAGE
  
