# Add local path to custom themes and functions
fpath=(
    ~/.zsh/site-functions
    $fpath
)

PLUGINS="$HOME/.zsh/plugins"

# ZSH prompt and modules
autoload -Uz colors compinit complist promptinit zmv

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

# Terminal Color Scheme
. $PLUGINS/base16-shell/scripts/base16-tomorrow-night.sh
#BASE16_SHELL=$PLUGINS/base16-shell
#[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
#base16_tomorrow-night
#
# Prompt
promptinit
prompt cook

# History setup
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# accept-line() { prev_mode=$KEYMAP; zle .accept-line }
# zle -N accept-line
zle-line-init() { zle -K ${prev_mode:-viins} }
zle -N zle-line-init

# CD stuff
#setopt autocd autopushd pushdsilent pushdtohome
#DIRSTACKSIZE=5

# Globbing
setopt extendedglob
unsetopt nomatch

# keybindings for shell
bindkey -v

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

# ZSH Plugins
[[ -f $PLUGINS/zsh-completions/zsh-completions.plugin.zsh ]] && . $PLUGINS/zsh-completions/zsh-completions.plugin.zsh
[[ -f $PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && . $PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# autojump
if type "brew" > /dev/null; then
    [[ -f $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
else
    [[ -f /usr/share/autojump/autojump.zsh ]] && . /usr/share/autojump/autojump.zsh
fi

# Fortune Cowsay
# fortune -o | cowsay | lolcat

