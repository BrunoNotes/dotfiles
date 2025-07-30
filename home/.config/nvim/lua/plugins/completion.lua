return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lua",
        "L3MON4D3/LuaSnip",
        'saadparwaiz1/cmp_luasnip',
    },
    config = function()
        local luasnip = require("luasnip");
        local cmp = require("cmp");

        luasnip.add_snippets("html", require("snippets.html"));
        luasnip.add_snippets("rust", require("snippets.rust"));
        luasnip.add_snippets("markdown", require("snippets.markdown"));
        luasnip.add_snippets("zig", require("snippets.zig"));

        luasnip.filetype_extend("javascript", { "html" })
        luasnip.filetype_extend("javascriptreact", { "html" })
        luasnip.filetype_extend("typescript", { "html" })
        luasnip.filetype_extend("typescriptreact", { "html" })

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            preselect = cmp.PreselectMode.None,
            completion = { completeopt = "noselect", autocomplete = false },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        cmp.complete()
                    end
                end),
                ["<C-j>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        cmp.complete()
                    end
                end),
                ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                ["<C-e>"] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
                ["<CR>"] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace }),
            }),
            formatting = {
                fields = { "abbr", "menu", "kind" },
                format = function(entry, vim_item)
                    vim_item.kind = string.format('| %s', vim_item.kind)
                    vim_item.menu = ({
                        nvim_lsp = "",
                        nvim_lua = "",
                        luasnip = "",
                        buffer = "",
                        path = "",
                        emoji = "",
                    })[entry.source.name]
                    return vim_item
                end,
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            },
            confirm_opts = {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            experimental = {
                ghost_text = false,
            },
        })
    end,
}
