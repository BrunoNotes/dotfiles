return {
    "ThePrimeagen/harpoon",
    dependencies = {
        { "nvim-lua/plenary.nvim" },
    },
    branch = "harpoon2",
    config = function()
        -- require("plugins.config.harpoon-rc")
        local harpoon = require("harpoon")

        harpoon:setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true
            }
        })

        local modes = require("utils").key_modes
        local keybindings = {
            { modes.normal, "<leader>hf", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "Harpoon: menu" },
            { modes.normal, "<leader>ha", function() harpoon:list():add() end, "Harpoon: add" },
            { modes.normal, "<leader>hn", function() harpoon:list():next() end, "Harpoon: next" },
            { modes.normal, "<leader>hp", function() harpoon:list():prev() end, "Harpoon: previous" },
        }

        for _, key in ipairs(keybindings) do
            vim.keymap.set(key[1], key[2], key[3], { silent = true, desc = key[4] })
        end

        for _, n in ipairs({ 1, 2, 3, 4, 5 }) do
            vim.keymap.set(
                modes.normal,
                "<leader>" .. n,
                function() harpoon:list():select(n) end,
                { silent = true, desc = "Harpoon: go to list " .. n }
            )
        end
    end,
}
