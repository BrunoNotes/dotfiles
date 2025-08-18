local luasnip = require("luasnip")
local s = luasnip.snippet
local sn = luasnip.snippet_node
local t = luasnip.text_node
local i = luasnip.insert_node


local M = {
    s("shebang", {
        t("#!/bin/bash")
    }),
    s("#!", {
        t("#!/bin/bash")
    }),
}

return M
