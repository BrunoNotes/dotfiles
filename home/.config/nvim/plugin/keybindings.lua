-- <CR> the enter key
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local nmap = require("utils").nmap
local imap = require("utils").imap
local vmap = require("utils").vmap
local xmap = require("utils").xmap
local smap = require("utils").smap
-- local cmap = require("utils").cmap
-- local tmap = require("utils").tmap

local M = {}

M.movement = function()
    nmap("n", "nzzzv", "Keeps the mouse in place while searching")
    nmap("N", "Nzzzv", "Keeps the mouse in place while searching")
    nmap("<C-d>", "<C-d>zz", "Keeps the mouse in place while moving") -- Move half a page down (zz centers)
    nmap("<C-u>", "<C-u>zz", "Keeps the mouse in place while moving") -- Move half a page up (zz centers)
    -- imap("<C-h>", "<Left>", "Move left in insert mode")
    -- imap("<C-j>", "<Down>", "Move down in insert mode")
    -- imap("<C-k>", "<Up>", "Move up in insert mode")
    -- imap("<C-l>", "<Right>", "Move right in insert mode")
    nmap("J", "mzJ`z", "Leaves the mouse in place while moving text")
    -- command line
    vim.cmd('cnoremap <c-k> <c-p>')
    vim.cmd('cnoremap <c-j> <c-n>')
    vim.cmd('cnoremap <c-h> <S-Left>')
    vim.cmd('cnoremap <c-l> <S-Right>')
    vim.cmd('cnoremap <c-p> <S-Up>')
    vim.cmd('cnoremap <c-n> <S-Down>')
    vim.cmd('cnoremap <c-0> <Home>')
    vim.cmd('cnoremap <c-5> <End>')
    vim.cmd('cnoremap <c-d> <c-u>')
    vim.cmd('cnoremap <c-x> <c-w>')
end

M.text = function()
    vmap("<", "<gv", "Indent text left")
    vmap(">", ">gv", "Indent text right")
    vmap("J", ":move '>+1<CR>gv=gv", "Move text down")
    vmap("K", ":move '<-2<CR>gv=gv", "Move text up")
    xmap("K", ":move '<-2<CR>gv=gv", "Move text up")
    xmap("J", ":move '>+1<CR>gv=gv", "Move text down")
    -- vmap("<leader>a", "<cmd>'<,'>norm A",  "Add text to end of selection" )
    -- xmap("<leader>a", "<cmd>'<,'>norm A",  "Add text to end of selection" )
    -- vmap("<leader>i", "<cmd>'<,'>norm I",  "Add text to begining of selection" )
    -- xmap("<leader>i", "<cmd>'<,'>norm I",  "Add text to begining of selection" )
    xmap("p", [["_dP]], "Dont save deletion on buffer on paste")
    nmap("<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replaces word under cursor")
end

M.copy_paste = function()
    vmap("p", '"_dP', "Paste on top of a word without copying")
    vmap("<leader>y", "\"+y", "Copy to system clipboard")
    nmap("<leader>y", "\"+y", "Copy to system clipboard")
    nmap("<leader>Y", "\"+Y", "Copy to system clipboard")
end

M.window = function()
    nmap("<S-Up>", "<cmd>resize -2<CR>", "Resize window up")
    nmap("<S-Down>", "<cmd>resize +2<CR>", "Resize window down")
    nmap("<S-Left>", "<cmd>vertical resize -2<CR>", "Resize window left")
    nmap("<S-Right>", "<cmd>vertical resize +2<CR>", "Resize window rigt")
    nmap("<C-w>r", "<C-w><C-r>", "Swap windows position")
    -- nmap("<C-h>", "<C-w>h", "Move to right window")
    -- nmap("<C-j>", "<C-w>j", "Move to down window")
    -- nmap("<C-k>", "<C-w>k", "Move to up window")
    -- nmap("<C-l>", "<C-w>l", "Move to left window")
end

M.buffers = function()
    nmap("<leader>bp", "<cmd>bprevious<cr>", "Previous buffer")
    nmap("<leader>bn", "<cmd>bnext<cr>", "Next buffer")
    nmap("<leader>bx", "<cmd>bd!<cr>", "Close buffers")
    nmap("<leader>bq", "<cmd>w|%bd!|e#|bd#<cr><cr>", "Closes other buffers, leaves current buffer open") -- :w saves, :%bd! deletes all buffers, bd# delete unnamed buffer
end

M.spell = function()
    nmap("<leader>sp", "<cmd>setlocal spell!<cr>", "Activate spell check") -- Activate spellcheck
    nmap("<leader>sr", "<cmd>spellr<cr>", "Repeat spell correction to matching words")
    imap("<C-x>s", "<C-x>s",  "Show spell suggestions" )                  -- show suggestions
end

M.custom_functions = function()
    nmap("<leader>cc", function()
        local message = vim.fn.input("Commit message: ")
        return {
            vim.cmd(string.format(":!git add . && git commit -m '%s'", message)),
            vim.api.nvim_feedkeys("<cr>", "n", false)
        }
    end,  "Quick commit" )
end

M.misk = function()
    nmap("<Esc>", "<Esc>", "Fix ESC changing buffer")
    imap("<Esc>", "<Esc>", "Fix ESC changing buffer")
    xmap("<Esc>", "<Esc>", "Fix ESC changing buffer")
    vmap("<Esc>", "<Esc>", "Fix ESC changing buffer")
    smap("<Esc>", "<Esc>", "Fix ESC changing buffer")
    nmap("<C-s>", "<cmd>w<cr>", "Save file")
    nmap("<leader>x", "<cmd>. lua<cr>", "Execute current line")
    nmap("<leader><leader>x", "<cmd>source %<cr>", "Execute current file")

    -- annoying
    xmap("u", "<Nop>", "Disable lowercase")
    vmap("u", "<Nop>", "Disable lowercase")
    xmap("U", "<Nop>", "Disable uppercase")
    vmap("U", "<Nop>", "Disable uppercase")
end


M.quickfix_list = function()
    nmap("<leader>qo", "<cmd>copen<cr>", "Open quickfix list")
    nmap("<leader>qx", "<cmd>cclose<cr>", "Close quickfix list")
    nmap("<C-n>", "<cmd>cnext<cr>zz", "Goes to next quickfix list item")
    nmap("<C-p>", "<cmd>cprevious<cr>zz", "Goes to next quickfix list item")
end

return M.movement(),
    M.text(),
    M.copy_paste(),
    M.window(),
    M.buffers(),
    M.spell(),
    M.custom_functions(),
    M.misk(),
    M.quickfix_list()
