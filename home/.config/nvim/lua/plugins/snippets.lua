return {
    "L3MON4D3/LuaSnip",
    dependencies = {
    },
    version = 'v2.*',
    config = function()
        local luasnip = require("luasnip");

        luasnip.add_snippets("html", require("snippets.html"));
        luasnip.add_snippets("rust", require("snippets.rust"));
        luasnip.add_snippets("markdown", require("snippets.markdown"));
        luasnip.add_snippets("zig", require("snippets.zig"));

        luasnip.filetype_extend("javascript", { "html" })
        luasnip.filetype_extend("javascriptreact", { "html" })
        luasnip.filetype_extend("typescript", { "html" })
        luasnip.filetype_extend("typescriptreact", { "html" })
    end,
}
