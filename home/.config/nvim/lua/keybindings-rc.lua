local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- map("mode", "keys", "command", options)
-- <CR> the enter key

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Load config
map("n", "<leader>rf", ":luafile %<cr>", opts)

-- Better window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Save
map("n", "<C-s>", ":w<cr>", opts)

-- Packer
map("n", "<leader>ps", ":PackerSync<CR>", opts)

-- Telescop
map("n", "<leader>.", ":Telescope find_files<CR>", opts)
map("n", "<leader><tab>", ":Telescope buffers<cr>", opts) -- list buffers
map("n", "<leader>tk", ":Telescope keymaps<cr>", opts) -- list keymaps
map("n", "<leader>tf", ":Telescope current_buffer_fuzzy_find<cr>", opts) -- fuzzy find buffer

-- Buffers
map("n", "<leader>bd", ":bd<cr>", opts) -- close buffer
map("n", "<leader>bl", ":bnext<cr>", opts) -- next buffer
map("n", "<leader>bh", ":bprevious<cr>", opts) -- previous buffer
map("n", "<S-l>", ":bnext<cr>", opts) -- next buffer
map("n", "<S-h>", ":bprevious<cr>", opts) -- previous buffer

-- File explorer
map("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Move text up and down
map("v", "<A-j>", ":m .+1<cr>gv", opts) -- A = alt
map("v", "<A-k>", ":m .-2<cr>gv", opts) -- A = alt
map("x", "<A-j>", ":move '>+1<CR>gv", opts)
map("x", "<A-k>", ":move '<-2<CR>gv", opts)

-- Paste on top of a word dont copy the deleted word
map("v", "p", '"_dP', opts)

-- comment
vim.keymap.set('n', '<C-_>', '<CMD>lua require("Comment.api").toggle_current_linewise()<CR>') -- Linewise toggle current line using C-/
vim.keymap.set('x', '<C-_>', '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>') -- Linewise toggle using C-/

-- LSP
map("n", "<leader>li", ":LspInfo<cr>", opts)
map("n", "<leader>lI", ":LspInstallInfo<cr>", opts)
map("n", "<leader>lf", ":Format<cr>", opts) -- auto format
