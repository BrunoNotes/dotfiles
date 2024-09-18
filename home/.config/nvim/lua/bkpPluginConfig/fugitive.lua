return {
    "tpope/vim-fugitive",
    config = function()
        local nmap = require("utils").nmap

        nmap("<leader>cc", function()
            local message = vim.fn.input("Commit message: ")
            return {
                vim.cmd(":Git add ."),
                vim.cmd(string.format(":Git commit -m '%s'", message)),
                vim.api.nvim_feedkeys("<cr>", "n", false)
            }
        end, "Fugitive: Quick commit")
        nmap("<leader>gs", vim.cmd.Git, "Fugitive: Open")
    end
}
