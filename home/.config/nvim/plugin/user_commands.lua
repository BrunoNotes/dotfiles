local utils = require("utils")

-- LspStatus
-- vim.api.nvim_create_user_command("LspStatus", function()
--     local status = vim.lsp.status()
--     if (status == nil or status == "") then
--         print("LSP Status: Loaded")
--     else
--         print(string.format("Lsp Status: Loading, %s", status))
--     end
-- end, {})

-- Notes
vim.api.nvim_create_user_command("Notes", function(opts)
    local default_note = "/notes/default.md"
    local temp_note = "/tmp/temp.md"
    local temp_buffer = utils.find_buffer_by_name(temp_note)
    local default_buffer = utils.find_buffer_by_name(default_note)

    if opts.fargs[1] ~= nil then
        if (string.upper(opts.fargs[1]) == "T" or string.upper(opts.fargs[1]) == "TEMP") then
            utils.open_file_or_buffer(temp_note, temp_buffer)
        elseif (string.upper(opts.fargs[1]) == "D" or string.upper(opts.fargs[1]) == "DEFAULT") then
            utils.open_file_or_buffer("$HOME/SharedConfig" .. default_note, default_buffer)
        else
            local new_note = "/tmp/" .. opts.fargs[1] .. ".md"
            local new_buffer = utils.find_buffer_by_name(new_note)
            utils.open_file_or_buffer(new_note, new_buffer)
        end
    else
        utils.open_file_or_buffer(temp_note, temp_buffer)
    end
end, { desc = "Open Notes", nargs = '*' })

-- ChangeCWD
vim.api.nvim_create_user_command("ChangeCWD", function()
    local file_cwd = vim.fn.expand("%:p:h")
    if (file_cwd ~= nil or file_cwd ~= "") then
        if string.sub(file_cwd, 1, 3) == "oil" then
            vim.fn.chdir(string.sub(file_cwd, 7, string.len(file_cwd)))
        else
            vim.fn.chdir(file_cwd)
        end
    end

    print(string.format("CWD changed to: %s", vim.loop.cwd()))
end, { desc = "Change current working directory", nargs = '*' })

-- MakeFileExecutable
vim.api.nvim_create_user_command("MakeFileExecutable", function()
    vim.cmd(":!chmod +x %")
end, { desc = "Make current file executable", nargs = '*' })
