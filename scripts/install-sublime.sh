#!/bin/bash

if [[ -z $1 ]] ;then
  echo "Please pass the build number to install."
  exit 1
fi

OS=`uname | tr "[A-Z]" "[a-z]"`
USER=`logname`

VERSION="$1"
DIR="$2"

case $OS in
"darwin")
    wget -O /tmp/sublime.dmg "https://download.sublimetext.com/Sublime Text Build ${VERSION}.dmg"
    hdiutil attach /tmp/sublime.dmg
    cd "/Volumes/Sublime Text"
    mkdir -p $HOME/Applications
    cp "Sublime Text.app" $HOME/Applications/
    hdiutil detach "/Volumes/Sublime Text"
    ;;
"linux")
    wget -O /tmp/sublime.tar.bz2 https://download.sublimetext.com/sublime_text_3_build_${VERSION}_x64.tar.bz2 

    if [[ ! -d $DIR && ! -f $DIR ]]; then
        echo -n "Directory does not exist. Creating: "
        mkdir -p $DIR
        echo "Done"
    fi

    if [[ -d $DIR/sublime_text ]]; then
      mv $DIR/sublime_text $DIR/sublime_text.bak
    fi

    tar xfvj /tmp/sublime.tar.bz2 -C /tmp
    rm /tmp/sublime.tar.bz2
    mv /tmp/sublime_text_3 /opt/sublime_text
    if [[ ! -e /usr/bin/subl ]]; then
        ln -s $DIR/sublime_text/sublime_text /usr/bin/subl
    fi
    sudo -u $USER mkdir -p /home/$USER/.config/sublime-text-3/Installed\ Packages/
    sudo -u $USER wget -O /home/$USER/.config/sublime-text-3/Installed\ Packages/Package\ Control.sublime-package https://packagecontrol.io/Package%20Control.sublime-package
    ;;
*)
    echo "Unsupported Operating System."
    exit 1
    ;;
esac
