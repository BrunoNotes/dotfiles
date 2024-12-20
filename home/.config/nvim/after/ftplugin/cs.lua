-- csharp
local write_file = require("utils").write_file;

local editorconfig_path = vim.fn.getcwd() .. "/.editorconfig"

local editorconfig = [[
# https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/code-style-rule-options?view=vs-2019
[*.cs]
###############################
# C# Formatting Rules         #
###############################
# New line preferences
csharp_new_line_before_open_brace = false
csharp_new_line_before_else = false
csharp_new_line_before_catch = false
csharp_new_line_before_finally = false
csharp_new_line_before_members_in_object_initializers = false
csharp_new_line_before_members_in_anonymous_types = false
csharp_new_line_between_query_expression_clauses = false
]]

vim.api.nvim_create_user_command("GenCSharpEditorConfig", function()
    write_file(editorconfig_path, editorconfig)
end, { desc = "Generate .editorconfig for C#", nargs = '*' })

local omnisharp_path = vim.fn.getcwd() .. "/omnisharp.json"

local omnisharp_json = [[
{
    "FormattingOptions": {
        "NewLinesForBracesInLambdaExpressionBody": false,
        "NewLinesForBracesInAnonymousMethods": false,
        "NewLinesForBracesInAnonymousTypes": false,
        "NewLinesForBracesInControlBlocks": false,
        "NewLinesForBracesInTypes": false,
        "NewLinesForBracesInMethods": false,
        "NewLinesForBracesInProperties": false,
        "NewLinesForBracesInObjectCollectionArrayInitializers": false,
        "NewLinesForBracesInAccessors": false,
        "NewLineForElse": false,
        "NewLineForCatch": false,
        "NewLineForFinally": false
    }
}
]]

vim.api.nvim_create_user_command("GenCSharpOmnisharpJson", function()
    write_file(omnisharp_path, omnisharp_json)
end, { desc = "Generate omnisharp.json for C#", nargs = '*' })
