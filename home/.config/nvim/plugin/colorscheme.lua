-- colorscheme
local status_ok, theme = pcall(require, "tokyonight")
if status_ok then
    vim.cmd("colorscheme tokyonight")
else
    vim.cmd("colorscheme default")
end

-- Spellcheck colors
vim.api.nvim_set_hl(0, 'SpellBad', { fg = "#ff4499", undercurl = true })
vim.api.nvim_set_hl(0, 'SpellLocal', { fg = "#ff4499", undercurl = true })
vim.api.nvim_set_hl(0, 'SpellCap', { fg = "#e0af68", undercurl = true })
vim.api.nvim_set_hl(0, 'SpellRare', { fg = "#e0af68", undercurl = true })
