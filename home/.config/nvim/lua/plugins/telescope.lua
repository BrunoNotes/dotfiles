return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin")

        require("telescope").setup {
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
                preview = true,
            },
            pickers = {
                -- Default configuration for builtin pickers goes here:
                find_files = {
                    no_ignore = true,
                    no_ignore_parent = true,
                    theme = "ivy",
                    layout_config = {
                        bottom_pane = {
                            height = 0.5,
                        },
                    }
                },
                git_files = {
                    theme = "ivy",
                    layout_config = {
                        bottom_pane = {
                            height = 0.5,
                        },
                    }
                },
                buffers = {
                    theme = "ivy",
                    layout_config = {
                        bottom_pane = {
                            height = 0.5,
                        },
                    }
                },
            },
            extensions = {},
        }
        local modes = require("utils").key_modes

        local keybindings = {
            { modes.normal, "<leader>.", function()
                builtin.find_files({
                    cwd = vim.loop.cwd(),
                })
            end, "Telescope: find files" },
            { modes.normal, "<leader>fg", builtin.git_files,                 "Telescope: git files" },
            { modes.normal, "<leader>kb", builtin.keymaps,                   "Telescope: keymaps" },                        -- list keymaps
            { modes.normal, "<leader>gf", builtin.current_buffer_fuzzy_find, "Telescope: fuzzy finder on current buffer" }, -- grep current file
            { modes.normal, "<leader>gp", builtin.live_grep,                 "Telescope: live grep on project dir" },
            { modes.normal, "<leader>bl", builtin.buffers,                   "Telescope: buffers" },
            { modes.normal, "<leader>hp", builtin.help_tags,                 "Telescope: help" },
            { modes.normal, "<leader>mp", builtin.man_pages,                 "Telescope: Man Page" },
            { modes.normal, "<leader>di", builtin.diagnostics,               "Telescope: LSP diagnostics" },
        }

        for _, key in ipairs(keybindings) do
            vim.keymap.set(key[1], key[2], key[3], { silent = true, desc = key[4] })
        end
    end
}
