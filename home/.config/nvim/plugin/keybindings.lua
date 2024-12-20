local modes = require("utils").key_modes

local keybindings = {
    { modes.normal,       "n",          "nzzzv",                                                "Keeps the mouse in place while searching" },
    { modes.normal,       "N",          "Nzzzv",                                                "Keeps the mouse in place while searching" },
    { modes.normal,       "<C-d>",      "<C-d>zz",                                              "Keeps the mouse in place while moving" }, -- Move half a page down (zz centers)
    { modes.normal,       "<C-u>",      "<C-u>zz",                                              "Keeps the mouse in place while moving" }, -- Move half a page up (zz centers)
    { modes.normal,       "J",          "mzJ`z",                                                "Leaves the mouse in place while moving text" },
    -- command line
    { modes.command,      "<c-k>",      "<c-p>",                                                "" },
    { modes.command,      "<c-j>",      "<c-n>",                                                "" },
    { modes.command,      "<c-h>",      "<S-Left>",                                             "" },
    { modes.command,      "<c-l>",      "<S-Right>",                                            "" },
    { modes.command,      "<c-p>",      "<S-Up>",                                               "" },
    { modes.command,      "<c-n>",      "<S-Down>",                                             "" },
    { modes.command,      "<c-0>",      "<Home>",                                               "" },
    { modes.command,      "<c-5>",      "<End>",                                                "" },
    { modes.command,      "<c-d>",      "<c-u>",                                                "" },
    { modes.command,      "<c-x>",      "<c-w>",                                                "" },

    { modes.visual,       "<",          "<gv",                                                  "Indent text left" },
    { modes.visual,       ">",          ">gv",                                                  "Indent text right" },
    { modes.visual,       "J",          ":move '>+1<CR>gv=gv",                                  "Move text down" },
    { modes.visual,       "K",          ":move '<-2<CR>gv=gv",                                  "Move text up" },
    { modes.visual_block, "K",          ":move '<-2<CR>gv=gv",                                  "Move text up" },
    { modes.visual_block, "J",          ":move '>+1<CR>gv=gv",                                  "Move text down" },
    { modes.visual_block, "p",          [["_dP]],                                               "Dont save deletion on buffer on paste" },
    { modes.normal,       "<leader>r",  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replaces word under cursor" },

    { modes.visual_block, "p",          '"_dP',                                                 "Paste on top of a word without copying" },
    { modes.visual,       "<leader>y",  "\"+y",                                                 "Copy to system clipboard" },
    { modes.visual,       "p",          '"_dP',                                                 "Paste on top of a word without copying" },
    { modes.visual,       "<leader>Y",  "\"+Y",                                                 "Copy to system clipboard" },
    { modes.normal,       "<leader>y",  "\"+y",                                                 "Copy to system clipboard" },
    { modes.normal,       "<leader>Y",  "\"+Y",                                                 "Copy to system clipboard" },

    { modes.normal,       "<S-Up>",     function() vim.cmd(":resize -2") end,                   "Resize window up" },
    { modes.normal,       "<S-Down>",   function() vim.cmd(":resize +2") end,                   "Resize window down" },
    { modes.normal,       "<S-Left>",   function() vim.cmd(":vertical resize +2") end,          "Resize window left" },
    { modes.normal,       "<S-Right>",  function() vim.cmd(":vertical resize -2") end,          "Resize window rigt" },
    { modes.normal,       "<C-w>r",     "<C-w><C-r>",                                           "Swap windows position" },

    { modes.normal,       "<leader>bp", function() vim.cmd(":bprevious") end,                   "Previous buffer" },
    { modes.normal,       "<leader>bn", function() vim.cmd(":bnext") end,                       "Next buffer" },
    { modes.normal,       "<leader>bx", function() vim.cmd(":bd!") end,                         "Close buffers" },
    { modes.normal,       "<leader>bq", function() vim.cmd(":w|%bd!|e#|bd#") end,               "Closes other buffers, leaves current buffer open" }, -- :w saves, :%bd! deletes all buffers, bd# delete unnamed buffer
    { modes.normal,       "<leader>sp", function() vim.cmd(":setlocal spell!") end,             "Activate spell check" },                             -- Activate spellcheck
    { modes.normal,       "<leader>sr", function() vim.cmd(":spellr") end,                      "Repeat spell correction to matching words" },
    { modes.insert,       "<C-x>s",     "<C-x>s",                                               "Show spell suggestions" },                           -- show suggestions

    { modes.normal, "<leader>cc", function()
        local message = vim.fn.input("Commit message: ")
        return {
            vim.cmd(":!git add . && git commit -m '" .. message .. "'"),
            vim.api.nvim_feedkeys("<cr>", "n", false)
        }
    end, "Quick commit" },

    { modes.insert,       "<Esc>",             "<Esc>",                              "Fix ESC changing buffer" },
    { modes.visual_block, "<Esc>",             "<Esc>",                              "Fix ESC changing buffer" },
    { modes.visual,       "<Esc>",             "<Esc>",                              "Fix ESC changing buffer" },
    { modes.select,       "<Esc>",             "<Esc>",                              "Fix ESC changing buffer" },
    { modes.normal,       "<Esc>",             "<Esc>",                              "Fix ESC changing buffer" },
    { modes.normal,       "<C-s>",             function() vim.cmd(":w") end,         "Save file" },
    { modes.normal,       "<leader>x",         function() vim.cmd(":. lua") end,     "Execute current line" },
    { modes.normal,       "<leader><leader>x", function() vim.cmd(":source %") end,  "Execute current file" },

    -- annoying
    { modes.visual_block, "U",                 "<Nop>",                              "Disable uppercase" },
    { modes.visual_block, "u",                 "<Nop>",                              "Disable lowercase" },
    { modes.visual,       "u",                 "<Nop>",                              "Disable lowercase" },
    { modes.visual,       "U",                 "<Nop>",                              "Disable uppercase" },

    { modes.normal,       "<leader>qo",        function() vim.cmd(":copen") end,     "Open quickfix list" },
    { modes.normal,       "<leader>qx",        function() vim.cmd(":cclose") end,    "Close quickfix list" },
    { modes.normal,       "<C-n>",             function() vim.cmd(":cnext") end,     "Goes to next quickfix list item" },
    { modes.normal,       "<C-p>",             function() vim.cmd(":cprevious") end, "Goes to next quickfix list item" },
}

for _, key in ipairs(keybindings) do
    vim.keymap.set(key[1], key[2], key[3], { silent = true, desc = key[4] })
end
