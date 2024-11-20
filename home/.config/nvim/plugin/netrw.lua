local nmap = require("utils").nmap
local global = vim.g

global.netrw_banner = 0
global.netrw_liststyle = 0

vim.api.nvim_create_autocmd("filetype", {
    pattern = "netrw",
    desc = "Better mappings for netrw",
    callback = function()
        -- vim.keymap.set("n", "l", "<cr>", { remap = true, buffer = true, desc = "Edit file" })
        -- vim.keymap.set("n", "h", "-", { remap = true, buffer = true, desc = "Go up a directory" })
    end
})

-- nmap("<leader>fb", ":Ex<cr>", { "Opens Netrw", "File Manager" })
