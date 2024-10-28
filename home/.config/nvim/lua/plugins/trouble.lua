return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    config = function()
        local trouble = require("trouble")
        local nmap = require("utils").nmap

        nmap("<leader>tt", function() trouble.toggle("diagnostics") end, "Trouble: toggle diagnostics")
        nmap("<leader>tn", function() trouble.next("diagnostics") end, "Trouble: next diagnostics")
        nmap("<leader>tp", function() trouble.prev("diagnostics") end, "Trouble: prev diagnostics")

        -- nmap("<F9>", function() trouble.toggle("diagnostics") end, "Trouble: toggle diagnostics")
        -- nmap("<F10>", function() trouble.prev("diagnostics") end, "Trouble: prev diagnostics")
        -- nmap("<F11>", function() trouble.next("diagnostics") end, "Trouble: next diagnostics")
    end
}
