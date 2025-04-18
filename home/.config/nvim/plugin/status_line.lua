-- Credits: https://elianiva.my.id/post/neovim-lua-statusline
local fn = vim.fn
local api = vim.api
local devicons_ok, devicons = pcall(require, "nvim-web-devicons")

local icons = require("utils").icons

local getDevicon = function()
    if devicons_ok then
        local file_name, file_ext = fn.expand("%:t"), fn.expand("%:e")
        return devicons.get_icon(file_name, file_ext, { default = true })
    else
        return icons.File
    end
end

local M = {}

-- possible values are 'blank'
local active_sep = 'blank'

-- change them if you want to different separator
M.separators = {
    blank = { ' ', ' ' },
    line = { '|', '|' },
}

M.trunc_width = setmetatable({
    mode = 80,
    git_status = 90,
    filename = 140,
    line_col = 60,
}, {
    __index = function()
        return 80
    end
})

M.isTruncated = function(_, width)
    local current_width = api.nvim_win_get_width(0)
    return current_width < width
end

M.getGitStatus = function()
    -- check if git exists
    if vim.fn.executable("git") == 1 then
        local git_branch = vim.fn.system { "git", "branch", "--show-current" }:gsub("\n[^\n]*(\n?)$", "%1")
        local is_git_repo = vim.fn.system { "git", "rev-parse", "--is-inside-work-tree" }:gsub("\n[^\n]*(\n?)$", "%1")
        if (is_git_repo == "true") then
            return string.format('%s %s', icons.Git, git_branch)
        else
            return ""
        end
    else
        return ""
    end
end

M.getFilename = function(self)
    local file_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
    if self:isTruncated(self.trunc_width.filename) then
        return string.format('%s', file_path)
    end
    return string.format('%s', file_path)
end

M.getIcon = function()
    local devicon_icon = getDevicon()

    return string.format('%s', devicon_icon)
end

M.getLineCol = function(self)
    if self:isTruncated(self.trunc_width.line_col) then return '%l:%c' end
    -- return ' L:%l C:%c '
    return '%l:%c'
end

M.getLspName = function()
    local lsp_clients = vim.lsp.get_clients()

    if lsp_clients ~= nil then
        local lsp_names = ""
        for _, value in ipairs(lsp_clients) do
            if lsp_names == "" then
                lsp_names = tostring(value.name)
            else
                lsp_names = lsp_names .. ", " .. tostring(value.name)
            end
        end

        if lsp_names ~= "" then
            return string.format('%s %s', icons.Constructor, lsp_names)
        else
            return ""
        end
    end
end

M.setActive = function(self)
    local git = self:getGitStatus()
    local separator = self.separators[active_sep]
    local filename = self:getFilename()
    local icon = self.getIcon()
    local line_col = self:getLineCol()
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

local statusline = setmetatable(M, {
    __call = function(statusline, mode)
        if mode == "active" then return statusline:setActive() end
    end
})

vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
    callback = function()
        vim.opt["statusline"] = statusline('active')
    end,
})
