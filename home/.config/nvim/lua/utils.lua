local M = {}

M.home = vim.fn.expand("~")
M.nvim_config = vim.fn.stdpath("config")
M.nvim_data = vim.fn.stdpath("data")

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

local term_buf = nil

M.openTerminal = function(opts)
    opts = opts or {}

    local ok, _ = pcall(vim.api.nvim_buf_get_name, term_buf)

    if ok and term_buf ~= nil then
        vim.api.nvim_set_current_buf(term_buf)
    else
        vim.cmd.term()
        term_buf = vim.api.nvim_get_current_buf()
    end

    -- Start in insert mode
    vim.cmd.startinsert()
end

M.runOnTerminal = function(opts)
    opts = opts or {}

    if opts ~= {} then
        if vim.fn.executable(opts) == 0 then
            print(opts .. " not found")
            return
        end
    end

    -- Create an immutable scratch buffer that is wiped once hidden
    local buf = vim.api.nvim_create_buf(false, true)

    vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
    vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

    -- Create a floating window using the scratch buffer positioned in the middle
    local screen_size = 0.9
    local height = math.ceil(vim.o.lines * screen_size)
    local width = math.ceil(vim.o.columns * screen_size)
    local win = vim.api.nvim_open_win(buf, true, {
        style = "minimal",
        relative = "editor",
        width = width,
        height = height,
        row = math.ceil((vim.o.lines - height) / 2),
        col = math.ceil((vim.o.columns - width) / 2),
        -- border = "rounded",
    })

    -- Change to the window that is floating to ensure termopen uses correct size
    vim.api.nvim_set_current_win(win)

    -- Launch, and configure to close the window when the process exits
    vim.fn.termopen({ opts }, {
        on_exit = function(_, _, _)
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_close(win, true)
            end
        end
    })

    -- Start in insert mode
    vim.cmd.startinsert()
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
    lang = "l",
    select = "s",
}

return M
