return {
    {
        dir = "~/.config/nvim/custom_plugins/nvim_env.nvim",
        config = function()
            require("nvim_env")
        end
    },
    -- {
    --     dir = "~/.config/nvim/custom_plugins/session.nvim",
    --     config = function()
    --         require("session").setup({
    --             paths = {
    --                 "Code/*/*",
    --                 "Code/*",
    --                 "Code",
    --                 "dotfiles",
    --                 "dotfiles/*",
    --                 "dotfiles/*/*",
    --                 "dotfiles/*/.*",
    --                 "dotfiles/*/.*/*",
    --                 "dotfiles/*/.*/.*",
    --                 "dotfiles/*/*/*",
    --                 "SharedConfig/notes",
    --             },
    --             telescope_opts = {
    --                 theme = "ivy",
    --                 layout_config = {
    --                     bottom_pane = {
    --                         height = 0.5,
    --                     },
    --                 }
    --             },
    --         })
    --
    --         local modes = require("utils").key_modes
    --
    --         local keybindings = {
    --             { modes.normal, "<leader>se", function()
    --                 require("session").openSession()
    --             end, "Opens sessions" },
    --         }
    --
    --         for _, key in ipairs(keybindings) do
    --             vim.keymap.set(key[1], key[2], key[3], { silent = true, desc = key[4] })
    --         end
    --     end
    -- },
}
