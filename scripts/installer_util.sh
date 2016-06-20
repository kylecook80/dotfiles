#!/bin/bash

shopt -s nullglob nocaseglob
shopt -s nocasematch

OS=`echo $(uname) | tr '[:upper:]' '[:lower:]'`
DIR="$( cd "$( dirname "${BASH_SOURCE[1]}" )" && pwd )"

printf "DIR: %s\n" $DIR

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

        if [[ ${#INSTALL[@]} -gt 0 ]]; then
            sudo apt-get -y install $INSTALL
        fi
        ;;
    esac
}

function install_dotfiles {    
    printf "Arg: %s\n" $1
    printf "SAFE: %s\n" $SAFE

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
            printf "Creating file %s: " ".${BASH_REMATCH[1]}"
            if [[ "$SAFE" = "false" || ! -e "$HOME/.${BASH_REMATCH[1]}" ]]; then
                cat "${BASH_REMATCH[1]}" "$item" > "$HOME/.${BASH_REMATCH[1]}"
                printf "Success\n"
            else
                printf "Already exists\n"
            fi
        else
            # printf "no_regex: %s\n" "$HOME/.$item"
            # ln -s ".dotfiles/$item" "$HOME/.$item"
            printf "Linking file %s: " ".$item"
            if [[ "$SAFE" = "false" || ( ! -e "$HOME/.$item" && ! -L "$HOME/.$item" ) ]]; then
                ln -sf "$DIR/$item" "$HOME/.$item"
                printf "Success\n"
            else
                printf "Already exists\n"
            fi
        fi
    done

    #git submodule update --init
}

function install_scripts {
    mkdir -p $HOME/bin
    for item in $DIR/scripts/*.sh; do
        if [[ "$SAFE" = false || ! -L "$HOME/bin/$(basename $item)" ]]; then
            ln -sf $item $HOME/bin
        fi
    done
}

# for item in $DEFAULT_FILES; do
#     ln -s .dotfiles/$item $HOME/.$item
# done
