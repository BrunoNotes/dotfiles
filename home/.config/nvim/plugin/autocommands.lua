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

-- change cwd on ender
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
        local file_cwd = vim.fn.expand("%:p:h")
        if (file_cwd ~= nil or file_cwd ~= "") then
            if string.sub(file_cwd, 1, 3) == "oil" then
                vim.fn.chdir(string.sub(file_cwd, 7, string.len(file_cwd)))
            else
                vim.fn.chdir(file_cwd)
            end
        end

        print(string.format("CWD changed to: %s", vim.loop.cwd()))
    end,
})

-- clear jump list
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
        vim.cmd.cle();
    end,
})

vim.api.nvim_create_autocmd({ "VimLeave" }, {
    callback = function()
        vim.cmd.cle();
    end,
})
