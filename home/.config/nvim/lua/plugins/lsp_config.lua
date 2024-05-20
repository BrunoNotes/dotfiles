local icons = require("utils").icons

local lang_config = function(lsp_config, lsp_capabilities, mason_lspconfig)
    mason_lspconfig.setup({
        ensure_installed = {
            -- Replace these with whatever servers you want to install
            'rust_analyzer',
            'taplo',
            'lua_ls',
            'bashls'
        }
    })

    lsp_config.lua_ls.setup({
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Replace"
                }
            }
        }
    })
    -- vim lua completion
    -- vim.api.nvim_get_runtime_file("lua", true) -- neovim api completion without plugin
    require("neodev").setup({})

    lsp_config.rust_analyzer.setup({
        cmd = {
            -- "rustup", "run", "nightly", "rust-analyzer",
            "rustup", "run", "stable", "rust-analyzer",
        },
        settings = {
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy",
                }
            }
        }
    })

    lsp_config.wgsl_analyzer.setup({})
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        pattern = "*.wgsl",
        callback = function()
            vim.bo.filetype = "wgsl"
        end,
    })

    lsp_config.tsserver.setup({
        ---@diagnostic disable-next-line: unused-local
        on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
        end
    })

    lsp_config.gdscript.setup({
        ---@diagnostic disable-next-line: unused-local
        on_attach = function(client, bufnr)
        end,
        flags = {
            debounce_text_changes = 150,
        }
    })

    mason_lspconfig.setup_handlers({
        function(server_name)
            lsp_config[server_name].setup({
                capabilities = lsp_capabilities,
            })
        end,
    })
end

local cmp_config = function(cmp, luasnip)
    require("luasnip.loaders.from_vscode").lazy_load()

    luasnip.filetype_extend("javascript", { "html" })
    luasnip.filetype_extend("javascriptreact", { "html" })
    luasnip.filetype_extend("typescript", { "html" })
    luasnip.filetype_extend("typescriptreact", { "html" })

    local check_backspace = function()
        local col = vim.fn.col(".") - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
    end

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-k>"] = cmp.mapping.select_prev_item(),
            ["<C-j>"] = cmp.mapping.select_next_item(),
            ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
            ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
            ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
            ["<C-e>"] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),
            ["<S-L>"] = cmp.mapping(function(fallback)
                if luasnip.expandable() then
                    luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, {
                "i",
                "s",
            }),
            ["<S-H>"] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, {
                "i",
                "s",
            }),
            -- Accept currently selected item. If none selected, `select` first item.
            -- Set `select` to `false` to only confirm explicitly selected items.
            ["<CR>"] = cmp.mapping.confirm({ select = false }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif check_backspace() then
                    fallback()
                else
                    fallback()
                end
            end, {
                "i",
                "s",
            }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, {
                "i",
                "s",
            }),
        }),
        formatting = {
            fields = { "abbr", "menu", "kind" },
            format = function(entry, vim_item)
                -- vim_item.kind = kind_icons[vim_item.kind]
                vim_item.kind = string.format('%s %s', icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
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
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        'williamboman/mason.nvim',
        "williamboman/mason-lspconfig.nvim",
        -- completion:
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lua",
        "folke/neodev.nvim",
        -- snippets:
        "L3MON4D3/LuaSnip",
        'saadparwaiz1/cmp_luasnip',
        "rafamadriz/friendly-snippets",
    },
    config = function()
        require('mason').setup()
        require('mason.settings').set({
            ui = {
                border = 'rounded'
            }
        })

        local signs = {
            { icon = icons.error, hl = 'DiagnosticSignError' },
            { icon = icons.warn,  hl = 'DiagnosticSignWarn' },
            { icon = icons.hint,  hl = 'DiagnosticSignHint' },
            { icon = icons.info,  hl = 'DiagnosticSignInfo' }
        }

        for _, sign in ipairs(signs) do
            vim.fn.sign_define(sign.hl, { texthl = sign.hl, text = sign.icon, numhl = '' })
        end

        cmp_config(require("cmp"), require("luasnip"))
        lang_config(require("lspconfig"), require("cmp_nvim_lsp").default_capabilities(), require("mason-lspconfig"))

        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                -- Create your keybindings here...
                local nmap = require("utils").nmap

                nmap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { "Go to declaration" })
                nmap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { "Go to definition" })
                nmap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", { "Hover" })
                nmap("gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", { "Go to implementation" })
                nmap("gr", "<cmd>lua vim.lsp.buf.references()<CR>", { "Go to reference" })
                nmap("H", "<cmd>lua vim.diagnostic.open_float()<CR>", { "Open diagnostic" })
                nmap("<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", { "Rename" })
                nmap("<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { "Rename" })
                nmap("<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>", { "Format file" })
                nmap("<leader>li", "<cmd>LspInfo<cr>", { "Info" })
                nmap("<leader>lI", "<cmd>LspInstallInfo<cr>", { "Install info" })
                nmap("<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", { "Code action" })
                nmap("<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", { "Go to next definition" })
                nmap("<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", { "Go to previous definition" })
                nmap("<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { "Help" })
                nmap("<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", { "setloclist" })
            end
        })

        vim.diagnostic.config({
            -- virtual_text = true, -- disable virtual text
            virtual_text = {
                -- source = "always",  -- Or "if_many"
                severity = vim.diagnostic.severity.ERROR,
                spacing = 10,
                prefix = '',
                sufix = '',
                format = function(diagnostic)
                    if diagnostic.severity == vim.diagnostic.severity.ERROR then
                        return string.format("%s %s", icons.error, diagnostic.message)
                    end
                    if diagnostic.severity == vim.diagnostic.severity.WARN then
                        return string.format("%s %s", icons.warn, diagnostic.message)
                    end
                    if diagnostic.severity == vim.diagnostic.severity.INFO then
                        return string.format("%s %s", icons.info, diagnostic.message)
                    end
                    if diagnostic.severity == vim.diagnostic.severity.HINT then
                        return string.format("%s %s", icons.hint, diagnostic.message)
                    end
                    return diagnostic.message
                end,
            },
            signs = {
                active = signs
            },
            float = {
                border = "rounded"
            }
        })

        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
            vim.lsp.handlers.hover,
            { border = "rounded" }
        )

        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            { border = "rounded" }
        )
    end,
}
