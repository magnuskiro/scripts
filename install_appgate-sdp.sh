#!/bin/bash

: <<'END'

Works on debian based Linux.

Auto install command: 

ref: 
https://the-d2.com/how-to-install-appgate-client-on-ubuntu-20-18-16/
https://github.com/appgate
https://www.appgate.com/software-defined-perimeter/for-developers

END

InstallAppgate () {
    wget https://bin.appgate-sdp.com/latest/ubuntu/AppGate-SDP-client.deb
    sudo dpkg -i AppGate-SDP-client.deb
    sudo apt install -f

    rm AppGate-SDP-client.deb
}

echo "-- INFO - Installing Appgate SDP"
InstallAppgate

