return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {},
    config = function()
        require("nvim-treesitter.configs").setup({
            -- ensure_installed = "all", -- one of "all" or a list of languages
            ensure_installed = {},   -- one of "all" or a list of languages
            sync_install = false,
            ignore_install = { "" }, -- List of parsers to ignore installing
            auto_install = true,
            modules = {},
            highlight = {
                enable = true,    -- false will disable the whole extension
                disable = { "" }, -- list of language that will be disabled
                additional_vim_regex_highlighting = false
            },
            autopairs = {
                enable = true,
            },
            indent = { enable = true, disable = { "" } },
        })
    end,
}
