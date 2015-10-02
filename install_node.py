#!/bin/bash

: <<'END'

installs nodeJS, 

Works on debian based Linux.

Auto install command: 
wget \
https://raw.githubusercontent.com/magnuskiro/scripts/master/install_nodeJS.sh \
&& chmod 755 ./install_nodeJS.sh && ./install_nodeJS.sh \
&& rm ./install_nodeJS.sh 

END

# get dependencies for node. 
sudo apt-get install g++ curl libssl-dev apache2-utils

# install node. 
git clone git@github.com:joyent/node.git
cd node
./configure
make
sudo make install

# install wanted node packages. 
sudo npm install -g bower grunt grunt-cli yo
