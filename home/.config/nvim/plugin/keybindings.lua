local key_modes = require("utils").key_modes

local keybindings = {
    { key_modes.normal, "n", "nzzzv", "Keeps the mouse in place while searching" },
    { key_modes.normal, "N", "Nzzzv", "Keeps the mouse in place while searching" },
    { key_modes.normal, "<C-d>", "<C-d>zz", "Keeps the mouse in place while moving" }, -- Move half a page down (zz centers)
    { key_modes.normal, "<C-u>", "<C-u>zz", "Keeps the mouse in place while moving" }, -- Move half a page up (zz centers)
    { key_modes.normal, "J", "mzJ`z", "Leaves the mouse in place while moving text" },
    -- command line
    { key_modes.command, "<c-k>", "<c-p>", "" },
    { key_modes.command, "<c-j>", "<c-n>", "" },

    { key_modes.visual, "<", "<gv", "Indent text left" },
    { key_modes.visual, ">", ">gv", "Indent text right" },
    { key_modes.visual, "J", ":move '>+1<CR>gv=gv", "Move text down" },
    { key_modes.visual, "K", ":move '<-2<CR>gv=gv", "Move text up" },
    { key_modes.visual_block, "K", ":move '<-2<CR>gv=gv", "Move text up" },
    { key_modes.visual_block, "J", ":move '>+1<CR>gv=gv", "Move text down" },
    { key_modes.visual_block, "p", [["_dP]], "Dont save deletion on buffer on paste" },
    { key_modes.normal, "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replaces word under cursor" },

    { key_modes.visual_block, "p", '"_dP', "Paste on top of a word without copying" },
    { key_modes.visual, "<leader>y", "\"+y", "Copy to system clipboard" },
    { key_modes.visual, "p", '"_dP', "Paste on top of a word without copying" },
    { key_modes.visual, "<leader>Y", "\"+Y", "Copy to system clipboard" },
    { key_modes.normal, "<leader>y", "\"+y", "Copy to system clipboard" },
    { key_modes.normal, "<leader>Y", "\"+Y", "Copy to system clipboard" },

    { key_modes.normal, "<A-Up>", function() vim.cmd(":resize -2") end, "Resize window up" },
    { key_modes.normal, "<A-Down>", function() vim.cmd(":resize +2") end, "Resize window down" },
    { key_modes.normal, "<A-Left>", function() vim.cmd(":vertical resize +2") end, "Resize window left" },
    { key_modes.normal, "<A-Right>", function() vim.cmd(":vertical resize -2") end, "Resize window rigt" },
    { key_modes.normal, "<C-w>r", "<C-w><C-r>", "Swap windows position" },

    { key_modes.normal, "<leader>bp", function() vim.cmd(":bprevious") end, "Previous buffer" },
    { key_modes.normal, "<leader>bn", function() vim.cmd(":bnext") end, "Next buffer" },
    { key_modes.normal, "<leader>bx", function() vim.cmd(":bd!") end, "Close buffers" },
    { key_modes.normal, "<leader>bq", function()
        -- vim.cmd(":w|%bd!|e#|bd#")
        local current_buf = vim.api.nvim_get_current_buf()
        local count = 0
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if (current_buf ~= buf) then
                vim.api.nvim_buf_delete(buf, { force = true })
                -- vim.api.nvim_buf_delete(buf, { unload = true })
                -- vim.api.nvim_buf_delete(buf, {})
                count = count + 1
            end
        end

        print("closed " .. count .. " buffers")
    end, "Closes other buffers, leaves current buffer open" },                                              -- :w saves, :%bd! deletes all buffers, bd# delete unnamed buffer
    { key_modes.normal, "<leader>sp", function() vim.cmd(":setlocal spell!") end, "Activate spell check" }, -- Activate spellcheck
    { key_modes.normal, "<leader>sr", function() vim.cmd(":spellr") end, "Repeat spell correction to matching words" },
    { key_modes.insert, "<C-x>s", "<C-x>s", "Show spell suggestions" },                                     -- show suggestions

    { key_modes.normal, "<leader>cc", function()
        local message = vim.fn.input("Commit message: ")
        return {
            vim.cmd(":!git add . && git commit -m '" .. message .. "'"),
            vim.api.nvim_feedkeys("<cr>", "n", false)
        }
    end, "Quick commit" },

    { key_modes.insert, "<Esc>", "<Esc>", "Fix ESC changing buffer" },
    { key_modes.visual_block, "<Esc>", "<Esc>", "Fix ESC changing buffer" },
    { key_modes.visual, "<Esc>", "<Esc>", "Fix ESC changing buffer" },
    { key_modes.select, "<Esc>", "<Esc>", "Fix ESC changing buffer" },
    { key_modes.normal, "<Esc>", "<Esc>", "Fix ESC changing buffer" },
    { key_modes.normal, "<C-s>", function() vim.cmd.w() end, "Save file" },
    { key_modes.normal, "<leader>x", function() vim.cmd(":. lua") end, "Execute current line" },
    { key_modes.normal, "<leader><leader>x", function() vim.cmd(":source %") end, "Execute current file" },

    -- annoying
    { key_modes.visual_block, "U", "<Nop>", "Disable uppercase" },
    { key_modes.visual_block, "u", "<Nop>", "Disable lowercase" },
    { key_modes.visual, "u", "<Nop>", "Disable lowercase" },
    { key_modes.visual, "U", "<Nop>", "Disable uppercase" },

    { key_modes.normal, "<leader>qo", function() vim.cmd.copen() end, "Open quickfix list" },
    { key_modes.normal, "<leader>qx", function() vim.cmd.cclose() end, "Close quickfix list" },
    { key_modes.normal, "<leader>qn", function() vim.cmd.cnext() end, "Goes to next quickfix list item" },
    { key_modes.normal, "<leader>qp", function() vim.cmd.cprevious() end, "Goes to next quickfix list item" },

    { key_modes.normal, "<leader>cj", function()
        vim.cmd.cle()
        print("Cleared jump list")
    end, "Clear jump list" },
}

for _, key in ipairs(keybindings) do
    vim.keymap.set(key[1], key[2], key[3], { silent = true, desc = key[4] })
end
