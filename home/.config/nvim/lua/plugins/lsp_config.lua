local icons = require("utils").icons
local utils = require("utils")
local mason_folder = vim.fn.stdpath("data") .. "/mason"

local _border = "rounded"

local getBinPath = function(localPath, masonPath)
    if utils.fileExists(vim.fn.expand(localPath)) then
        return vim.fn.expand(localPath)
    else
        return mason_folder .. masonPath
    end
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        'williamboman/mason.nvim',
        "williamboman/mason-lspconfig.nvim",
        -- "hrsh7th/nvim-cmp",
        'saghen/blink.cmp',
        "folke/neodev.nvim",
    },
    config = function()
        require('mason').setup()
        require('mason.settings').set({
            ui = {
                border = 'rounded'
            }
        })
        local lsp_config = require("lspconfig")
        -- local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lsp_capabilities = require('blink.cmp').get_lsp_capabilities()
        local mason_lspconfig = require("mason-lspconfig")

        -- langs --
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
            },
            capabilities = lsp_capabilities,
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
            },
            capabilities = lsp_capabilities,
        })

        lsp_config.ts_ls.setup({
            ---@diagnostic disable-next-line: unused-local
            on_attach = function(client, bufnr)
                client.server_capabilities.documentFormattingProvider = false
            end,
            capabilities = lsp_capabilities,
        })

        lsp_config.gdscript.setup({
            ---@diagnostic disable-next-line: unused-local
            on_attach = function(client, bufnr)
            end,
            flags = {
                debounce_text_changes = 150,
            },
            capabilities = lsp_capabilities,
        })

        -- zig
        local zls_folder = getBinPath("$HOME/opt/zls/zig-out/bin/zls", "/bin/zls")
        lsp_config.zls.setup({
            settings = {
                zls = {
                    enable_snippets = false,
                },
            },
            cmd = {
                zls_folder
            },
            capabilities = lsp_capabilities,
        })
        vim.g.zig_fmt_autosave = 0

        mason_lspconfig.setup_handlers({
            function(server_name)
                lsp_config[server_name].setup({
                    capabilities = lsp_capabilities,
                })
            end,
        })

        -- end langs --

        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client then return end

                -- Create your keybindings here...
                local modes = utils.key_modes
                local keybindings = {
                    { modes.normal, "K", function() vim.lsp.buf.hover({ border = _border }) end, "LSP: Hover" },
                    { modes.normal, "H", function() vim.diagnostic.open_float() end, "LSP: diagnostics" },
                    { modes.insert, "<C-S>", function() vim.lsp.buf.signature_help({ border = _border }) end, "LSP: Signature help" },
                    { modes.normal, "gD", function() vim.lsp.buf.declaration() end, "LSP: Go to declaration" },
                    { modes.normal, "gd", function() vim.lsp.buf.definition() end, "LSP: Go to definition" },
                    { modes.normal, "<F2>", function() vim.lsp.buf.rename() end, "LSP: Rename" },
                    { modes.normal, "<leader>lf", function() vim.lsp.buf.format() end, "LSP: Format file" },
                    { modes.normal, "<leader>li", function() vim.cmd(":LspInfo") end, "LSP: Info" },
                    { modes.normal, "<leader>lI", function() vim.cmd(":LspInstallInfo") end, "LSP: Install info" },
                }

                for _, key in ipairs(keybindings) do
                    vim.keymap.set(key[1], key[2], key[3], { silent = true, desc = key[4] })
                end

                -- format on save
                vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = args.buf,
                    callback = function()
                        if client:supports_method("textDocument/formatting") then
                            vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
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
            float = {
                border = _border
            }
        })
    end,
}
