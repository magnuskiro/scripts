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
wget \
https://raw.githubusercontent.com/magnuskiro/scripts/master/Setup.sh \
&& chmod 755 ./Setup.sh&& ./Setup.sh -f && rm ./Setup.sh 

## TODO
- create owncloud install script. 
- Update this script and documentation. 

END

MinimalPackageInstall () {
	packages="
	git ack-grep htop vim
	"

	echo "INFO - Installing minimal packages"
	sudo apt-get install -y $packages
}

PackageInstall () {
	MinimalPackageInstall
	
	packages= "
	exuberant-ctags libparse-exuberantctags-perl xclip 
	ssmtp screen filezilla 
	pdflatex texlive-latex-extra inotify-tools 
    "
	#owncloud-client 

	echo "INFO - Installing extra packages"
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

PullAllRepos () {
	echo "INFO - Pulling all repos"
	#TODO fix. 
}

CloneRepos () {
	CreateFolder ~/$repo_folder
    # clone projects from git.
    echo "INFO - Cloning projects"
    gitUser="magnuskiro"
    repo_folder="repos"

	repos=( "scripts" "configs" "ntnu" "magnuskiro.github.com" )
	# TODO add all repos, dusken, kodekollektivet and more.
    for repo in "${repos[@]}" 
    do
        # if folder not exists.
		# TODO test, might be buggy. repos not directly in home. 
        if [ ! -d "./"$repo ]; then
            git clone git@github.com:$gitUser/$repo.git ~/$repo_folder/$repo
        fi
    done
}

CreateSymlinks (){
    echo "INFO - Creating symlinks"

	ln -s ~/repos/scripts/ ~/bin
    #ln -s "$conf_dir/awesome" ~/".config/awesome"

    # Config links
    conf_dir="~/repos/configs"
	configs=( ".vim" ".vimrc" ".gitconfig" ".bash_aliases" )
    for conf_file in "${cofigs[@]}" 
    do
        rm ~/$conf_file
        cmd="ln -s "$conf_dir"/"$conf_file" ~/"$conf_file
        eval $cmd
    done
}

AppendPathVariablesToProfile (){
echo "

# extra path variables for development and such.
export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_25
export JDK_HOME=$JAVA_HOME/bin
export M2_HOME=/usr/local/apache-maven
export M2=$M2_HOME/bin
export IDEA=/usr/local/idea/bin
export PYCHARM=/usr/local/pycharm/bin
export PLAY=/usr/local/play
export ACTIVATOR=/usr/local/activator

export PATH=$PATH:$M2_HOME:$M2:$JAVA_HOME:$JDK_HOME:$IDEA:$PYCHARM:$PLAY:$ACTIVATOR
" >> .profile

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
while getopts "isu" opt; do
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
		# pull repos
		CloneRepos
		# create symlinks
		CreateSymlinks	
		# set path variables to .profile
		AppendPathVariablesToProfile
	
		installSpotify.sh
		#TODO create script
		#installOwnCloadClient.sh
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

