export TERM=xterm-256color
export VISUAL=vim
export EDITOR=$VISUAL
export KEYTIMEOUT=1

# Aliases
[[ -f ~/.aliases ]] && . ~/.aliases

OS=`uname | tr "A-Z" "a-z"`
case $OS in
"darwin")
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

    if [ -d "$HOME/.cargo" ]; then
        export PATH="$PATH:$HOME/.cargo/bin"
    fi
    
    # Homebrew Github API Token
    if [[ -r "$HOME/.homebrew_token" ]]; then
        export HOMEBREW_GITHUB_API_TOKEN=$(cat $HOME/.homebrew_token)
    fi

    export VAGRANT_DEFAULT_PROVIDER="vmware_fusion"
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
    ;;
"linux")
    path=(
      $HOME/perl5/bin
      $HOME/bin
      /usr/local/sbin
      /usr/sbin
      /sbin
      /usr/local/bin
      /usr/bin
      /bin
    )

    export PERL5LIB="$HOME/perl5/lib/perl5"
    export PERL_LOCAL_LIB_ROOT="$HOME/perl5"
    export PERL_MB_OPT="--install_base \"$HOME/perl5\""
    export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"

    ;;
esac

