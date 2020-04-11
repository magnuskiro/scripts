#!/bin/bash

: <<'END'

Works on debian based Linux.

Auto install command: 

wget \
https://raw.githubusercontent.com/magnuskiro/scripts/master/installChrome.sh \
&& chmod 755 ./installChrome.sh && ./installChrome.sh && rm ./installChrome.sh 

END

InstallJottaCLI () {

    apt-get install wget apt-transport-https ca-certificates
    wget -O - https://repo.jotta.us/public.gpg | sudo apt-key add -
    echo "deb https://repo.jotta.us/debian debian main" | sudo tee /etc/apt/sources.list.d/jotta-cli.list

    sudo apt-get update 
    sudo apt-get install jotta-cli

    sudo systemctl restart jottad

}

echo "-- INFO - Installing Jotta CLI"
InstallJottaCLI


