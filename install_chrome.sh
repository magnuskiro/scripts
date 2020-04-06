#!/bin/bash

: <<'END'

Works on debian based Linux.

Auto install command: 

wget \
https://raw.githubusercontent.com/magnuskiro/scripts/master/installChrome.sh \
&& chmod 755 ./installChrome.sh && ./installChrome.sh && rm ./installChrome.sh 

END

InstallChrome () {
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

    sudo dpkg -i google-chrome*.deb
}

echo "-- INFO - Installing Google Chrome"
InstallChrome


