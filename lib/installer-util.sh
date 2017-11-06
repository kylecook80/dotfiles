#!/bin/bash

shopt -s nullglob nocaseglob
shopt -s nocasematch

OS=`echo $(uname) | tr '[:upper:]' '[:lower:]'`
# DIR="$( cd "$( dirname "${BASH_SOURCE[1]}" )" && pwd )"
DIR="$HOME/.dotfiles"

echo "OS: $OS"
echo "DIR: $DIR"

function install_dotfiles {
    # DEFAULT_FILES="aliases gdbinit gitconfig gitignore screenrc tmux.conf tmux vimrc vim zshenv zshrc zsh"
    LINKED=()

    for item in $DIR/conf/*; do
        item=`basename $item`
        if [ -e "$item-$OS" ]; then
            LINKED+="$item-$OS "
        else
            LINKED+="$item "
        fi
    done

    regex="(.*)-$OS"
    for item in $LINKED; do
        if [[ $item =~ $regex ]]; then
            # echo "regex: %s\n" "$HOME/.${BASH_REMATCH[1]}"
            echo -n "Creating file .${BASH_REMATCH[1]}: "
            if [[ ! -e "$HOME/.${BASH_REMATCH[1]}" ]]; then
                cat "conf/${BASH_REMATCH[1]}" "conf/$item" > "$HOME/.${BASH_REMATCH[1]}"
                echo "Success"
            else
                echo "Already exists"
            fi
        else
            # echo "no_regex: %s\n" "$HOME/.$item"
            # ln -s ".dotfiles/$item" "$HOME/.$item"
            echo -n "Linking file .$item: "
            if [[ ! -e "$HOME/.$item" && ! -L "$HOME/.$item" ]]; then
                ln -sf "$DIR/conf/$item" "$HOME/.$item"
                echo "Success"
            else
                echo "Already exists"
            fi
        fi
    done
}

function install_scripts {
    mkdir -p $HOME/bin
    for item in $DIR/scripts/*; do
        echo -n "Installing $(basename $item): "
        if [[ ! -L "$HOME/bin/$(basename $item)" ]]; then
            ln -sf $item $HOME/bin
            echo "Success"
        else
            echo "Already exists"
        fi
    done
}

function install_sublime_prefs {
    if [[ "$OS" == "darwin" ]]; then
        if [[ -e "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings" ]]; then
            mv "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings.old"
        fi

        ln -s "$HOME/.dotfiles/Preferences.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
    fi
}
