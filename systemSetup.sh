
# clone projects. 


# create symlinks. 

ln -s ~/repos/configs/.vim .vim

# append to system configs.
# echo 'hei' >> test


# thinkpad config.
cd /usr/share/X11/xorg.conf.d/ & sudo ln -s ~/repos/configs/20-thinkpad.conf 20-thinkpad.conf
 
