#!/bin/bash

: <<'END'

Works on debian based Linux.

Auto install command: 

wget \
https://raw.githubusercontent.com/magnuskiro/scripts/master/install_skype.sh \
&& chmod 755 ./install_skype.sh && ./install_skype.sh && rm ./install_skype.sh 

END

Install () {
    # download skype:
    # this requires the link to return the skype debian install package. .deb 
    `wget -O skype.deb http://www.skype.com/go/getskype-linux-deb-32`

    # make file executable.
    chmod 755 skype.deb

    # update apt.
    sudo apt-get update
    
    # install skype. 
    sudo dpkg -i skype.deb

    # fixing dependencies that skype.deb couldn't 
    sudo apt-get install -f
   
    # cleanup
    rm skype.deb 
}

echo "-- INFO - Installing Skype"
Install

