return {
    "mbbill/undotree",
    config = function()
        local modes = require("utils").key_modes

        local keybindings = {
            { modes.normal, "<leader>u", vim.cmd.UndotreeToggle, "UndoTree: toggle" },
        }

        for _, key in ipairs(keybindings) do
            vim.keymap.set(key[1], key[2], key[3], { silent = true, desc = key[4] })
        end
    end,
}
