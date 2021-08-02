#!/bin/bash

: <<'END'

Works on debian based Linux.

Auto install command: 

wget \
https://raw.githubusercontent.com/magnuskiro/scripts/master/??.sh \
&& chmod 755 ./??.sh && ./??.sh && rm ./??.sh 

END

# TODO fetch version as input parameter.
IDEA_VERSION="2021.2"

InstallIntellij () {
    # download latest version
    echo "Downloading intellij: ideaIU-$IDEA_VERSION.tar.gz"

    wget https://download.jetbrains.com/idea/ideaIU-$IDEA_VERSION.tar.gz

    # extract package
    tar -xzvf ideaIU-$IDEA_VERSION.tar.gz 
    sudo mv idea-IU-*/ /usr/local/

    chmod -R 777 /usr/local/idea-IU-*

    # Recreate links
    sudo rm /usr/local/idea 
    # TODO get build version for the new idea folder.
    # example: "idea-IU-211.7442.40/" it's not the same as the version name
    # downloaded. 
    #sudo ln -s /usr/local/ideaIU-$IDEA_VERSION/ /usr/local/idea
    echo "! manual link creation in /usr/local/ needed."

    # remove the old intellij installation in /usr/lib/share somtehing.
    # TODO remove the old intellij after linking is OK. 

    # remove the downloaded 
    rm ideaIU-$IDEA_VERSION.tar.gz
}

echo "-- INFO - Installing Intellij"
InstallIntellij

