syntax on

set noerrorbells
set nu
set smartcase
set incsearch
set clipboard+=unnamedplus	" Use system clipboard
set noswapfile

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()
" :PlugInstall

let g:airline_powerline_fonts = 1
let g:airline_theme='minimalist'
