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
            sudo apt-get -y install $INSTALL &> /dev/null
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
}

function install_scripts {
    mkdir -p $HOME/bin
    for item in $DIR/scripts/*.sh; do
        if [[ "$SAFE" = false || ! -L "$HOME/bin/$(basename $item)" ]]; then
            ln -sf $item $HOME/bin
        fi
    done
}

function install_plugins {
    if [[ ! -e "zsh/zsh-syntax-highlighting" ]]; then
        mkdir -p zsh/
        git clone https://github.com/zsh-users/zsh-syntax-highlighting zsh/zsh-syntax-highlighting
    fi

    if [[ ! -e "zsh/zsh-completions" ]]; then
        mkdir -p zsh/
        git clone https://github.com/zsh-users/zsh-completions zsh/zsh-completions
    fi

    if [[ ! -e "vim/bundle/Vundle.vim" ]]; then
        mkdir -p vim/bundle
        git clone https://github.com/VundleVim/Vundle.vim vim/bundle/Vundle.vim
    fi

    if [[ ! -e "tmux/tpm" ]]; then
        mkdir -p tmux/
        git clone https://github.com/tmux-plugins/tpm tmux/tpm
    fi

    if [[ ! -e "zsh/base16-shell" ]]; then
        mkdir -p zsh/
        git clone https://github.com/chriskempson/base16-shell zsh/base16-shell
    fi
}
    
# for item in $DEFAULT_FILES; do
#     ln -s .dotfiles/$item $HOME/.$item
# done
