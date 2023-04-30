#!/bin/bash

: <<'END'

Works on debian based Linux.

Auto install command: 

wget \
https://raw.githubusercontent.com/magnuskiro/scripts/master/installDiscord.sh \
&& chmod 755 ./installDiscord.sh && ./installDiscord.sh && rm ./installDiscord.sh 

END

InstallDiscord () {
  wget "https://discord.com/api/download?platform=linux&format=deb" -O discord.deb
  sudo apt install ./discord.deb -y
  rm discord.deb
}

echo "-- INFO - Installing Discord"
InstallDiscord

