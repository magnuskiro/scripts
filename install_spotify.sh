#!/bin/bash

: <<'END'

Works on debian based Linux.

Auto install command: 

wget \
https://raw.githubusercontent.com/magnuskiro/scripts/master/installSpotify.sh \
&& chmod 755 ./installSpotify.sh && ./installSpotify.sh && rm ./installSpotify.sh 

END

InstallSpotify () {
    curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

    sudo apt-get update && sudo apt-get install spotify-client
}

echo "-- INFO - Installing Spotify"
InstallSpotify

