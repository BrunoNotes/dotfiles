return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    config = function()
        local trouble = require("trouble")
        local nmap = require("utils").nmap

        nmap("<leader>tb", function() trouble.toggle() end, { "Toggle" })
        nmap("<leader>tn", function() trouble.next({ skip_groups = true, jump = true }) end, { "Next item" })
        nmap("<leader>tp", function() trouble.previous({ skip_groups = true, jump = true }) end, { "Previous item" })
        nmap("<F9>", function() trouble.toggle() end, { "Toggle" })
        nmap("<F11>", function() trouble.next({ skip_groups = true, jump = true }) end, { "Next item" })
        nmap("<F10>", function() trouble.previous({ skip_groups = true, jump = true }) end, { "Next item" })
        nmap("<leader>tw", function() trouble.toggle("workspace_diagnostics") end, { "Toggle workspace diagnostics" })
        nmap("<leader>td", function() trouble.toggle("document_diagnostics") end, { "Toggle document diagnostics" })
        nmap("<leader>tq", function() trouble.toggle("quickfix") end, { "Toggle quickfix" })
        nmap("<leader>tl", function() trouble.toggle("loclist") end, { "Toggle loclist" })
    end
}
