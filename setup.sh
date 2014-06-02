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

Auto install command: 
wget \
https://raw.githubusercontent.com/magnuskiro/scripts/master/setup.sh \
&& chmod 755 ./setup.sh && ./setup.sh && rm ./setup.sh 

END

MinimalPackageInstall () {
	packages="git ack-grep htop vim"

	echo "INFO - Installing minimal packages"
	sudo apt-get install -y $packages
}

PackageInstall () {
	MinimalPackageInstall
	
	packages= "
	exuberant-ctags libparse-exuberantctags-perl xclip 
	ssmtp 
	awesome awesome-extra xscreensaver 
	gnome-do filezilla owncloud-client xcfe4-terminal 
    evince pdflatex texlive-latex-extra inotify-tools 
	eog	vlc
    "

	echo "INFO - Installing packages"
	sudo apt-get install -y $packages

}

AptUpgrade () {
	echo "INFO -- Upgrading"
	# Doing System upgrade last.
	sudo apt-get update 
	#sudo apt-get upgrade -y
	sudo apt-get dist-upgrade -y
}

CreateSSHkeys () {
    echo "INFO - SSH"
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
	echo $folder
    if [ ! -d "$folder" ] 
	then 
        mkdir "$folder"
	fi 
}

Configs () {
    repo_folder="~/repos"
	CreateFolder $repo_folder	

    echo "INFO - Config setup"
	echo "INFO - Cloning configs"
    gitUser="magnuskiro"
    repo="configs" 

	# take true parameter to use https. 
	if [ 1 -eq $1 ] 
	then
		echo "INFO - Cloning HTTPS"
    	git clone https://github.com/$gitUser/$repo.git $repo_folder/$repo
	else
		echo "INFO - Cloning SSH"
    	git clone git@github.com:$gitUser/$repo.git $repo_folder/$repo
	fi
    
	echo "INFO - Creating symlinks"
	# Config links
    conf_dir="~/repos/configs"
    for conf_file in ".vim" ".vimrc" ".bashrc" ".profile" ".gitconfig" ".config/awesome"
    do
        rm ~/$conf_file
        cmd="ln -s "$conf_dir"/"$conf_file" ~/"$conf_file
        eval $cmd
    done
}

Scripts () {
    repo_folder="~/repos"
	CreateFolder $repo_folder	

	echo "INFO - Scripts setup"
    echo "INFO - Cloning scripts"
    gitUser="magnuskiro"
    repo="scripts" 

    # take true parameter to use https. 
    if [ 1 -eq $1 ] 
    then
		echo "INFO - Cloning HTTPS"
        git clone https://github.com/$gitUser/$repo.git $repo_folder/$repo
    else
		echo "INFO - Cloning SSH"
        git clone git@github.com:$gitUser/$repo.git $repo_folder/$repo
    fi

	echo "INFO - symlinking scripts"
    # symlinking $home/bin
    ln -s ~/repos/scripts/ ~/bin
}

PullAllRepos () {
	echo "INFO - Pulling all repos"
	#TODO fix
}

ClonePersonalRepos () {
    # clone projects from git.
    echo "INFO - Cloning projects"
    gitUser="magnuskiro"
    repo_folder="repos"

	# TODO add all repos, dusken, kodekollektivet and more.
    for repo in "magnuskiro.github.com" "ntnu"
    do
        # if folder not exists.
		# TODO test, might be buggy. repos not directly in home. 
        if [ ! -d "./"$repo ]; then
            git clone git@github.com:$gitUser/$repo.git ~/$repo_folder/$repo
        fi
    done
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
while getopts "imsu" opt; do
# -u(pdate), -i(nstall),-s(server) 
  case $opt in
	# -Full
    f) 
		# Upgrade system
		AptUpgrade
		# install stuff. 
		PackageInstall
		# create ssh keys so we can push to git. 
		CreateSSHkeys
		# configure everything 
		Configs
		Scripts

		installSpotify.sh
		#TODO create script
		#installOwnCloadClient.sh
	;;
	# -minimal
	m)
		# install a bare minimum to work. 
		# vim, git, htop, ack-grep
		MinimalPackageInstall
		# Configure
		Configs 1
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

