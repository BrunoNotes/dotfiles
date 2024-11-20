-- remove white space at the end
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- highlight yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- fixes autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function()
        vim.cmd("set formatoptions-=cro")
    end,
})

-- format on save
-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--     callback = function ()
--         vim.cmd("lua vim.lsp.buf.formatting()")
--     end
-- })
