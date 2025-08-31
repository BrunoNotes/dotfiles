return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            -- require("plugins.config.harpoon-rc")
            local harpoon = require("harpoon")

            harpoon:setup({
                settings = {
                    save_on_toggle = true,
                    sync_on_ui_close = true
                }
            })

            vim.keymap.set("n", "<leader>hf", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
            vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
            vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end)
            vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end)

            for _, n in ipairs({ 1, 2, 3, 4, 5 }) do
                vim.keymap.set(
                    "n",
                    "<leader>" .. n,
                    function() harpoon:list():select(n) end,
                    { silent = true, desc = "Harpoon: go to list " .. n }
                )
            end
        end,

    }
}
