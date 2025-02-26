-- csharp
local write_file = require("utils").write_file;

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

vim.api.nvim_create_user_command("OmnisharpJsonGen", function()
    write_file(omnisharp_path, omnisharp_json)
end, { desc = "Generate omnisharp.json for C#", nargs = '*' })
