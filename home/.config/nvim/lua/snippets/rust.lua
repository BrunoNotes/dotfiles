local luasnip = require("luasnip")
local s = luasnip.snippet
local sn = luasnip.snippet_node
local t = luasnip.text_node
local i = luasnip.insert_node


local M = {
    s("derive", {
        t("#[derive("), i(1), t(")]")
    }),
    s("default", {
        t("#[default]")
    }),
}

return M
