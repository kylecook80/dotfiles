#!/bin/bash

if [[ -z $1 ]] ;then
  echo "Please pass the build number to install."
  exit 1
fi

wget -O /tmp/sublime.tar.bz2 https://download.sublimetext.com/sublime_text_3_build_$1_x64.tar.bz2 

if [[ -d /opt/sublime_text ]]; then
  mv /opt/sublime_text /opt/sublime_text.bak
fi

tar xfvj /tmp/sublime.tar.bz2 -C /opt
rm /tmp/sublime.tar.bz2
mv /opt/sublime_text_3 /opt/sublime_text

