#!/bin/bash

shopt -s nullglob nocaseglob
shopt -s nocasematch

OS=`echo $(uname) | tr '[:upper:]' '[:lower:]'`
DIR="$( cd "$( dirname "${BASH_SOURCE[1]}" )" && pwd )"

echo "OS: $OS"
echo "DIR: $DIR"

function install_apps {
    echo "Installing applications: "

    case $OS in
    "linux")
        local apps="vim zsh sudo nodejs npm python python-pip"
        local to_install=()
        
        if [[ type pacman &> /dev/null ]]; then
            $PKGMGR=pacman
        fi

        if [[ type apt-get &> /dev/null ]]; then
            $PKGMGR=apt-get
        fi

        case $PKGMGR in
        "apt-get")
            for app in $apps; do
                dpkg -s $app &> /dev/null
                if [[ $? ]]; then
                    INSTALL+="$app "
                fi
            done

            if [[ ${#to_install[@]} -gt 0 ]]; then
                if [[ sudo apt-get -y install $to_install &> /dev/null ]]; then
                    echo "Success."
                else
                    echo "Error during installation."
                fi
            else
                echo "Already installed."
            fi
            ;;
        "pacman")
            for app in $apps; do
                if [[ pacman -Q $app &> /dev/null ]]; then
                    to_install+="$app "
                fi
            done

            if [[ ${#to_install[@]} -gt 0 ]]; then
                if [[ sudo pacman -S $to_install &> /dev/null ]]; then
                    echo "Success."
                else
                    echo "Error during installation."
                    exit 1
                fi
            else
                echo "Already installed."
            fi
            ;;
        *)
            echo "Package manager not supported."
            exit 1
        esac
        ;;
    *)
        echo "Operating System not supported."
        ;;
    esac
}

function install_tools {
    case $OS in
    "linux")
        echo -n "Installing Percol: "
        if [[ type percol &> /dev/null ]]; then
            if [[ sudo pip install percol &> /dev/null ]]; then
                echo "Success"
            else
                echo "Error installing"
            fi
        fi

        echo -n "Installing Diff-so-fancy: "
        if [[ type diff-so-fancy &> /dev/null ]]; then
            if [[ sudo npm install -g diff-so-fancy &> /dev/null ]]; then
                echo "Success"
            else
                echo "Error installing"
            fi
        fi
        ;;
    *)
        echo "Operating System not supported"
        ;;
    esac
}

function install_dotfiles {
    DEFAULT_FILES="aliases gdbinit gitconfig gitignore screenrc tmux.conf tmux vimrc vim zshenv zshrc zsh"
    LINKED=()

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
            # echo "regex: %s\n" "$HOME/.${BASH_REMATCH[1]}"
            echo -n "Creating file .${BASH_REMATCH[1]}: "
            if [[ "$SAFE" = "false" || ! -e "$HOME/.${BASH_REMATCH[1]}" ]]; then
                cat "${BASH_REMATCH[1]}" "$item" > "$HOME/.${BASH_REMATCH[1]}"
                echo "Success"
            else
                echo "Already exists"
            fi
        else
            # echo "no_regex: %s\n" "$HOME/.$item"
            # ln -s ".dotfiles/$item" "$HOME/.$item"
            echo -n "Linking file .$item: "
            if [[ "$SAFE" = "false" || ( ! -e "$HOME/.$item" && ! -L "$HOME/.$item" ) ]]; then
                ln -sf "$DIR/$item" "$HOME/.$item"
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
        if [[ "$SAFE" = false || ! -L "$HOME/bin/$(basename $item)" ]]; then
            ln -sf $item $HOME/bin
            echo "Success"
        else
            echo "Already exists"
        fi
    done
}

function install_plugins {
    echo -n "Cloning zsh-syntax-highlighting: "
    if [[ ! -e "zsh/plugins/zsh-syntax-highlighting" ]]; then
        if [[ git clone https://github.com/zsh-users/zsh-syntax-highlighting zsh/plugins/zsh-syntax-highlighting &> /dev/null ]]; then
            echo "Success"
        else
            echo "Error cloning"
        fi
    else
        echo "Already cloned"
    fi

    echo -n "Cloning zsh-completions: "
    if [[ ! -e "zsh/plugins/zsh-completions" ]]; then
        if [[ git clone https://github.com/zsh-users/zsh-completions zsh/plugins/zsh-completions &> /dev/null ]]; then
            echo "Success"
        else
            echo "Error cloning"
        fi
    else
        echo "Already cloned"
    fi

    echo -n "Cloning base16-shell: "
    if [[ ! -e "zsh/plugins/base16-shell" ]]; then
        if [[ git clone https://github.com/chriskempson/base16-shell zsh/plugins/base16-shell &> /dev/null ]]; then
            echo "Success"
        else
            echo "Error cloning"
        fi
    else
        echo "Already cloned"
    fi

    echo -n "Cloning Vundle.vim: "
    if [[ ! -e "vim/bundle/Vundle.vim" ]]; then
        if [[ git clone https://github.com/VundleVim/Vundle.vim vim/bundle/Vundle.vim &> /dev/null ]]; then
            echo "Success"
        else
            echo "Error cloning"
        fi
    else
        echo "Already cloned"
    fi

    echo -n "Cloning tpm: "
    if [[ ! -e "tmux/plugins/tpm" ]]; then
        if [[ git clone https://github.com/tmux-plugins/tpm tmux/plugins/tpm &> /dev/null ]]; then
            echo "Success"
        else
            echo "Error cloning"
        fi
    else
        echo "Already cloned"
    fi
}
