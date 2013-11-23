sudo chmod 777 /etc/apt/sources.list
sudo echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list
sudo chmod 644 /etc/apt/sources.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59
sudo apt-get update
sudo apt-get install -y spotify-client
