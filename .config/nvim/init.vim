syntax on

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set incsearch
set noswapfile

" Specify a directory for plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline'

call plug#end()
" :PlugInstall

let g:airline_powerline_fonts = 1
