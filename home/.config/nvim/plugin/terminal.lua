local tmap = require("utils").tmap
local nmap = require("utils").nmap

-- Terminal local options
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("custom-term-open", {}),
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.scrolloff = 0
    end,
})

local function openTerminal(shell)
    local buffer = require("utils").find_buffer_by_name("term://")

    if shell == nil then
        shell = os.getenv("SHELL")
    end

    if buffer == -1 then
        vim.cmd(":terminal " .. shell)
    else
        vim.cmd(":buffer %s" .. buffer)
    end
end

local function run_on_terminal(opts)
    opts = opts or {}

    -- Create an immutable scratch buffer that is wiped once hidden
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
    vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

    -- Create a floating window using the scratch buffer positioned in the middle
    local screen_size = 0.8
    local height = math.ceil(vim.o.lines * screen_size)
    local width = math.ceil(vim.o.columns * screen_size)
    local win = vim.api.nvim_open_win(buf, true, {
        style = "minimal",
        relative = "editor",
        width = width,
        height = height,
        row = math.ceil((vim.o.lines - height) / 2),
        col = math.ceil((vim.o.columns - width) / 2),
        border = "none",
    })

    -- Change to the window that is floating to ensure termopen uses correct size
    vim.api.nvim_set_current_win(win)

    -- Launch top, and configure to close the window when the process exits
    vim.fn.termopen({ opts }, {
        on_exit = function(_, _, _)
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_close(win, true)
            end
        end
    })

    -- Start in terminal mode
    vim.cmd.startinsert()
end

vim.api.nvim_create_user_command("TermOpen", function(opts)
    if opts.fargs[1] ~= nil then
        openTerminal(opts.fargs[1])
    else
        openTerminal()
    end
end, { desc = "Open terminal buffer", nargs = '*' })

vim.api.nvim_create_user_command("TermRun", function(opts)
    if opts.fargs[1] ~= nil then
        local cmd = ""
        for _, args in ipairs(opts.fargs) do
            if cmd == "" then
                cmd = args
            else
                cmd = cmd .. " " .. args
            end
        end

        if vim.fn.executable(cmd) == 0 then
            print(cmd .. " is not a executable")
            return
        else
            run_on_terminal(cmd)
        end
    end
end, { desc = "Run cmd in a floating terminal", nargs = '*' })

vim.api.nvim_create_user_command("LazyGit", function(opts)
    if vim.fn.executable("lazygit") == 0 then
        print("lazygit not found")
        return
    else
        run_on_terminal("lazygit")
    end
end, { desc = "Run lazygit in a floating terminal", nargs = '*' })

nmap("<leader>gs", function()
    if vim.fn.executable("lazygit") == 0 then
        print("lazygit not found")
        return
    else
        run_on_terminal("lazygit")
    end
end
, { "Opens lazygit" })

-- tmap("<Esc><Esc>", "<C-\\><C-n>", { "Exit terminal mode" })
