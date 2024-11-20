return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",  -- required
        "sindrets/diffview.nvim", -- optional - Diff integration
    },
    config = function()
        local neogit = require("neogit")
        local nmap = require("utils").nmap

        neogit.setup({})

        nmap("<leader>gs", function()
            neogit.open({ kind = "split_below" })
        end, "Opens neogit")
    end
}
