local utils = require("utils")
local icons = utils.icons

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "mason-org/mason-lspconfig.nvim",
        {
            "saghen/blink.cmp",
            version = '1.*',
            opts = {
                cmdline = { enabled = false },
                keymap = {
                    preset = 'none',
                    ['<C-j>'] = { function(cmp) cmp.show() end, 'select_next', 'fallback' },
                    ['<C-k>'] = { function(cmp) cmp.show() end, 'select_prev', 'fallback' },
                    ['<CR>'] = { 'accept', 'fallback' },
                    ['<TAB>'] = { 'accept', 'fallback' },
                    ['<C-f>'] = { function(cmp) cmp.scroll_documentation_down(4) end, 'fallback' },
                    ['<C-b>'] = { function(cmp) cmp.scroll_documentation_up(4) end, 'fallback' },
                },
                completion = {
                    list = {
                        selection = {
                            preselect = false,
                            auto_insert = false
                        }
                    },
                    menu = {
                        auto_show = false,
                    },
                    documentation = {
                        auto_show = true,
                        auto_show_delay_ms = 500,
                    }
                },
            }
        },
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup()

        local servers_config = {
            ts_ls = {
                on_attach = function(client, bufnr)
                    client.server_capabilities.documentFormattingProvider = false
                end,
            },
            lua_ls = {
                settings = {
                    Lua = {
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true) -- neovim api completion
                        },
                        -- completion = {
                        --     callSnippet = "Disable"
                        -- },
                    }
                },
            },
            ols = {
                init_options = {
                    checker_args = "-strict-style",
                },
            },
            zls = {
                settings = {
                    zls = {
                        enable_snippets = false,
                    },
                },
            },
        }
        -- use local if exists
        local zls_folder = utils.home .. "/opt/zls/zig-out/bin/zls"
        if utils.fileExists(zls_folder) then
            servers_config.zls.cmd = { zls_folder }
        end
        vim.g.zig_fmt_autosave = 0

        -- require("mason-lspconfig").setup_handlers({
        --     function(server_name)
        --         local config = servers_config[server_name] or {}
        --
        --         config.capabilities = require('blink.cmp').get_lsp_capabilities()
        --         require("lspconfig")[server_name].setup(config)
        --     end,
        -- })
        for server, config in pairs(servers_config) do
            config.capabilities = require('blink.cmp').get_lsp_capabilities()
            require("lspconfig")[server].setup(config)
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("b_lsp_attach", { clear = true }),
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client then return end

                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
                vim.keymap.set("n", "H", function() vim.diagnostic.open_float() end)
                vim.keymap.set("i", "<C-S>", function() vim.lsp.buf.signature_help() end)
                vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end)
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
                vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end)
                vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end)

                -- if client:supports_method("textDocument/completion") then
                --     -- adds completion to the default list (<C-x><C-o>)
                --     vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
                --     vim.cmd("set completeopt+=noselect")
                -- end

                vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
                vim.api.nvim_create_autocmd("BufWritePre", {
                    desc = "Format on save",
                    group = vim.api.nvim_create_augroup("b_lsp_format", { clear = true }),
                    buffer = args.buf,
                    callback = function()
                        if client:supports_method("textDocument/formatting") then
                            vim.lsp.buf.format({
                                bufnr = args.buf,
                                id = client.id,
                                timeout_ms = 1000
                            })
                        end
                    end,
                })
            end
        })

        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = icons.error,
                    [vim.diagnostic.severity.WARN] = icons.warn,
                    [vim.diagnostic.severity.HINT] = icons.hint,
                    [vim.diagnostic.severity.INFO] = icons.info,
                },
            },
            -- virtual_lines or virtual_text
            virtual_text = {
                -- source = "always",  -- Or "if_many"
                severity = vim.diagnostic.severity.ERROR,
                spacing = 10,
                prefix = "",
                sufix = "",
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
        })
    end,
}
