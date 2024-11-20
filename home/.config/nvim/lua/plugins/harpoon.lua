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

        local nmap = require("utils").nmap

        nmap("<leader>hf", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "Harpoon: menu")
        nmap("<leader>ha", function() harpoon:list():add() end, "Harpoon: add")
        nmap("<leader>n", function() harpoon:list():next() end, "Harpoon: next")
        nmap("<leader>p", function() harpoon:list():prev() end, "Harpoon: previous")
        for _, n in ipairs({ 1, 2, 3, 4, 5 }) do
            nmap(string.format("<leader>%s", n), function() harpoon:list():select(n) end,
                { string.format("Harpoon: go to list %s", n) })
        end
    end,
}
