return require('packer').startup(function()
        use 'wbthomason/packer.nvim'
        use 'folke/tokyonight.nvim'
        use 'itchyny/lightline.vim'
        use 'neovim/nvim-lspconfig'
        use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
        use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
        use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
        use 'L3MON4D3/LuaSnip' -- Snippets plugin
        use 'nvim-treesitter/nvim-treesitter'
end)

