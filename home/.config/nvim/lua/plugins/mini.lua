return {
    {
        'echasnovski/mini.icons',
        opts = {}
    },
    {
        'nvim-mini/mini.pick',
        version = '*',
        config = function()
            require('mini.pick').setup({
                mappings = {
                    move_down = '<C-j>',
                    move_up = '<C-k>',
                },
            })

            vim.keymap.set("n", "<leader>.", function() vim.cmd("Pick files") end)
            vim.keymap.set("n", "<leader>gh", function() vim.cmd("Pick help") end)
            vim.keymap.set("n", "<leader>gp", function()
                require("mini.pick").builtin.grep_live({
                    tool = "git"
                })
            end)
            vim.keymap.set("n", "<leader>gf", function() vim.cmd("Pick grep") end)
            vim.keymap.set("n", "<leader>gb", function() vim.cmd("Pick buffers") end)
        end
    },
}
