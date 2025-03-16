local utils = require("utils");

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


vim.api.nvim_create_user_command("EditorConfigGen", function()
    local editorconfig_path = vim.fn.getcwd() .. "/.editorconfig"

    local editorconfig = [[
# https://github.com/CppCXY/EmmyLuaCodeStyle/blob/master/lua.template.editorconfig
[*.lua]
indent_style = space
indent_size = 4
# true/false or always
align_continuous_assign_statement = false
align_continuous_rect_table_field = false
# option none / always / contain_curly/
align_array_table = false

# https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/code-style-rule-options?view=vs-2019
[*.cs]
indent_style = space
indent_size = 4
# New line preferences
csharp_new_line_before_open_brace = false
csharp_new_line_before_else = false
csharp_new_line_before_catch = false
csharp_new_line_before_finally = false
csharp_new_line_before_members_in_object_initializers = false
csharp_new_line_before_members_in_anonymous_types = false
csharp_new_line_between_query_expression_clauses = false
]]
    utils.writeFile(editorconfig_path, editorconfig)
end, { desc = "Generate .editorconfig", nargs = '*' })
