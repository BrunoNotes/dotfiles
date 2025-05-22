return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        { dir = "~/.config/nvim/custom_plugins/session.nvim" },
    },
    config = function()
        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin")
        local session = require("session")

        local session_paths = {
            "Code/*/*",
            "Code/*",
            "Code",
            "dotfiles",
            "dotfiles/*",
            "dotfiles/*/*",
            "dotfiles/*/.*",
            "dotfiles/*/.*/*",
            "dotfiles/*/.*/.*",
            "dotfiles/*/*/*",
            "SharedConfig/notes",
        }

        session.setup({
            paths = session_paths,
            telescope_opts = require("telescope.themes").get_ivy {
                layout_config = {
                    bottom_pane = {
                        height = 0.5,
                    },
                }
            },
        })

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
                preview = false,
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

        local is_inside_work_tree = {} -- cache


        local keybindings = {
            { modes.normal, "<leader>.", function()
                -- Falling back to find_files if git_files can't find a .git directory
                local opts = {
                    -- cwd = vim.loop.cwd(),
                    cwd = vim.fn.getcwd(),
                }

                local cwd = vim.fn.getcwd()
                if is_inside_work_tree[cwd] == nil then
                    vim.fn.system("git rev-parse --is-inside-work-tree")
                    is_inside_work_tree[cwd] = vim.v.shell_error == 0
                end

                if is_inside_work_tree[cwd] then
                    -- builtin.git_files(opts)
                    builtin.find_files(opts)
                else
                    builtin.find_files(opts)
                end
            end, "Telescope: git|find files" },
            { modes.normal, "<leader>ff", builtin.find_files, "Telescope: find files" },
            { modes.normal, "<leader>fg", builtin.git_files, "Telescope: git files" },
            { modes.normal, "<leader>gk", builtin.keymaps, "Telescope: keymaps" },                                          -- list keymaps
            { modes.normal, "<leader>gf", builtin.current_buffer_fuzzy_find, "Telescope: fuzzy finder on current buffer" }, -- grep current file
            { modes.normal, "<leader>gp", builtin.live_grep, "Telescope: live grep on project dir" },
            { modes.normal, "<leader>gb", builtin.buffers, "Telescope: buffers" },
            { modes.normal, "<leader>gh", builtin.help_tags, "Telescope: help" },
            { modes.normal, "<leader>gm", builtin.man_pages, "Telescope: Man Page" },
            { modes.normal, "<leader>gd", builtin.diagnostics, "Telescope: LSP diagnostics" },
            { modes.normal, "<leader>gc", builtin.commands, "Telescope: commands" },
            -- customs
            { modes.normal, "<leader>fs", function()
                session.findSession()
            end, "Telescope (custom): find sessions" },
        }

        for _, key in ipairs(keybindings) do
            vim.keymap.set(key[1], key[2], key[3], { silent = true, desc = key[4] })
        end
    end
}
