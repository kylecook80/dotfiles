export TERM=xterm-256color
export VISUAL=vim
export EDITOR=$VISUAL
export KEYTIMEOUT=1
export PUPPET_PATH=$HOME/puppet

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
      /opt/puppetlabs/pdk/bin
      /opt/puppetlabs/bin
      /usr/local/opt/llvm/bin
      /usr/local/opt/mysql-client/bin
      /usr/local/texlive/2018/bin/x86_64-darwin
      /usr/local/MacGPG2/bin
      /usr/local/opt/openssl/bin
      /usr/local/opt/bison/bin
      /usr/local/bin
      /usr/bin
      /bin
      /usr/local/sbin
      /usr/sbin
      /sbin
    )

    export VAGRANT_DEFAULT_PROVIDER="vmware_fusion"
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
      #/usr/local/games
      #/usr/games
    )
    ;;
esac
