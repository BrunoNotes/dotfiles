-- Credits: https://elianiva.my.id/post/neovim-lua-statusline
local fn                    = vim.fn
local api                   = vim.api
local devicons_ok, devicons = pcall(require, "nvim-web-devicons")
local utils                 = require("utils")

local get_devicon           = function()
    if devicons_ok then
        local file_name, file_ext = fn.expand("%:t"), fn.expand("%:e")
        return devicons.get_icon(file_name, file_ext, { default = true })
    else
        return utils.icons.File
    end
end

local M                     = {}

-- possible values are 'blank'
local active_sep            = 'blank'

-- change them if you want to different separator
M.separators                = {
    blank = { ' ', ' ' },
    line = { '|', '|' },
}

M.trunc_width               = setmetatable({
    mode       = 80,
    git_status = 90,
    filename   = 140,
    line_col   = 60,
}, {
    __index = function()
        return 80
    end
})

M.is_truncated              = function(_, width)
    local current_width = api.nvim_win_get_width(0)
    return current_width < width
end

M.get_git_status            = function()
    -- check if git exists
    if vim.fn.executable("git") == 1 then
        local git_branch = vim.fn.system { "git", "branch", "--show-current" }:gsub("\n[^\n]*(\n?)$", "%1")
        local is_git_repo = vim.fn.system { "git", "rev-parse", "--is-inside-work-tree" }:gsub("\n[^\n]*(\n?)$", "%1")
        if (is_git_repo == "true") then
            return string.format('%s %s', utils.icons.Git, git_branch)
        else
            return ""
        end
    else
        return ""
    end
end

M.get_filename              = function(self)
    local file_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
    if self:is_truncated(self.trunc_width.filename) then
        return string.format('%s', file_path)
    end
    return string.format('%s', file_path)
end

M.get_icon                  = function()
    local devicon_icon = get_devicon()

    return string.format('%s', devicon_icon)
end

M.get_line_col              = function(self)
    if self:is_truncated(self.trunc_width.line_col) then return '%l:%c' end
    -- return ' L:%l C:%c '
    return '%l:%c'
end

-- M.get_lsp_name              = function()
--     local lsp_clients = vim.lsp.get_clients()
--
--     if lsp_clients ~= nil then
--         local lsp_names = ""
--         for _, value in ipairs(lsp_clients) do
--             if lsp_names == "" then
--                 lsp_names = tostring(value.name)
--             else
--                 lsp_names = lsp_names .. ", " .. tostring(value.name)
--             end
--         end
--
--         if lsp_names ~= "" then
--             return string.format('%s %s', utils.icons.Constructor, lsp_names)
--         else
--             return ""
--         end
--     end
-- end

M.set_active                = function(self)
    local git = self:get_git_status()
    local separator = self.separators[active_sep]
    local filename = self:get_filename()
    local icon = self.get_icon()
    local line_col = self:get_line_col()
    -- local lsp_client_name = self.get_lsp_name()

    return table.concat({
        -- left
        separator[1],
        icon,
        separator[1],
        filename,
        separator[1],
        "%=",
        -- middle
        "%=",
        -- right
        separator[1],
        git,
        separator[1],
        line_col,
        separator[1],
    })
end

local statusline            = setmetatable(M, {
    __call = function(statusline, mode)
        if mode == "active" then return statusline:set_active() end
    end
})

vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
    callback = function()
        vim.opt["statusline"] = statusline('active')
    end,
})
