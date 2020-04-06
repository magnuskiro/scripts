#!/bin/bash

: <<'END'

Comments, requirements and userguide here. 

## Description
This is a bash script template. To quickly create good and powerfull scripts.  

## Requirements
You need these packages or programs for this script to work. 

## Use: 
* one parameter
bash_program -a
* multiple parameters without extra input.
bash_program -bac
* multiple parameters with input. 
bash_program -a a-param-input -b another_input_value

## Auto install command: 
wget --no-cache \
https://raw.githubusercontent.com/magnuskiro/scripts/master/Setup.sh \
&& chmod 755 ./Setup.sh && ./Setup.sh -i && rm ./Setup.sh 

## TODO
- create owncloud install script. 
- Update this script and documentation. 

END

MinimalPackageInstall () {
	packages="
	git ack-grep htop vim xclip tree
	"

	echo "-- INFO - Installing minimal packages"
	sudo apt-get install -y $packages
}

PackageInstall () {
	MinimalPackageInstall
    	
	packages="exuberant-ctags libparse-exuberantctags-perl ssmtp screen
filezilla texlive lmodern texlive-extra-utils inotify-tools openssh-server eog
vlc maven lmodern i3 i3lock slack" 

	echo "-- INFO - Installing extra packages"
	sudo apt-get install -y $packages

}

AptUpgrade () {
	echo "-- INFO -- Upgrading"
	# Doing System upgrade last.
	sudo apt-get update 
	#sudo apt-get upgrade -y
	sudo apt-get dist-upgrade -y
}

CreateSSHkeys () {
    echo "-- INFO - SSH"
    echo "!-----"
    cd ~/.ssh
	# if no ssh key, generate it. 
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
}

CreateFolder () {
    folder=$1
    if [ ! -d "$folder" ] 
	then 
		echo "Creating folder:" $folder
        mkdir "$folder"
	fi 
}

PullAllRepos () {
	echo "-- INFO - Pulling all repos"
	#TODO fix. 
}

CloneRepos () {
    echo "-- INFO - Cloning projects"
    CreateFolder ~/$repo_folder
    # clone projects from git.
    gitUser="magnuskiro"
    repo_folder="repos"

    repos=( "scripts" "configs" "ntnu" "magnuskiro.github.com" )
    for repo in "${repos[@]}" 
    do
        # if folder not exists.
        if [ ! -d ~/$repo_folder/$repo ]; then
            git clone git@github.com:$gitUser/$repo.git ~/$repo_folder/$repo
        fi
    done
}

CreateSymlinks (){
    echo "-- INFO - Creating symlinks"

	# linking bin to scripts folder, enabling direct cmd access to personal
	# scripts. 
    rm ~/bin
	ln -s ~/repos/scripts/ ~/bin

    # Config links
    conf_dir="~/repos/configs"

	# awesome specifics. 
    #echo "Creating link: $conf_dir/awesome ~/.config/awesome"
	#rm ~/.config/awesome 
	#eval "ln -s $conf_dir/awesome ~/.config/awesome"

    # i3 config
    echo "Creating link: $conf_dir/i3 ~/.config/i3"
	rm ~/.config/awesome 
	eval "ln -s $conf_dir/i3 ~/.config/i3"

    # for config in list create correct symlink 
    for conf_file in ".vim" ".vimrc" ".gitconfig" ".bash_aliases" 
    do
        location=$conf_dir/$conf_file
		destination=./$conf_file
		echo "Creating link: $location $destination"
	    rm $destination
        cmd="ln -s $location $destination"
		eval $cmd	
    done
}

AppendPathVariablesToProfile (){
#eval \"source ~/repos/configs/path_exports\"
`cat ~/repos/configs/path_exports >> ~/.profile`
#echo "
#eval `source ~/repos/configs/path_exports`
#" >> ~/.profile
}

LaptopSpecifics () {
	# thikpad x201 config. 
	sudo ln -s "~/repos/configs/20-thinkpad.conf" "/usr/share/X11/xorg.conf.d/20-thinkpad.conf"
}

# Input gathering. 
# "ab:c:" is the allowed input parameters. 
# 'b:' means that we have a possible -b parameter with a following variable. 
# 'a' means that we have a possible parameter without a following input.
# the sequence of options matters. '-b input -a' might give faulty results. 
while getopts "lisu" opt; do
# -u(pdate), -i(nstall),-s(server) 
  case $opt in
    l) # create symlinks
		CreateSymlinks
    ;;
	# -install
    i) 
		# Upgrade system
		AptUpgrade
		# install stuff. 
		PackageInstall
		# create ssh keys so we can push to git. 
		CreateSSHkeys
		# pull repos
		CloneRepos
		# create symlinks
		CreateSymlinks	
		# set path variables to .profile
		AppendPathVariablesToProfile
	
		# reload bashrc to enable new commands. 
		echo "-- INFO - reloading .bashrc and .profile"
		eval "source $HOME/.bashrc"
		eval "source $HOME/.profile"

		~/repos/scripts/install_spotify.sh
		~/repos/scripts/install_chrome.sh
	;;
	# LaptopSpecifics, add laptop config, see method. 
	l)
		LaptopSpecifics
	;;
	# -server 
    s)  
		#TODO
		# install minimum for running, quite like minimal
		# download configs, and setup vim, gitconfig and such.
		# without scripts. 
		echo "arg given to b is $OPTARG" 
	;;
	# -upgrade
    u)  
		# and another one. 
		AptUpgrade
	;;
	# invalid options 
    \?) echo "Invalid option: -$OPTARG" >&2 ;;
  esac
done 

exit

