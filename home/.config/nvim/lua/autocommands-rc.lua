-- fixes autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function()
        vim.cmd("set formatoptions-=cro")
    end,
})

-- format on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    callback = function ()
        vim.cmd("lua vim.lsp.buf.formatting()")
    end
})
