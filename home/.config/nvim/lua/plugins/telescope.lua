return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin")

        local pickers_config = {
            theme = "ivy",
        }

        telescope.setup {
            defaults = {
                -- Default configuration for telescope goes here:
                path_display = { "smart" },
                file_ignore_patterns = { ".git/", "node_modules" },
                initial_mode = "insert",
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-q>"] = actions.close,
                        ["<C-d>"] = actions.delete_buffer,
                        ["<c-l>"] = actions.select_default,
                    },
                    n = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-q>"] = actions.close,
                        ["<C-d>"] = actions.delete_buffer,
                        ["l"] = actions.select_default,
                        ["<c-l>"] = actions.select_default,
                        ["q"] = actions.close,
                    }
                },
                -- border = false,
                winblend = 0,
                preview = false,
            },
            pickers = {
                -- Default configuration for builtin pickers goes here:
                find_files = {
                    theme = pickers_config.theme,
                    cwd = vim.loop.cwd(),
                    -- cwd = vim.fn.expand("%:p:h"),
                    no_ignore = true,
                    no_ignore_parent = true,
                },
                git_files = pickers_config,
                buffers = pickers_config,
                keymaps = pickers_config,
                live_grep = pickers_config,
                current_buffer_fuzzy_find = pickers_config,
                help_tags = pickers_config,
                diagnostics = pickers_config,
                man_pages = pickers_config
            },
            extensions = {},
        }

        local nmap = require("utils").nmap

        nmap("<leader>.", function()
            builtin.find_files({ cwd = vim.loop.cwd() })
        end, { "Telescope: find files" })
        nmap("<leader>fg", builtin.git_files, "Telescope: git files")
        nmap("<leader>kb", builtin.keymaps, "Telescope: keymaps")                                          -- list keymaps
        nmap("<leader>gf", builtin.current_buffer_fuzzy_find, "Telescope: fuzzy finder on current buffer") -- grep current file
        nmap("<leader>gp", builtin.live_grep, "Telescope: live grep on project dir")
        nmap("<leader>bf", builtin.buffers, "Telescope: buffers")
        nmap("<leader>hp", builtin.help_tags, "Telescope: help")
        nmap("<leader>mp", builtin.man_pages, "Telescope: Man Page")
        nmap("<leader>di", builtin.diagnostics, "Telescope: LSP diagnostics")
    end,
}
