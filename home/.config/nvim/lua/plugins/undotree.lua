return {
    "mbbill/undotree",
    config = function()
        local nmap = require("utils").nmap

        nmap("<leader>u", vim.cmd.UndotreeToggle, "UndoTree: toggle")
    end,
}
