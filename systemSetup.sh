# create folders
mkdir ~/repos
mkdir ~/ntnu
mkdir ~/dusken

# clone projects. 
# TODO add repository cloning 
git clone git@github.com/magnuskiro/configs.git ~/repos/configs

# create symlinks. 
# TODO fix the rest of the symlinks.
ln -s ~/repos/configs/.vim .vim
# TODO get .giconfig command. 

# append to system configs.
# echo 'hei' >> test

# TODO figure out howto add to files as sudo. 
echo "source /home/kiro/repos/configs/color.bashrc" >> $bashrc
echo "source /home/kiro/repos/configs/aliases.bashrc" >> $bashrc

echo "dock" >> $bashrc

# thinkpad config.
cd /usr/share/X11/xorg.conf.d/ & sudo ln -s ~/repos/configs/20-thinkpad.conf 20-thinkpad.conf
 
