export TERM=xterm-256color
export VISUAL=vim
export EDITOR=$VISUAL
export KEYTIMEOUT=1

# Aliases
[[ -f ~/.aliases ]] && . ~/.aliases

OS=`uname | tr "A-Z" "a-z"`
case $OS in
"darwin")
    # Homebrew Github API Token
    if [[ -r "$HOME/.homebrew_token" ]]; then
        export HOMEBREW_GITHUB_API_TOKEN=$(cat $HOME/.homebrew_token)
    fi

    export VAGRANT_DEFAULT_PROVIDER="vmware_fusion"
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

    # PATH
    path=(
      $HOME/bin
      $HOME/.cargo/bin
      /usr/local/sbin
      /usr/sbin
      /sbin
      /usr/local/bin
      /usr/bin
      /bin
    )
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
    )
    ;;
esac

