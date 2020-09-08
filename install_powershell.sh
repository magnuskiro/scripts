#!/bin/bash

: <<'END'

Works on debian based Linux.

Auto install command: 

wget \
https://raw.githubusercontent.com/magnuskiro/scripts/master/installChrome.sh \
&& chmod 755 ./installChrome.sh && ./installChrome.sh && rm ./installChrome.sh 

END

InstallPowershell () {
# Download the Microsoft repository GPG keys
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb

# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb

# Update the list of products
sudo apt update

# Enable the "universe" repositories
sudo add-apt-repository universe

# Install PowerShell
sudo apt install -y powershell

# Start PowerShell
pwsh
}

echo "-- INFO - Installing Google Chrome"
InstallPowershell


