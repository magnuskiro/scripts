#!/bin/bash

: <<'END'

installs heroku, package installer for python.

Works on debian based Linux.

Auto install command: 
wget \
https://raw.githubusercontent.com/magnuskiro/scripts/master/install_heroku.sh \
&& chmod 755 ./install_heroku.sh && ./install_heroku.sh \
&& rm ./install_heroku.sh 

END

wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
