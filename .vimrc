syntax on

set noerrorbells
set nu
set smartcase
set incsearch
set noswapfile

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'

call plug#end()
" :PlugInstall

let g:airline_powerline_fonts = 1
