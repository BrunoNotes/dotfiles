local options = {
    -- :help options
    syntax = "on",
    errorbells = false,
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    smarttab = true,
    smartindent = true,
    hidden = true,
    nu = true,
    relativenumber = true,
    wrap = false,
    backup = false,
    clipboard = "", -- neovim clipboard
    scrolloff = 8,
    showmode = true,
    signcolumn = "yes",
    swapfile = false,
    mouse = "a",
    pumheight = 10,
    ignorecase = true,
    smartcase = true,
    modifiable = true,
    hlsearch = false,
    incsearch = true,
    laststatus = 3,
    termguicolors = true,
    updatetime = 50,
    colorcolumn = "80",
    inccommand = "split",

    -- spell = true,
    spelllang = "pt_br,en_us,cjk",
}

for key, value in pairs(options) do
    vim.opt[string.format("%s", key)] = value
end
