# Add local path to custom themes and functions
fpath=(
    ~/.zsh/site-functions
    $fpath
)

if [[ ! -e $HOME/.antigen/antigen.zsh ]]; then
    git clone https://github.com/zsh-users/antigen.git $HOME/.antigen
fi

if [[ ! -d $HOME/.zsh ]]; then
    ln -s ~/.dotfiles/zsh $HOME/.zsh
fi

if [[ ! -e ~/.vim/bundle/Vundle.vim ]]; then
    mkdir -p ~/.vim/bundle
    git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
    vim -u ~/.vimrc +VundleInstall +qall
fi

source $HOME/.antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle colored-man-pages
antigen bundle docker
antigen bundle osx

antigen bundle chriskempson/base16-shell
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions

antigen apply

if [[ ! -L $HOME/.base16_theme ]]; then
    base16_tomorrow-night
fi

# ZSH prompt and modules
autoload -Uz colors compinit complist promptinit zmv
autoload -Uz add-zsh-hook

# Tab Completion
setopt completealiases
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate # Approximate matching
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select  # Arrow keys
zstyle ':completion:*' hosts        # SSH hosts
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
#zstyle ':completion:*' original true
#zstyle ':completion:*' prompt '%e'
#zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
#zstyle ':completion:*' auto-description '%d'
#zstyle ':completion:*' format '%d'
#zstyle ':completion:*' group-name ''

compinit

# Color
colors
export CLICOLOR=1

# Prompt
promptinit
prompt cook

# History setup
HISTFILE=~/.zsh_history
#HISTSIZE=50

# keybindings for shell
bindkey -e

# Remember vim mode (if using vim keybindings)
# accept-line() { prev_mode=$KEYMAP; zle .accept-line }
# zle -N accept-line
# zle-line-init() { zle -K ${prev_mode:-viins} }
# zle -N zle-line-init

# Prevent last line from being eaten
setopt PROMPT_SP

# Globbing
setopt extendedglob
unsetopt nomatch

if type "neofetch" > /dev/null; then
    neofetch
fi

# Percol setup
function exists { which $1 &> /dev/null }
if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if type "chef" > /dev/null; then
    eval "$(chef shell-init zsh)"
fi

if [ -d "$HOME/.cargo" ]; then
    export PATH="$PATH:$HOME/.cargo/bin"
fi

eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

eval "$(rbenv init -)"
