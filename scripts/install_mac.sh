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
	yujitach-menumeters
	vmware-fusion
	vmware-remote-console
	flux
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
)

FONTS=(
    font-hack
)

brew install $CMDLINE
brew cask install $APPS
brew tap caskroom/fonts
brew cask install $FONTS

