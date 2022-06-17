local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '

-- map("mode", "keys", "command", options)
-- <CR> the enter key
map("n", "<leader>s", ":PackerSync<CR>", opts)
