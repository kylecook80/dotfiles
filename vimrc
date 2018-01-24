set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vim Plugin List
source ~/.dotfiles/bundles.vim

call vundle#end()
filetype plugin indent on

"set encoding=utf-8
"set ruler
"set showmatch
"set showmode
"set hidden

" Project specific vimrc
"set exrc
"set secure

" Don't use swapfiles
"set nobackup
"set nowritebackup
"set noswapfile

" Color scheme
"set t_Co=256
"let base16colorspace=256
"set background=dark
"colorscheme base16-tomorrow-night

" Line numbers and such
"set number
"set numberwidth=5
"syntax on

" Keyboard rules
"set backspace=start,eol,indent
"set tabstop=4
"set softtabstop=4
"set shiftwidth=4
"set expandtab
"set tags=./tags;/

" Open new panes below and right
"set splitbelow
"set splitright

"set textwidth=80

set clipboard=unnamedplus
set mouse=a

"let mapleader = " "

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list=1
"let g:syntastic_auto_loc_list=1
"let g:syntastic_check_on_open=1
"let g:syntastic_check_on_wq=0

"nnoremap <Left> :echoe "Fuck off"<CR>
"nnoremap <Up> :echoe "Fuck off"<CR>
"nnoremap <Down> :echoe "Fuck off"<CR>
"nnoremap <Right> :echoe "Fuck off"<CR>

"noremap <C-J> <C-W><C-J>
"noremap <C-H> <C-W><C-H>
"noremap <C-K> <C-W><C-K>
"noremap <C-L> <C-W><C-L>

"noremap <Leader>nt :NERDTree<CR>
"noremap <Leader>tt :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
"noremap <Leader>tv :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
"noremap <Leader>r :so $MYVIMRC<CR>
