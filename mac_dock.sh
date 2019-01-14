#!/usr/bin/env bash

# Assumes dockutil is installed via homebrew

# Set Dock items
OLDIFS=$IFS
IFS=''

apps=(
    Finder
    ForkLift
    Firefox
    'Google Chrome'
    Mail
    'Fantastical 2'
    Messages
    Signal
    Discord
    Slack
    Contacts
    Photos
    'Sublime Text'
    iTerm
    'VMware Fusion'
    Zotero
    '1Password 7'
    'App Store'
    'System Preferences'
)

dockutil --no-restart --remove all $HOME
for app in "${apps[@]}"
do
    echo "Keeping $app in Dock"
    dockutil --no-restart --add /Applications/$app.app $HOME
done
killall Dock

# restore $IFS
IFS=$OLDIFS
