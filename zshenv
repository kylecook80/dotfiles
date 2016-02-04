export TERM=xterm-256color
[[ -r ~/.homebrew_token ]] && . ~/.homebrew_token

# Aliases
[[ -f ~/.aliases ]] && . ~/.aliases

# Editors
export VISUAL=vim
export EDITOR=$VISUAL

# PATH
path=(
  $HOME/bin
  /usr/local/MacGPG2/bin
  /opt/X11/bin
  /usr/local/bin
  /usr/bin
  /bin
  /usr/local/sbin
  /usr/sbin
  /sbin
)

export CPATH=/opt/X11/include
export LIBRARY_PATH=/opt/X11/lib
export LD_LIBRARY_PATH=/opt/X11/lib

export MACOSX_DEPLOYMENT_TARGET=10.11

# Autojump
if which brew &>/dev/null; then
  [[ -s $(brew --prefix)/Cellar/autojump/22.2.4/share/autojump/autojump.zsh ]] && . $(brew --prefix)/Cellar/autojump/22.2.4/share/autojump/autojump.zsh
else
  [[ -s /usr/share/autojump/autojump.sh ]] && . /usr/share/autojump/autojump.sh
fi

