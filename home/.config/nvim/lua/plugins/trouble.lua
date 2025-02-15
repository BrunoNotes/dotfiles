return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    config = function()
        local trouble = require("trouble")

        local modes = require("utils").key_modes

        local keybindings = {
            { modes.normal, "<leader>tb", function() trouble.toggle("diagnostics") end, "Trouble: toggle diagnostics" },
            { modes.normal, "<leader>tn", function() trouble.next("diagnostics") end,   "Trouble: next diagnostics" },
            { modes.normal, "<leader>tp", function() trouble.prev("diagnostics") end,   "Trouble: prev diagnostics" },
        }

        for _, key in ipairs(keybindings) do
            vim.keymap.set(key[1], key[2], key[3], { silent = true, desc = key[4] })
        end
    end
}
