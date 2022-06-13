syntax on

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set hidden
set nu
set relativenumber
set nowrap
set smartcase
set incsearch
set noswapfile
set nobackup
set clipboard=unnamedplus  " use system clipboard
set scrolloff=8
set noshowmode  "dont show the mode
set signcolumn=yes

" Specify a directory for plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'itchyny/lightline.vim',
Plug 'folke/tokyonight.nvim',

call plug#end()
" :PlugInstall

colorscheme tokyonight
highlight Normal guibg=none
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
