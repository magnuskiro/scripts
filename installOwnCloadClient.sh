echo "INFO - OwnCloud Client install"
#http://software.opensuse.org/download.html?project=isv:ownCloud:community&package=owncloud

wget http://download.opensuse.org/repositories/isv:ownCloud:community/Debian_6.0/Release.key 
sudo apt-key add - < ./Release.key 
rm ./Release.key
