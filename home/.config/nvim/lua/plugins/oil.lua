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
                -- ["<C-l>"] = "actions.select",
                ["<C-s>"] = ":w<cr>",
                -- ["<C-s>"] = "actions.select_vsplit",
                -- ["<C-h>"] = "actions.select_split",
                -- ["<C-t>"] = "actions.select_tab",
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                ["<ESC>"] = "actions.close",
                ["<C-r>"] = "actions.refresh",
                ["-"] = "actions.parent",
                -- ["<C-h>"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
        })

        nmap("<leader>fb", ":Oil <cr>", "Oil: opens file browser")
        -- nmap("<leader>fb", ":Oil --float<cr>", { "Oil: opens file browser" })
    end
}
