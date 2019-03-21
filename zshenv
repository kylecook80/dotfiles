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

    # PATH
    path=(
      $HOME/bin
      /opt/puppetlabs/pdk/bin
      /opt/puppetlabs/bin
      /usr/local/texlive/2018/bin/x86_64-darwin
      /usr/local/MacGPG2/bin
      /usr/local/anaconda3/bin
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
    #export DYLD_LIBRARY_PATH=
    #export LDFLAGS="-L/usr/local/opt/openssl/lib"
    #export CPPFLAGS="-I/usr/local/opt/openssl/include"
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
    #export CPATH=/usr/local/include
    #export LIBRARY_PATH=/usr/local/lib
    ;;
esac
