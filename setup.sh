#!/bin/sh
# the hope is to copy and pase this into the command line to make this work out nicely. 

################################################
#general configuration cross linux machines. 

# wget https://raw.github.com/magnuskiro/scripts/master/setup.sh && chmod 755 setup.sh && ./setup.sh

# create folders
for folder in "repos" "ntnu" "dusken"
do
	mkdir ~/$folder
done

# install packages/
sudo apt-get install git vim exuberant-ctags libparse-exuberantctags-perl ack-grep xclip 

# create ssh key for git.
echo "!-----"
cd ~/.ssh
if [ ! -e "./id_rsa.pub" ]; then
	echo "ssh key does not exist, creating one"
	ssh-keygen
	echo "!-----"
fi
cd
cat ~/.ssh/id_rsa.pub 
echo "!-----" 

echo -n "The manual step, put ssh key into github.com then Press [ENTER] to continue...: "
read v

# clone projects from git.
gitUser="magnuskiro"
cd repos 
for repo in "configs" "scripts" "magnuskiro.github.com"
do
	# if folder not exists.
	if [ ! -d "./"$repo ]; then
		git clone git@github.com:$gitUser/$repo.git
    fi
 
done
cd

# Symlinking
	# create som kind of for loop. 
conf_dir="~/repos/configs"

for conf_file in ".vim" ".vimrc" ".bashrc" ".profile" ".gitconfig"
do
        rm -rf ~/$conf_file
        cmd="ln -s "$conf_dir"/"$conf_file" ~/"$conf_file
        eval $cmd
done

################################################
#Profiles 
# different system specific changes. 
## --server

## --x201
# thinkpad config.
#apt-get install synergy guake gnome-do 
#cd /usr/share/X11/xorg.conf.d/ & sudo ln -s $conf/20-thinkpad.conf 20-thinkpad.conf

