#!/bin/bash

shopt -s nullglob nocaseglob
shopt -s nocasematch

OS=`echo $(uname) | tr '[:upper:]' '[:lower:]'`
DIR="$( cd "$( dirname "${BASH_SOURCE[1]}" )" && pwd )"

printf "DIR: %s\n" $DIR

function install_apps {
    APPS="vim zsh sudo"
    INSTALL=()

    printf "Installing applications: "

    case $OS in
    "linux")
        for app in $APPS; do
            if [[ `dpkg -s $app` > /dev/null ]]; then
                INSTALL+="$app "
            fi
        done

        if [[ ${#INSTALL[@]} -gt 0 ]]; then
            sudo apt-get -y install $INSTALL &> /dev/null
            if [[ $? ]]; then
                printf "%s\n" "Success"
            else
                printf "%s\n" "Error during installation"
            fi
        else
            printf "%s\n" "Already installed"
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
        printf "Installing %s: " $(basename $item)
        if [[ "$SAFE" = false || ! -L "$HOME/bin/$(basename $item)" ]]; then
            ln -sf $item $HOME/bin
            printf "Success\n"
        else
            printf "Already exists\n"
        fi
    done
}

function install_plugins {
    printf "Cloning %s: " "zsh-syntax-highlighting"
    if [[ ! -e "zsh/plugins/zsh-syntax-highlighting" ]]; then
        mkdir -p zsh/
        git clone https://github.com/zsh-users/zsh-syntax-highlighting zsh/plugins/zsh-syntax-highlighting  &> /dev/null
        if [[ $? ]]; then
            printf "Success\n"
        else
            printf "Error cloning\n"
        fi
    else
        printf "Already cloned\n"
    fi

    printf "Cloning %s: " "zsh-completions"
    if [[ ! -e "zsh/plugins/zsh-completions" ]]; then
        mkdir -p zsh/
        git clone https://github.com/zsh-users/zsh-completions zsh/plugins/zsh-completions  &> /dev/null
        if [[ $? ]]; then
            printf "Success\n"
        else
            printf "Error cloning\n"
        fi
    else
        printf "Already cloned\n"
    fi

    printf "Cloning %s: " "base16-shell"
    if [[ ! -e "zsh/plugins/base16-shell" ]]; then
        mkdir -p zsh/
        git clone https://github.com/chriskempson/base16-shell zsh/plugins/base16-shell  &> /dev/null
        if [[ $? ]]; then
            printf "Success\n"
        else
            printf "Error cloning\n"
        fi
    else
        printf "Already cloned\n"
    fi

    printf "Cloning %s: " "Vundle.vim"
    if [[ ! -e "vim/bundle/Vundle.vim" ]]; then
        mkdir -p vim/bundle
        git clone https://github.com/VundleVim/Vundle.vim vim/bundle/Vundle.vim  &> /dev/null
        if [[ $? ]]; then
            printf "Success\n"
        else
            printf "Error cloning\n"
        fi
    else
        printf "Already cloned\n"
    fi

    printf "Cloning %s: " "tpm"
    if [[ ! -e "tmux/tpm" ]]; then
        mkdir -p tmux/
        git clone https://github.com/tmux-plugins/tpm tmux/tpm &> /dev/null
        if [[ $? ]]; then
            printf "Success\n"
        else
            printf "Error cloning\n"
        fi
    else
        printf "Already cloned\n"
    fi
}
    
# for item in $DEFAULT_FILES; do
#     ln -s .dotfiles/$item $HOME/.$item
# done
