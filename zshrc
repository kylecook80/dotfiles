# Add local path to custom themes and functions
fpath=(~/.zsh/site-functions $fpath)

# LiquidPrompt
#[[ $- = *i* ]] && source .zsh/scripts/liquidprompt/liquidprompt

# ZSH Configuration
autoload -U compinit complist promptinit
compinit
promptinit
prompt cook

# Enable arrow keys in auto-complete
zstyle ':completion:*' menu select
setopt completealiases

# Enable ssh hosts for completion
zstyle ':completion:*' hosts

# Color setup
autoload -U colors
colors
export CLICOLOR=1

# History setup
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# CD stuff
setopt autocd autopushd pushdsilent pushdtohome
DIRSTACKSIZE=5

# Globbing
setopt extendedglob
autoload -U zmv

# Not sure yet...
unsetopt nomatch

# Vi or Emacs
bindkey -e

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

# Display pretty picture at the end :)
if which archey &>/dev/null ; then
  archey
fi

# ZSH Plugins
[[ -f ~/.sh/scripts/zsh-completions/zsh-completions.plugin.zsh ]] && . ~/.zsh/scripts/zsh-completions/zsh-completions.plugin.zsh

[[ -f ~/.zsh/scripts/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && . ~/.zsh/scripts/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh
