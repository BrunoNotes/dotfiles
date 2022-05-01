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
set clipboard=unnamedplus  " use system clipboard

set noshowmode  "dont show the mode

" Specify a directory for plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'itchyny/lightline.vim'

call plug#end()
" :PlugInstall

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
