local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer-rc.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = 'rounded' }
        end
    }
}

-- Install Plugins
return require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    -- Theme
    use 'folke/tokyonight.nvim'
    use 'itchyny/lightline.vim'
    -- LSP
    use 'neovim/nvim-lspconfig'
    use "williamboman/nvim-lsp-installer" -- simple to use language server installer
    -- cmp
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    -- snippets
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
    -- treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ":TSUpdate", }
    use "p00f/nvim-ts-rainbow"
    -- telescope
    use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' } } }
    -- autopair
    use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
    -- comment
    use "numToStr/Comment.nvim" -- Easily comment stuff
    -- nvim tree
    use "kyazdani42/nvim-web-devicons"
    use "kyazdani42/nvim-tree.lua"

    -- Automatically set up
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
