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
local cmap = require("utils").cmap
-- local tmap = require("utils").tmap

local M = {}

M.movement = function()
    nmap("n", "nzzzv", "Keeps the mouse in place while searching")
    nmap("N", "Nzzzv", "Keeps the mouse in place while searching")
    nmap("<C-d>", "<C-d>zz", "Keeps the mouse in place while moving") -- Move half a page down (zz centers)
    nmap("<C-u>", "<C-u>zz", "Keeps the mouse in place while moving") -- Move half a page up (zz centers)
    nmap("J", "mzJ`z", "Leaves the mouse in place while moving text")
    -- command line
    cmap("<c-k>", "<c-p>", "")
    cmap("<c-j>", "<c-n>", "")
    cmap("<c-h>", "<S-Left>", "")
    cmap("<c-l>", "<S-Right>", "")
    cmap("<c-p>", "<S-Up>", "")
    cmap("<c-n>", "<S-Down>", "")
    cmap("<c-0>", "<Home>", "")
    cmap("<c-5>", "<End>", "")
    cmap("<c-d>", "<c-u>", "")
    cmap("<c-x>", "<c-w>", "")
end

M.text = function()
    vmap("<", "<gv", "Indent text left")
    vmap(">", ">gv", "Indent text right")
    vmap("J", ":move '>+1<CR>gv=gv", "Move text down")
    vmap("K", ":move '<-2<CR>gv=gv", "Move text up")
    xmap("K", ":move '<-2<CR>gv=gv", "Move text up")
    xmap("J", ":move '>+1<CR>gv=gv", "Move text down")
    xmap("p", [["_dP]], "Dont save deletion on buffer on paste")
    nmap("<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replaces word under cursor")
end

M.copy_paste = function()
    vmap("p", '"_dP', "Paste on top of a word without copying")
    xmap("p", '"_dP', "Paste on top of a word without copying")
    vmap("<leader>y", "\"+y", "Copy to system clipboard")
    vmap("<leader>Y", "\"+Y", "Copy to system clipboard")
    nmap("<leader>y", "\"+y", "Copy to system clipboard")
    nmap("<leader>Y", "\"+Y", "Copy to system clipboard")
end

M.window = function()
    nmap("<S-Up>", function() vim.cmd(":resize -2") end, "Resize window up")
    nmap("<S-Down>", function() vim.cmd(":resize +2") end, "Resize window down")
    nmap("<S-Left>", function() vim.cmd(":vertical resize +2") end, "Resize window left")
    nmap("<S-Right>", function() vim.cmd(":vertical resize -2") end, "Resize window rigt")
    nmap("<C-w>r", "<C-w><C-r>", "Swap windows position")
end

M.buffers = function()
    nmap("<leader>bp", function() vim.cmd(":bprevious") end, "Previous buffer")
    nmap("<leader>bn", function() vim.cmd(":bnext") end, "Next buffer")
    nmap("<leader>bx", function() vim.cmd(":bd!") end, "Close buffers")
    nmap("<leader>bq", function() vim.cmd(":w|%bd!|e#|bd#") end, "Closes other buffers, leaves current buffer open") -- :w saves, :%bd! deletes all buffers, bd# delete unnamed buffer
end

M.spell = function()
    nmap("<leader>sp", function() vim.cmd(":setlocal spell!") end, "Activate spell check") -- Activate spellcheck
    nmap("<leader>sr", function() vim.cmd(":spellr") end, "Repeat spell correction to matching words")
    imap("<C-x>s", "<C-x>s", "Show spell suggestions")                                     -- show suggestions
end

M.custom_functions = function()
    nmap("<leader>cc", function()
        local message = vim.fn.input("Commit message: ")
        return {
            vim.cmd(":!git add . && git commit -m '" .. message .. "'"),
            vim.api.nvim_feedkeys("<cr>", "n", false)
        }
    end, "Quick commit")
end

M.misk = function()
    nmap("<Esc>", "<Esc>", "Fix ESC changing buffer")
    imap("<Esc>", "<Esc>", "Fix ESC changing buffer")
    xmap("<Esc>", "<Esc>", "Fix ESC changing buffer")
    vmap("<Esc>", "<Esc>", "Fix ESC changing buffer")
    smap("<Esc>", "<Esc>", "Fix ESC changing buffer")
    nmap("<C-s>", function() vim.cmd(":w") end, "Save file")
    nmap("<leader>x", function() vim.cmd(":. lua") end, "Execute current line")
    nmap("<leader><leader>x", function() vim.cmd(":source %") end, "Execute current file")

    -- annoying
    xmap("u", "<Nop>", "Disable lowercase")
    vmap("u", "<Nop>", "Disable lowercase")
    xmap("U", "<Nop>", "Disable uppercase")
    vmap("U", "<Nop>", "Disable uppercase")
end


M.quickfix_list = function()
    nmap("<leader>qo", function() vim.cmd(":copen") end, "Open quickfix list")
    nmap("<leader>qx", function() vim.cmd(":cclose") end, "Close quickfix list")
    nmap("<C-n>", function() vim.cmd(":cnext") end, "Goes to next quickfix list item")
    nmap("<C-p>", function() vim.cmd(":cprevious") end, "Goes to next quickfix list item")
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
