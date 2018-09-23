#!/bin/bash

CMDLINE=(
    zsh
    vim
    git
)

APPS=(
	iterm2
	firefox
	karabiner-elements
	forklift
	mountain
	1password
	dropbox
	postgres
	jetbrains-toolbox
	vmware-fusion
	vmware-remote-console
	bartender
	fantastical
	sublime-text
	caffeine
	arq
	scroll-reverser
	pdfexpert
	daisydisk
	google-drive
	adobe-creative-cloud
    slack
    omnigraffle
    omnifocus
    omnioutliner
    beardedspice
    tunnelblick
)

FONTS=(
    font-hack
)

for i in ${CMDLINE[@]}; do
    brew install $i
done

for i in ${APPS[@]}; do
    brew cask install $i
done

brew tap caskroom/fonts
brew cask install $FONTS

