local description = function(descs)
    if type(descs) == "table" then
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
    else
        return descs
    end
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

M.open_file_or_buffer = function(file_path, buffer)
    if buffer == -1 then
        vim.cmd(string.format(":e %s", file_path))
    else
        vim.cmd(string.format(":buffer %s", buffer))
    end
end
-- :h map-overview
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

-- terminal mode
M.tmap = function(keys, func, desc)
    vim.keymap.set("t", keys, func, { silent = true, desc = description(desc) })
end

-- select mode
M.smap = function(keys, func, desc)
    vim.keymap.set("s", keys, func, { silent = true, desc = description(desc) })
end

-- command line
M.cmap = function(keys, func, desc)
    vim.keymap.set("c", keys, func, { silent = true, desc = description(desc) })
end

M.file_exists = function(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

M.read_file = function(path)
    local file = assert(io.open(path, "rb"))
    local content = file:read("*a")
    file:close()
    return content
end

M.write_file = function(path, content)
    local file = assert(io.open(path, "w"))
    file:write(content)
    file:close()
end

M.read_json = function(path)
    local content = M.read_file(path)
    local json = vim.json.decode(content)
    return json
end

M.icons = {
    error = '',
    warn = '',
    hint = '',
    info = '',
    Constructor = "",
    Git = "",
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
