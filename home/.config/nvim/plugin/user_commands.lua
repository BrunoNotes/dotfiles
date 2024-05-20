vim.api.nvim_create_user_command("LspStatus", function()
    local status = vim.lsp.status()
    if (status == nil or status == "") then
        print("LSP Status: Loaded")
    else
        print(string.format("Lsp Status: Loading, %s", status))
    end
end, {})
