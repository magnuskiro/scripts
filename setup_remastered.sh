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

END

AddSpotifyToSource () {
    # add spotify sources.list
    sudo chmod 777 /etc/apt/sources.list
    sudo echo "deb http://repository.spotify.com stable non-free" >>
    /etc/apt/sources.list
    sudo chmod 644 /etc/apt/sources.list
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59
}

AddOwnCloudToSource (){

}

CreateFolders () {
	# create folders
    echo "INFO - Creating folders"
    for folder in "repos" "dusken"
    do
        mkdir ~/$folder
    done
}

MinimalPackageInsall () {

}

PackageInsall () {
	MinimalPackageInstall
	
	packages = "
    spotify-client htop git vim exuberant-ctags 
    libparse-exuberantctags-perl ack-grep xclip inotify-tools awesome 
    awesome-extra vlc gnome-do xscreensaver filezilla 
    evince pdflatex texlive-latex-extra xcfe4-terminal ssmtp eog 
    owncloud-client
    "

	echo "INFO - Installing packages"
	sudo apt-get install -y $packages

}

AptUpgrade () {
	# Doing System upgrade last.
	# TODO test -y param.
	sudo apt-get update 
	sudo apt-get -y upgrade
	sudo apt-get -y dist-upgrade
}

GenerateSSH () {
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

CloneRepos () {
    # clone projects from git.
    echo "INFO - Cloning projects"
    gitUser="magnuskiro"
    repo_folder="repos"

	# TODO move scripts to ~/bin
	# TODO add all repos, dusken, kodekollektivet and more.
    for repo in "configs" "scripts" "magnuskiro.github.com"
    do
        # if folder not exists.
		# TODO test, might be buggy. repos not directly in home. 
        if [ ! -d "./"$repo ]; then
            git clone git@github.com:$gitUser/$repo.git ~/$repo_folder/$repo
        fi
    done
}

CreateSymlinks () {
    # Symlinking
    echo "INFO - Creating Symlinks"

	# Config links
    conf_dir="~/repos/configs"
    for conf_file in ".vim" ".vimrc" ".bashrc" ".profile" ".gitconfig" ".config/awesome"
    do
            rm -rf ~/$conf_file
            cmd="ln -s "$conf_dir"/"$conf_file" ~/"$conf_file
            eval $cmd
    done

	# Other
	# symlinking $home/bin
	ln -s ~/repos/scripts/ ~/bin
	
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
	# -install
    i) 
		# install stuff. 
		# and configure everything 
		echo "-a was specified"  
	;;
	# -minimal
	m)
		echo "minimal"
		# install a bare minimum to work. 
		# vim, git, htop
	;;
	# -server 
    s)  
		# install minimum for running, quite like minila
		# download configs, and setup vim, gitconfig and such.
		echo "arg given to b is $OPTARG" 
	;;
	# -upgrade
    u)  
		# and another one. 
		echo "INFO -- Upgrading"
		#sudo apt-get update
		#sudo apt-get dist-upgrade -y
	;;
	# invalid options 
    \?) echo "Invalid option: -$OPTARG" >&2 ;;
  esac
done 

# Cleaning up / removing itself
rm ~/setup.sh

exit()

