-- nvim initial config

-- Set leader
vim.keymap.set("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("utils")
require("nvim_env")

-- Auto install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    {
        -- import plugins from the folder lua/plugins
        spec = { { import = "plugins" } },
        ui = { border = "rounded" },
        change_detection = {
            notify = false,
        }
    }
)

-- The rest of the config is loaded in plugin
-- :h runtimepath
