return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- "nvim-telescope/telescope-file-browser.nvim"
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        -- local tfb_actions = telescope.extensions.file_browser.actions;

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
            extensions = {
                -- file_browser = {
                --     theme = pickers_config.theme,
                --     cwd = "%:p:h", -- :h expand()
                --     cwd_to_path = false,
                --     grouped = true,
                --     hidden = true,
                --     hijack_netrw = false,
                --     git_status = false,
                --     mappings = {
                --         ["i"] = {
                --             -- your custom insert mode mappings
                --             ["<c-g>"] = false,
                --             ["<c-e>"] = false,
                --             ["<c-t>"] = false,
                --             ["<c-s>"] = actions.toggle_selection,
                --             ["h"] = tfb_actions.goto_parent_dir,
                --             ["<c-h>"] = tfb_actions.goto_parent_dir,
                --             ["<c-H>"] = tfb_actions.toggle_hidden,
                --             ["<c-l>"] = actions.select_default,
                --         },
                --         ["n"] = {
                --             -- your custom normal mode mappings
                --             ["%"] = tfb_actions.create,
                --             ["o"] = false,
                --             ["g"] = false,
                --             ["<c-g>"] = false,
                --             ["e"] = false,
                --             ["<c-e>"] = false,
                --             ["t"] = false,
                --             ["<c-t>"] = false,
                --             ["s"] = actions.toggle_selection,
                --             ["<c-s>"] = actions.toggle_selection,
                --             ["<c-a>"] = tfb_actions.toggle_all,
                --             ["h"] = tfb_actions.goto_parent_dir,
                --             ["<c-h>"] = tfb_actions.goto_parent_dir,
                --             ["<c-H>"] = tfb_actions.toggle_hidden,
                --             ["l"] = actions.select_default,
                --             ["<c-l>"] = actions.select_default,
                --             ["gg"] = tfb_actions.goto_cwd,
                --         },
                --     },
                -- }
            },
        }
        -- telescope.load_extension("file_browser")

        local nmap = require("utils").nmap

        -- nmap("<leader>.", ":Telescope find_files<CR>", { "find files" })
        nmap("<leader>.", function()
            require("telescope.builtin").find_files({ cwd = vim.loop.cwd() })
        end, { "find files" })
        -- nmap("<leader>fb", ":Telescope file_browser<CR><ESC>", { "file browser", category.telescope, category.file_manager })
        nmap("<leader>fg", ":Telescope git_files<CR>", { "git files" })
        nmap("<leader>kb", ":Telescope keymaps<cr>", { "keymaps" })                                          -- list keymaps
        nmap("<leader>gf", ":Telescope current_buffer_fuzzy_find<cr>", { "fuzzy finder on current buffer" }) -- grep current file
        nmap("<leader>gp", ":Telescope live_grep<cr>", { "Telescope live grep on project dir" })
        nmap("<leader>bf", ":Telescope buffers<CR><ESC>", { "Telescope buffers" })
        nmap("<F1>", ":Telescope help_tags<cr>", { "Telescope help" })
        nmap("<leader>hp", ":Telescope help_tags<cr>", { "Telescope help" })
        nmap("<leader>mp", ":Telescope man_pages<cr>", { "Telescope Man Page" })
        nmap("<leader>di", ":Telescope diagnostics<cr>", { "Telescope diagnostics (LSP)" })
    end,
}
