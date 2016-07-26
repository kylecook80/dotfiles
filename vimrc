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
set hidden

set nobackup
set nowritebackup
set noswapfile

let base16colorspace=256
set background=dark
"colorscheme base16-default
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif

set t_Co=256
set number
set numberwidth=5
syntax on

set backspace=start,eol,indent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set splitbelow
set splitright

set textwidth=80
set colorcolumn+=1

set clipboard=unnamedplus
set mouse=a

let mapleader = " "

nnoremap <Left> :echoe "Fuck off"<CR>
nnoremap <Up> :echoe "Fuck off"<CR>
nnoremap <Down> :echoe "Fuck off"<CR>
nnoremap <Right> :echoe "Fuck off"<CR>

noremap <C-J> <C-W><C-J>
noremap <C-H> <C-W><C-H>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>

noremap <Leader>nt :NERDTree<CR>

