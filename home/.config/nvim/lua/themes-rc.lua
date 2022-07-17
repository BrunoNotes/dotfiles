local colorscheme = "tokyonight"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

vim.cmd([[highlight Normal guibg=none ctermbg=NONE]])
vim.cmd([[let g:lightline = {'colorscheme': 'tokyonight'}]])
vim.cmd([[highlight NvimTreeNormal guibg=none]])
