#!/bin/bash
# script to send simple email 
 
rm /tmp/emailmessage.txt 
EMAILMESSAGE="/tmp/emailmessage.txt"

echo "To:username@somedomain.com
From:youraccount@gmail.com
Subject: Test
" >>$EMAILMESSAGE
w >>$EMAILMESSAGE
# send an email using /bin/mail
ssmtp magnuskiro@gmail.com < $EMAILMESSAGE
  
