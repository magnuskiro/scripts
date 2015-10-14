#!/bin/bash

: <<'END'

installs pip, package installer for python.

Works on debian based Linux.

Auto install command: 
wget \
https://raw.githubusercontent.com/magnuskiro/scripts/master/install_pip.sh \
&& chmod 755 ./install_pip.sh && ./install_pip.sh \
&& rm ./install_pip.sh 

END


wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py
