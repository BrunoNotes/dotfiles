local icons = require("utils").icons
local utils = require("utils")
local mason_folder = vim.fn.stdpath("data") .. "/mason"

local get_bin_path = function(localPath, masonPath)
    if utils.file_exists(vim.fn.expand(localPath)) then
        return vim.fn.expand(localPath)
    else
        return mason_folder .. masonPath
    end
end


local lang_config = function(lsp_config, lsp_capabilities, mason_lspconfig)
    mason_lspconfig.setup({
        ensure_installed = {
            -- Replace these with whatever servers you want to install
            'lua_ls',
        }
    })

    lsp_config.lua_ls.setup({
        settings = {
            Lua = {
                completion = {
                    callSnippet = "Disable"
                },
            }
        }
    })
    -- vim lua completion
    -- vim.api.nvim_get_runtime_file("lua", true) -- neovim api completion without plugin
    require("neodev").setup({})

    lsp_config.rust_analyzer.setup({
        settings = {
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy",
                }
            }
        }
    })

    lsp_config.ts_ls.setup({
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

    -- zig
    local zls_folder = get_bin_path("$HOME/opt/zls/zig-out/bin/zls", "/bin/zls")
    lsp_config.zls.setup({
        settings = {
            zls = {
                enable_snippets = false,
            },
        },
        cmd = {
            zls_folder
        }
    })
    vim.g.zig_fmt_autosave = 0

    mason_lspconfig.setup_handlers({
        function(server_name)
            lsp_config[server_name].setup({
                capabilities = lsp_capabilities,
            })
        end,
    })
end

local cmp_config = function(cmp, luasnip)
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
            { icon = icons.warn, hl = 'DiagnosticSignWarn' },
            { icon = icons.hint, hl = 'DiagnosticSignHint' },
            { icon = icons.info, hl = 'DiagnosticSignInfo' }
        }

        for _, sign in ipairs(signs) do
            vim.fn.sign_define(sign.hl, { texthl = sign.hl, text = sign.icon, numhl = '' })
        end

        cmp_config(require("cmp"), require("luasnip"))
        lang_config(require("lspconfig"), require("cmp_nvim_lsp").default_capabilities(), require("mason-lspconfig"))

        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            ---@diagnostic disable-next-line: unused-local
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client then return end

                -- Create your keybindings here...
                local modes = require("utils").key_modes
                local keybindings = {
                    { modes.normal, "gD", function() vim.lsp.buf.declaration() end, "LSP: Go to declaration" },
                    { modes.normal, "gd", function() vim.lsp.buf.definition() end, "LSP: Go to definition" },
                    { modes.normal, "K", function() vim.lsp.buf.hover() end, "LSP: Hover" },
                    { modes.normal, "gI", function() vim.lsp.buf.implementation() end, "LSP: Go to implementation" },
                    { modes.normal, "gr", function() vim.lsp.buf.references() end, "LSP: Go to reference" },
                    { modes.normal, "H", function() vim.diagnostic.open_float() end, "LSP: Open diagnostic" },
                    { modes.normal, "<F2>", function() vim.lsp.buf.rename() end, "LSP: Rename" },
                    { modes.normal, "<leader>lr", function() vim.lsp.buf.rename() end, "LSP: Rename" },
                    { modes.normal, "<leader>lf", function() vim.lsp.buf.format() end, "LSP: Format file" },
                    { modes.normal, "<leader>li", function() vim.cmd(":LspInfo") end, "LSP: Info" },
                    { modes.normal, "<leader>lI", function() vim.cmd(":LspInstallInfo") end, "LSP: Install info" },
                    { modes.normal, "<leader>la", function() vim.lsp.buf.code_action() end, "LSP: Code action" },
                    { modes.normal, "<leader>lj", function() vim.diagnostic.goto_next({ buffer = 0 }) end, "LSP: Go to next definition" },
                    { modes.normal, "<leader>lk", function() vim.diagnostic.goto_prev({ buffer = 0 }) end, "LSP: Go to previous definition" },
                    { modes.normal, "<leader>ls", function() vim.lsp.buf.signature_help() end, "LSP: Help" },
                    { modes.normal, "<leader>lq", function() vim.diagnostic.setloclist() end, "LSP: setloclist" },
                }

                for _, key in ipairs(keybindings) do
                    vim.keymap.set(key[1], key[2], key[3], { silent = true, desc = key[4] })
                end

                -- format on save
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = args.buf,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                        end,
                    })
                end
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
