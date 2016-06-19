set nocompatible

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'editorconfig/editorconfig-vim'

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'

Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'raimondi/delimitmate'
Plugin 'powerline/powerline'

Plugin 'chriskempson/base16-vim'

call vundle#end()

filetype plugin indent on

set encoding=utf-8
set ruler
set showmatch
set showmode

let base16colorspace=256
set background=dark
colorscheme base16-default

set t_Co=256
set nu
syntax on

set backspace=start,eol,indent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set clipboard=unnamedplus
set mouse=a
