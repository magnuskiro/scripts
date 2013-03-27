# the hope is to copy and pase this into the command line to make this work out nicely. 

# Static variables
conf="~/repos/configs"
#bashrc=$1

bashrc="~/.bashrc"


# create folders
mkdir ~/repos
mkdir ~/ntnu
mkdir ~/dusken

# install packages
apt-get install git

# create ssh key for git. 
cat ~/.ssh/id_rsa.pub 
read -p "Press any key to continue... "

# clone projects. 
# TODO add repository cloning 
git clone git@github.com/magnuskiro/configs.git $conf

# create symlinks. 
# TODO fix the rest of the symlinks.
ln -s $conf/.vim .vim


rm -rf ~/.gitconfig && ln -s $conf/.gitconfig ~/.gitconfig

# append to system configs.
# echo 'hei' >> test

# TODO figure out howto add to files as sudo. 
echo "source $conf/aliases.bashrc" >> $bashrc
echo "source $conf/color.bashrc" >> $bashrc

# thinkpad config.
cd /usr/share/X11/xorg.conf.d/ & sudo ln -s $conf/20-thinkpad.conf 20-thinkpad.conf
 
