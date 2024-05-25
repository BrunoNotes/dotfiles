return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    config = function()
        local trouble = require("trouble")
        local nmap = require("utils").nmap

        nmap("<leader>tb", function() trouble.toggle() end, "Trouble: toggle")
        nmap("<leader>tn", function() trouble.next({ skip_groups = true, jump = true }) end, "Trouble: next item")
        nmap("<leader>tp", function() trouble.previous({ skip_groups = true, jump = true }) end, "Trouble: previous item")
        nmap("<leader>tw", function() trouble.toggle("workspace_diagnostics") end,
            "Trouble: toggle workspace diagnostics")
        nmap("<leader>td", function() trouble.toggle("document_diagnostics") end, "Trouble: toggle document diagnostics")
        nmap("<leader>tq", function() trouble.toggle("quickfix") end, "Trouble: toggle quickfix")
        nmap("<leader>tl", function() trouble.toggle("loclist") end, "Trouble: toggle loclist")
    end
}
