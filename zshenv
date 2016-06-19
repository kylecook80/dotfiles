export TERM=xterm-256color
export VISUAL=vim
export EDITOR=$VISUAL

# Aliases
[[ -f ~/.aliases ]] && . ~/.aliases

OS=`uname | tr "A-Z" "a-z"`
case $OS in
"darwin")
    # Homebrew Github API Token
    if [[ -r "$HOME/.homebrew_token" ]]; then
        export HOMEBREW_GITHUB_API_TOKEN=$(cat $HOME/.homebrew_token)
    fi

    # PATH
    path=(
      $HOME/bin
      /usr/local/bin
      /usr/bin
      /bin
      /usr/sbin
      /sbin
      /usr/local/MacGPG2/bin
    )

    # export CPATH=/opt/X11/include
    # export LIBRARY_PATH=/opt/X11/lib
    # export LD_LIBRARY_PATH=/opt/X11/lib
    export MACOSX_DEPLOYMENT_TARGET=10.11
    ;;
"linux")
    path=(
      $HOME/bin
      /usr/local/sbin
      /usr/sbin
      /sbin
      /usr/local/bin
      /usr/bin
      /bin
      /usr/local/games
      /usr/games
    )

    export CPATH="/usr/include/postgresql:$CPATH"
    ;;
esac
