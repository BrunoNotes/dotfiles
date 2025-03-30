local _border = "rounded"
return {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
        { 'L3MON4D3/LuaSnip', version = 'v2.*' }
    },
    version = '1.*',
    opts = {
        keymap = {
            preset = 'none',
            ['<C-k>'] = { 'select_prev', 'show' },
            ['<C-j>'] = { 'select_next', 'show' },
            ['<CR>'] = { 'accept', 'fallback' },

        },
        appearance = {
            nerd_font_variant = 'mono'
        },
        completion = {
            documentation = {
                auto_show = false,
                window = {
                    border = _border,
                },
            },
            menu = {
                border = _border,
                auto_show = false,
                draw = {
                    columns = {
                        -- { "kind_icon", "kind" },
                        { "kind" },
                        { "label", "label_description", gap = 1 },
                    },
                },
            },
            list = {
                selection = {
                    preselect = false, auto_insert = false
                }
            }
        },
        cmdline = {
            keymap = {
                preset = "none",
                ['<C-k>'] = { 'select_prev', 'show' },
                ['<C-j>'] = { 'select_next', 'show' },
                ['<TAB>'] = { 'select_next', 'show' },
                ['<CR>'] = { 'accept', 'fallback' },
            },
            completion = { ghost_text = { enabled = true } }
        },
        signature = { window = { border = _border } },
        snippets = { preset = 'luasnip' },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
}
