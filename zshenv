export TERM=xterm-256color

# Set API token for GitHub if one exists
[[ -r ~/.homebrew_token ]] && . ~/.homebrew_token

# Aliases
[[ -f ~/.aliases ]] && . ~/.aliases

# Editors
export VISUAL=vim
export EDITOR=$VISUAL

# PATH
#path=(
#)
export PATH=$HOME/bin:$PATH

#export CPATH=/opt/X11/include
#export LIBRARY_PATH=/opt/X11/lib
#export LD_LIBRARY_PATH=/opt/X11/lib
#export MACOSX_DEPLOYMENT_TARGET=10.11
