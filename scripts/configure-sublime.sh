#!/bin/sh

OS=`uname | tr "[A-Z]" "[a-z]"`
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

case $OS in
"darwin")
    SUBLIME_DIR="$HOME/Library/Application Support/Sublime Text 3"
    ;;
"linux")
    SUBLIME_DIR="$HOME/.config/sublime-text-3"
    ;;
*)
    echo "Unsupported Operating System."
    exit 1
    ;;
esac

ln -s "$DIR/settings/sublime/ipackages" "$SUBLIME_DIR/Installed Packages"
ln -s "$DIR/settings/sublime/packages" "$SUBLIME_DIR/Packages"
