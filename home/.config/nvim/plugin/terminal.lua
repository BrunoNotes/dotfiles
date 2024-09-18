local tmap = require("utils").tmap
-- local nmap = require("utils").nmap

-- nmap("<leader><cr>", function()
--     local buffer = require("utils").find_buffer_by_name("term://")
--
--     if buffer == -1 then
--         vim.cmd(":terminal zsh")
--     else
--         vim.cmd(string.format(":buffer %s", buffer))
--     end
-- end
-- , { "Opens terminal" })

tmap("<Esc><Esc>", "<C-\\><C-n>", { "Exit terminal mode" })

-- Terminal local options
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("custom-term-open", {}),
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.scrolloff = 0
    end,
})

local function openTerminal(shell)
    local buffer = require("utils").find_buffer_by_name("term://")

    if shell == nil then
        shell = ""
    end

    if buffer == -1 then
        vim.cmd(":terminal " .. shell)
    else
        vim.cmd(":buffer %s" .. buffer)
    end
end

vim.api.nvim_create_user_command("TermOpen", function(opts)
    if opts.fargs[1] ~= nil then
        openTerminal(opts.fargs[1])
    else
        openTerminal()
    end
end, { desc = "Open terminal buffer", nargs = '*' })
