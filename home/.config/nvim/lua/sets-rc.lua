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
    clipboard = "unnamedplus",
    scrolloff = 8,
    showmode = false,
    signcolumn = "yes",
    swapfile = false,
    mouse = "a",
    pumheight = 10,
    ignorecase = true,
    smartcase = true,
    background = nil,
}

for key, value in pairs(options) do
    vim.opt[key] = value
end
