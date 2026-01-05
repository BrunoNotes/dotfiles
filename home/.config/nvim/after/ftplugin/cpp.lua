local utils = require("utils");

local path = vim.fn.getcwd() .. "/.clang-format"

local text = [[
---
Language:        Cpp
AllowShortFunctionsOnASingleLine: None
ColumnLimit: 0
IndentWidth: 4
UseTab: Never
PointerAlignment: Left
SortIncludes: false
BreakBeforeBraces: Attach
AlignAfterOpenBracket: false
]]

vim.api.nvim_create_user_command("GenClangFormat", function()
    utils.writeFile(path, text)
end, { desc = "Generate .clang-format for C++", nargs = '*' })
