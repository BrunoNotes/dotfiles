local colorscheme = "tokyonight"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

vim.cmd([[highlight Normal guibg=none]])
vim.cmd([[let g:lightline = {'colorscheme': 'tokyonight'}]])
