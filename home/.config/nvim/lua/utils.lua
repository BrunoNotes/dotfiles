local M = {}

M.findBufferByName = function(name)
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local buf_name = vim.api.nvim_buf_get_name(buf)
        if string.find(buf_name, name) then
            -- return buf_name -- name
            return buf -- nuber
        end
    end
    return -1
end

M.tableSize = function(table)
    local size = 0
    for _ in pairs(table) do size = size + 1 end
    return size
end

M.openFileOrBuffer = function(file_path, buffer)
    if buffer == -1 then
        vim.cmd(string.format(":e %s", file_path))
    else
        vim.cmd(string.format(":buffer %s", buffer))
    end
end

M.fileExists = function(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

M.readFile = function(path)
    local file = assert(io.open(path, "rb"))
    local content = file:read("*a")
    file:close()
    return content
end

M.writeFile = function(path, content)
    local file = assert(io.open(path, "w"))
    file:write(content)
    file:close()
end

M.readJson = function(path)
    local content = M.readFile(path)
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

M.key_modes = {
    normal = "n",
    insert = "i",
    visual = "v",
    visual_block = "x",
    term = "t",
    command = "c",
    select = "s",
}

return M
