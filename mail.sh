#!/bin/bash
# script to send simple email 
 
rm /tmp/emailmessage.txt 
EMAILMESSAGE="/tmp/emailmessage.txt"

echo "To:magnuskiro@gmail.com
From:magnuskiro@gmail.com
Subject: Status
" >>$EMAILMESSAGE

# add additional message body here.
w >>$EMAILMESSAGE

# send an email using /bin/mail
/usr/sbin/ssmtp magnuskiro@gmail.com < $EMAILMESSAGE
  
