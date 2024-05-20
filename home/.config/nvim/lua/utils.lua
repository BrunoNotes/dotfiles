local description = function(descs)
    local desc = ""
    ---@diagnostic disable-next-line: unused-local
    for i, v in ipairs(descs) do
        if desc == "" then
            desc = tostring(v)
        else
            desc = desc .. ", " .. tostring(v)
        end
    end
    return desc
end

local M = {}

M.find_buffer_by_name = function(name)
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local buf_name = vim.api.nvim_buf_get_name(buf)
        if string.find(buf_name, name) then
            -- return buf_name -- name
            return buf -- nuber
        end
    end
    return -1
end

M.table_size = function(table)
    local size = 0
    for _ in pairs(table) do size = size + 1 end
    return size
end

M.nmap = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { silent = true, desc = description(desc) })
end

M.imap = function(keys, func, desc)
    vim.keymap.set("i", keys, func, { silent = true, desc = description(desc) })
end

M.vmap = function(keys, func, desc)
    vim.keymap.set("v", keys, func, { silent = true, desc = description(desc) })
end

M.xmap = function(keys, func, desc)
    vim.keymap.set("x", keys, func, { silent = true, desc = description(desc) })
end

M.tmap = function(keys, func, desc)
    vim.keymap.set("t", keys, func, { silent = true, desc = description(desc) })
end

M.icons = {
    error = '',
    warn = '',
    hint = '',
    info = '',
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
    Git = "",
    Bug = "",
    Circle = "",
    BoldArrowDown = "",
    BoldArrowLeft = "",
    BoldArrowRight = "",
    BoldArrowUp = "",
    Check = "✔",
}


M.icon_patterns = {
    dots = {
        "⠋",
        "⠙",
        "⠹",
        "⠸",
        "⠼",
        "⠴",
        "⠦",
        "⠧",
        "⠇",
        "⠏",
    },
    dots_pulse = {
        "∙∙∙",
        "●∙∙",
        "∙●∙",
        "∙∙●",
        "∙∙∙",
    },
    grow_vertical = {
        "▁",
        "▃",
        "▄",
        "▅",
        "▆",
        "▇",
        "▆",
        "▅",
        "▄",
        "▃",
    },
    moon = {
        "🌑 ",
        "🌒 ",
        "🌓 ",
        "🌔 ",
        "🌕 ",
        "🌖 ",
        "🌗 ",
        "🌘 ",
    }
}

return M
