local luasnip = require("luasnip")
local s = luasnip.snippet
local sn = luasnip.snippet_node
local t = luasnip.text_node
local i = luasnip.insert_node

local M = {
    s("code", {
        t("```"), i(1, "lang"),
        t({ "", "```" })
    }),
    -- inline
    s("code", {
        t("`"), i(1, "code"), t("`")
    }),
}

return M
