#!/bin/bash

: <<'END'

Works on debian based Linux.

Auto install command: 

wget \
https://raw.githubusercontent.com/magnuskiro/scripts/master/installSpotify.sh \
&& chmod 755 ./installSpotify.sh && ./installSpotify.sh && rm ./installSpotify.sh 

END

InstallSpotify () {
    # add spotify sources.list
    sudo echo "deb http://repository.spotify.com stable non-free" >> ./spotify.list
	sudo mv ./spotify.list /etc/apt/sources.list.d/spotify.list 
	
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59

    # install Spotify
    sudo apt-get update 
    sudo apt-get install -y spotify-client
}

InstallSpotify


