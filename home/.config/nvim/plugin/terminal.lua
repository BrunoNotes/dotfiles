local utils = require("utils")
local modes = utils.key_modes

local term_buf = nil

local function openTerminal(opts)
    opts = opts or {}

    local ok, _ = pcall(vim.api.nvim_buf_get_name, term_buf)

    if ok and term_buf ~= nil then
        vim.api.nvim_set_current_buf(term_buf)
    else
        vim.cmd.term()
        term_buf = vim.api.nvim_get_current_buf()
    end
end

local function runOnTerminal(opts)
    opts = opts or {}

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
        border = "rounded",
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

    -- Start in terminal mode
    vim.cmd.startinsert()
end

local function runLazyGit()
    if vim.fn.executable("lazygit") == 0 then
        print("lazygit not found")
        return
    else
        runOnTerminal("lazygit")
    end
end

vim.api.nvim_create_user_command("LazyGit", function(opts)
    runLazyGit()
end, { desc = "Run lazygit in a floating terminal", nargs = '*' })

-- Terminal local options
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("custom-term-open", {}),
    callback = function(buf)
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.scrolloff = 0
    end,
})

local keybindings = {
    { modes.term, "<Esc><Esc>", "<C-\\><C-n>", "Exit terminal mode" },
    { modes.normal, "<leader><CR>", function()
        openTerminal()
        -- vim.api.nvim_feedkeys("a", "n", false)
        vim.cmd.startinsert()
    end, "Opens terminal" },

    { modes.normal, "<leader>gs", function() runLazyGit() end, "Opens lazygit" },
}

for _, key in ipairs(keybindings) do
    vim.keymap.set(key[1], key[2], key[3], { silent = true, desc = key[4] })
end
