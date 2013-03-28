#!/bin/sh
# the hope is to copy and pase this into the command line to make this work out nicely. 

################################################
#general configuration cross linux machines. 

# Static variables
conf="~/repos/configs"

# create folders
mkdir ~/repos
mkdir ~/ntnu
mkdir ~/dusken

# install packages
apt-get install git vim exuberant-ctags libparse-exuberantctags-perl ack-grep

# create ssh key for git. 
cat ~/.ssh/id_rsa.pub 
read -p "The manual step, put ssh key into github.com then Press any key to continue... "

# clone projects.
cd repos 
# TODO add repository cloning
	# create some kind of for loop with an array. 
repo="configs"
git clone git@github.com:magnuskiro/$repo.git
repo="scripts"
git clone git@github.com:magnuskiro/$repo.git

cd

# create symlinks. 
# TODO fix the rest of the symlinks.

# vim 
rm -rf ~/.vim && ln -s $conf/.vim .vim
rm ~/.vimrc && ln -s $conf/.vimrc .vimrc

# profile
rm ~/.profile && ln -s $conf/.profile ~/.profile

# bashrc
rm ~/.bashrc && ln -s $conf/.bashrc ~/.bashrc

# git
rm ~/.gitconfig && ln -s $conf/.gitconfig ~/.gitconfig

################################################
#Profiles 
# different system specific changes. 
## --server

## --x201
# thinkpad config.
#cd /usr/share/X11/xorg.conf.d/ & sudo ln -s $conf/20-thinkpad.conf 20-thinkpad.conf
echo "dock" >> ~/.bashrc

