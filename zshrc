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

antigen bundle chriskempson/base16-shell
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions

antigen apply

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
HISTSIZE=50

# keybindings for shell
bindkey -e

# Remember vim mode (if using vim keybindings)
# accept-line() { prev_mode=$KEYMAP; zle .accept-line }
# zle -N accept-line
# zle-line-init() { zle -K ${prev_mode:-viins} }
# zle -N zle-line-init

# Globbing
setopt extendedglob
unsetopt nomatch

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

# autojump
if type "brew" > /dev/null; then
    [[ -f $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
else
    [[ -f /usr/share/autojump/autojump.zsh ]] && . /usr/share/autojump/autojump.zsh
fi

# Fortune Cowsay
# fortune -o | cowsay | lolcat

if type "archey" > /dev/null; then
    [[ -f $(brew --prefix)/bin/archey ]] && archey
fi

eval "$(pyenv init -)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
