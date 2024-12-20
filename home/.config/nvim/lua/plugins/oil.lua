return {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local nmap = require("utils").nmap

        require("oil").setup({
            default_file_explorer = true,
            columns = {
                "icon",
            },
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<F1>"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-s>"] = ":w<cr>",
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["<ESC>"] = "actions.close",
                ["<C-r>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
        })
        local modes = require("utils").key_modes

        local keybindings = {
            { modes.normal, "<leader>fb", ":Oil <cr>", "Oil: opens file browser" },
            -- { modes.normal, "<leader>fb", ":Oil --float<cr>", "Oil: opens file browser" },
        }

        for _, key in ipairs(keybindings) do
            vim.keymap.set(key[1], key[2], key[3], { silent = true, desc = key[4] })
        end
    end
}
