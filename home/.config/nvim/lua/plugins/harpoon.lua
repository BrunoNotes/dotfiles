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

        nmap("<leader>hf", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { "menu" })
        nmap("<leader>ha", function() harpoon:list():append() end, { "add" })
        nmap("<C-n>", function() harpoon:list():next() end, { "next" })
        nmap("<C-p>", function() harpoon:list():prev() end, { "previous" })
        nmap("<leader>1", function() harpoon:list():select(1) end, { "go to 1" })
        nmap("<leader>2", function() harpoon:list():select(2) end, { "go to 2" })
        nmap("<leader>3", function() harpoon:list():select(3) end, { "go to 3" })
        nmap("<leader>4", function() harpoon:list():select(4) end, { "go to 4" })
    end,
}
