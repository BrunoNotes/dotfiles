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
local tmap = require("utils").tmap

local M = {}

M.movement = function()
    nmap("n", "nzzzv", { "Keeps the mouse in place while searching" })
    nmap("N", "Nzzzv", { "Keeps the mouse in place while searching" })
    nmap("<C-d>", "<C-d>zz", { "Keeps the mouse in place while moving" }) -- Move half a page down (zz centers)
    nmap("<C-u>", "<C-u>zz", { "Keeps the mouse in place while moving" }) -- Move half a page up (zz centers)
    imap("<C-h>", "<Left>", { "Move left in insert mode" })
    imap("<C-j>", "<Down>", { "Move down in insert mode" })
    imap("<C-k>", "<Up>", { "Move up in insert mode" })
    imap("<C-l>", "<Right>", { "Move right in insert mode" })
    nmap("J", "mzJ`z", { "Leaves the mouse in place while moving text" })
end

M.text = function()
    vmap("<", "<gv", { "Indent text left" })
    vmap(">", ">gv", { "Indent text right" })
    vmap("J", ":move '>+1<CR>gv=gv", { "Move text down" })
    vmap("K", ":move '<-2<CR>gv=gv", { "Move text up" })
    vmap("<leader>a", ":'<,'>norm A", { "Add text to end of selection" })
    xmap("<leader>a", ":'<,'>norm A", { "Add text to end of selection" })
    vmap("<leader>i", ":'<,'>norm I", { "Add text to begining of selection" })
    xmap("<leader>i", ":'<,'>norm I", { "Add text to begining of selection" })
    xmap("J", ":move '>+1<CR>gv=gv", { "Move text down" })
    xmap("K", ":move '<-2<CR>gv=gv", { "Move text up" })
    xmap("p", [["_dP]], { "Dont save deletion on buffer on paste" })
    nmap("<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { "Replaces word under cursor", })
end

M.copy_paste = function()
    vmap("p", '"_dP', { "Paste on top of a word without copying" })
    vmap("<leader>y", "\"+y", { "Copy to system clipboard" })
    nmap("<leader>y", "\"+y", { "Copy to system clipboard" })
    nmap("<leader>Y", "\"+Y", { "Copy to system clipboard" })
end

M.window = function()
    nmap("<S-Up>", ":resize -2<CR>", { "Resize window up" })
    nmap("<S-Down>", ":resize +2<CR>", { "Resize window down" })
    nmap("<S-Left>", ":vertical resize -2<CR>", { "Resize window left" })
    nmap("<S-Right>", ":vertical resize +2<CR>", { "Resize window rigt" })
    nmap("<C-w>r", "<C-w><C-r>", { "Swap windows position" })
    nmap("<C-h>", "<C-w>h", { "Move to right window" })
    nmap("<C-j>", "<C-w>j", { "Move to down window" })
    nmap("<C-k>", "<C-w>k", { "Move to up window" })
    nmap("<C-l>", "<C-w>l", { "Move to left window" })
end

M.terminal = function()
    nmap("<leader><cr>", function()
        local buffer = require("utils").find_buffer_by_name("term://")

        if buffer == -1 then
            vim.cmd(":terminal")
        else
            vim.cmd(string.format(":buffer %s", buffer))
        end
    end
    , { "Opens terminal" })
    tmap("<Esc>", "<C-\\><C-n>", { "Exit terminal mode" })
end

M.buffers = function()
    nmap("<leader>bp", ":bprevious<cr>", { "Previous buffer" })
    nmap("<leader>bn", ":bnext<cr>", { "Next buffer" })
    nmap("<leader>bx", ":bd!<cr>", { "Close buffers" })
    nmap("<leader>bq", ":w|%bd!|e#|bd#<cr><cr>", { "Closes other buffers, leaves current buffer open" }) -- :w saves, :%bd! deletes all buffers, bd# delete unnamed buffer
end

M.spell = function()
    nmap("<leader>sp", ":setlocal spell!<cr>", { "Activate spell check" }) -- Activate spellcheck
    imap("<C-w>", "<C-x>s", { "Show spell suggestions" })                  -- show suggestions
end

M.custom_functions = function()
    nmap("<leader>cm", ":!chmod +x %<cr>", { "Make file executable" })
    -- nmap("<leader>cc", function()
    --     local message = vim.fn.input("Commit message: ")
    --     return {
    --         vim.cmd(string.format(":!git add . && git commit -m '%s'", message)),
    --         vim.api.nvim_feedkeys("<cr>", "n", false)
    --     }
    -- end, { "Quick commit", category.git })
    nmap("<leader>nt", function()
        local temp_note = "/tmp/temp.md"
        local buffer = require("utils").find_buffer_by_name(temp_note)


        if buffer == -1 then
            vim.cmd(string.format(":e %s", temp_note))
        else
            vim.cmd(string.format(":buffer %s", buffer))
        end
    end, { "Opem tmp note" })
end

M.misk = function()
    nmap("<Esc>", "<Esc>", { "Fix ESC changing buffer" })
    imap("<Esc>", "<Esc>", { "Fix ESC changing buffer" })
    xmap("<Esc>", "<Esc>", { "Fix ESC changing buffer" })
    vmap("<Esc>", "<Esc>", { "Fix ESC changing buffer" })
    nmap("<C-s>", ":w<cr>", { "Save file" })
end

M.load = function(self)
    return M.movement(),
        M.text(),
        M.copy_paste(),
        M.window(),
        M.terminal(),
        M.buffers(),
        M.spell(),
        M.custom_functions(),
        M.misk()
end

return M
