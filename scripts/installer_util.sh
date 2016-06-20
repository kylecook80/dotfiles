#!/bin/bash

shopt -s nullglob nocaseglob
shopt -s nocasematch

SAFE=0
if [[ $1 = "update" ]]; then
    SAFE=1
fi

OS=`echo $(uname) | tr '[:upper:]' '[:lower:]'`
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function install_apps {
    APPS="vim git zsh sudo"
    INSTALL=()

    case $OS in
    "linux")
        for app in $APPS; do
            if [[ `dpkg -s $app` > /dev/null ]]; then
                INSTALL+="$app "
            fi
        done

        if [ ${#INSTALL[@]} -gt 0 ]; then
            sudo apt-get -y install $INSTALL
        fi
        ;;
    esac
}

function install_dotfiles {
    DEFAULT_FILES="aliases gdbinit gitconfig gitignore screenrc tmux.conf tmux vimrc vim zshenv zshrc zsh"
    LINKED=()

    printf "OS: %s\n" "${OS}"

    for item in $DEFAULT_FILES; do
        if [[ -e "$item-$OS" ]]; then
            LINKED+="$item-$OS "
        else
            LINKED+="$item "
        fi
    done

    regex="(.*)-$OS"
    for item in $LINKED; do
        if [[ $item =~ $regex ]]; then
            # printf "regex: %s\n" "$HOME/.${BASH_REMATCH[1]}"
            # ln -s ".dotfiles/$item" "$HOME/.${BASH_REMATCH[1]}"
            if [[ ! SAFE || ! -e "$HOME/.${BASH_REMATCH[1]}" ]]; then
                cat "${BASH_REMATCH[1]}" "$item" > "$HOME/.${BASH_REMATCH[1]}"
            fi
        else
            # printf "no_regex: %s\n" "$HOME/.$item"
            # ln -s ".dotfiles/$item" "$HOME/.$item"
            if [[ ! SAFE || ! -e "$HOME/.$item" ]]; then
                ln -s "$DIR/$item" "$HOME/.$item"
            fi
        fi
    done

    git submodule update --init
}

function install_scripts {
    mkdir -p $HOME/bin
    for item in $DIR/scripts/*.sh; do
        if [[ ! SAFE || ! -L "$HOME/bin/$(basename $item)" ]]; then
            ln -s $item $HOME/bin
        fi
    done
}

# for item in $DEFAULT_FILES; do
#     ln -s .dotfiles/$item $HOME/.$item
# done
