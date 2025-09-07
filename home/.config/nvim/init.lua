----- imports -----

local utils = require("utils");
local icons = utils.icons;

----- options -----

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.showmode = true
vim.opt.swapfile = false
vim.opt.undofile = false
vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "yes"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 50
vim.opt.inccommand = "split"
vim.opt.errorbells = false
vim.opt.tabstop = 4
vim.opt.wrap = false
vim.opt.hlsearch = true
vim.opt.scrolloff = 10
vim.opt.breakindent = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", multispace = "·", nbsp = "␣" }
vim.opt.confirm = true
vim.opt.winborder = "rounded"
vim.opt.timeoutlen = 300
-- vim.opt.spell = true
vim.opt.spelllang = "pt_br,en_us,cjk"

vim.schedule(function()
    vim.o.clipboard = ""
    -- vim.o.clipboard = "unnamedplus"
end)

----- keymaps -----

vim.keymap.set("i", "<C-j>", "<NOP>")
vim.keymap.set("i", "<C-k>", "<NOP>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader><leader>x", function() vim.cmd(":source %") end,
    { silent = true, desc = "Source current file" })
vim.keymap.set("n", "<leader>x", function() vim.cmd(":. lua") end,
    { silent = true, desc = "Execute current line" })
vim.keymap.set("n", "<C-s>", function() vim.cmd.w() end, { silent = true, desc = "Save file" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<ESC>", function() vim.cmd("nohlsearch") end, { desc = "Clear highlights on search" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Keeps the mouse in place while searching" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Keeps the mouse in place while searching" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Keeps the mouse in place while moving" }) -- Move half a page down (zz centers)
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Keeps the mouse in place while moving" }) -- Move half a page up (zz centers)
vim.keymap.set("n", "J", "mzJ`z", { desc = "Leaves the mouse in place while moving text" })
vim.keymap.set("c", "<c-k>", "<c-p>")
vim.keymap.set("c", "<c-j>", "<c-n>")
vim.keymap.set("v", "<", "<gv", { desc = "Indent text left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent text right" })
vim.keymap.set("v", "J", ":move '>+1<CR>gv=gv", { desc = "Move text down" })
vim.keymap.set("v", "K", ":move '<-2<CR>gv=gv", { desc = "Move text up" })
vim.keymap.set("x", "K", ":move '<-2<CR>gv=gv", { desc = "Move text up" })
vim.keymap.set("x", "J", ":move '>+1<CR>gv=gv", { desc = "Move text down" })
vim.keymap.set("x", "p", [["_dP]], { desc = "Dont save deletion on buffer on paste" })
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replaces word under cursor" })
vim.keymap.set("x", "p", '"_dP', { desc = "Paste on top of a word without copying" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Copy to system clipboard" })
vim.keymap.set("v", "p", '"_dP', { desc = "Paste on top of a word without copying" })
vim.keymap.set("v", "<leader>Y", "\"+Y", { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<A-Up>", function() vim.cmd(":resize -2") end, { desc = "Resize window up" })
vim.keymap.set("n", "<A-Down>", function() vim.cmd(":resize +2") end, { desc = "Resize window do wn" })
vim.keymap.set("n", "<A-Left>", function() vim.cmd(":vertical resize  +2") end,
    { desc = "Resize  window left" })
vim.keymap.set("n", "<A-Right>", function() vim.cmd(":vertical resize -2") end,
    { desc = "Resize window rigt" })
vim.keymap.set("n", "<C-w>r", "<C-w><C-r>", { desc = "Swap windows position" })
vim.keymap.set("n", "<leader>bp", function() vim.cmd(":bprevious") end, { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bn", function() vim.cmd(":bnext") end, { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bx", function() vim.cmd(":bd!") end, { desc = "Close buffers" })
vim.keymap.set("n", "<leader>bq", function()
    local current_buf = vim.api.nvim_get_current_buf()
    local count = 0
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if (current_buf ~= buf) then
            vim.api.nvim_buf_delete(buf, { force = true })
            -- vim.api.nvim_buf_delete(buf, { unload = true })
            -- vim.api.nvim_buf_delete(buf, {})
            count = count + 1
        end
    end

    print("Closed " .. count .. " buffers")
end, { desc = "Closes other buffers, leaves current buffer open" })

vim.keymap.set("n", "<leader>sp", function() vim.cmd(":setlocal spell!") end, { desc = "Activate spell check" })
vim.keymap.set("n", "<leader>sr", function() vim.cmd(":spellr") end,
    { desc = "Repeat spell correction to matching words" })

vim.keymap.set("n", "<leader>cc", function()
    local message = vim.fn.input("Commit message: ")
    return {
        vim.cmd(":!git add . && git commit -m '" .. message .. "'"),
        vim.api.nvim_feedkeys("<cr>", "n", false),
        print("Commited: " .. message)
    }
end, { desc = "Quick commit" })

vim.keymap.set("n", "<leader>fo", function() vim.cmd.copen() end, { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>fx", function() vim.cmd.cclose() end, { desc = "Close quickfix list" })
vim.keymap.set("n", "<leader>fn", function() vim.cmd.cnext() end, { desc = "Goes to next quickfix list item" })
vim.keymap.set("n", "<leader>fp", function() vim.cmd.cprevious() end, { desc = "Goes to next quickfix list item" })

vim.keymap.set("n", "<leader>cj", function()
    vim.cmd.cle()
    print("Cleared jump list")
end, { desc = "Clear jump list" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader><CR>", function()
    utils:openTerminal()
end, { desc = "Opens terminal" })

----- autocommands -----

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    desc = "Format options",
    group = vim.api.nvim_create_augroup("b_format_options", { clear = true }),
    callback = function()
        -- vim.cmd("set formatoptions-=cro")
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("b_highlight_yank", { clear = true }),
    callback = function()
        vim.hl.on_yank({ timeout = 50 })
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    desc = "Remove white space at the end",
    group = vim.api.nvim_create_augroup("b_remove_whitespace", { clear = true }),
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    desc = "Change CWD on enter",
    group = vim.api.nvim_create_augroup("b_change_cwd", { clear = true }),
    callback = function()
        local file_cwd = vim.fn.expand("%:p:h")
        if (file_cwd ~= nil or file_cwd ~= "") then
            if string.sub(file_cwd, 1, 3) == "oil" then
                vim.fn.chdir(string.sub(file_cwd, 7, string.len(file_cwd)))
            else
                vim.fn.chdir(file_cwd)
            end
        end

        print(string.format("CWD changed to: %s", vim.loop.cwd()))
    end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    desc = "Clear jump list on enter",
    group = vim.api.nvim_create_augroup("b_jump_list", { clear = true }),
    callback = function()
        vim.cmd.cle();
    end,
})

vim.api.nvim_create_autocmd({ "VimLeave" }, {
    desc = "Clear jump list on exit",
    group = vim.api.nvim_create_augroup("b_jump_list", { clear = true }),
    callback = function()
        vim.cmd.cle();
    end,
})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
    desc = "Terminal local options",
    group = vim.api.nvim_create_augroup("b_custom_term_open", {}),
    callback = function(buf)
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.scrolloff = 0
    end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
    desc = "Status line",
    group = vim.api.nvim_create_augroup("b_status_line", { clear = true }),
    callback = function()
        local getFileName = function()
            local file_path = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
            return string.format('%s', file_path)
        end

        local getGitStatus = function()
            -- check if git exists
            if vim.fn.executable("git") == 1 then
                local git_branch = vim.fn.system { "git", "branch", "--show-current" }:gsub("\n[^\n]*(\n?)$", "%1")
                local is_git_repo = vim.fn.system { "git", "rev-parse", "--is-inside-work-tree" }:gsub("\n[^\n]*(\n?)$",
                    "%1")
                if (is_git_repo == "true") then
                    return string.format('%s %s', icons.Git, git_branch)
                else
                    return ""
                end
            else
                return ""
            end
        end

        local getLspName = function()
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

        vim.opt["statusline"] = table.concat({
            -- left
            " ",
            getFileName(),
            "%=",
            -- middle
            "%=",
            -- right
            getGitStatus(),
            " ",
            '%l:%c',
            " ",
        })
    end,
})

----- user commans -----

vim.api.nvim_create_user_command("ChangeCWD", function()
    local file_cwd = vim.fn.expand("%:p:h")
    if (file_cwd ~= nil or file_cwd ~= "") then
        if string.sub(file_cwd, 1, 3) == "oil" then
            vim.fn.chdir(string.sub(file_cwd, 7, string.len(file_cwd)))
        else
            vim.fn.chdir(file_cwd)
        end
    end

    print(string.format("CWD changed to: %s", vim.loop.cwd()))
end, { desc = "Change current working directory", nargs = '*' })

vim.api.nvim_create_user_command("MakeFileExecutable", function()
    vim.cmd(":!chmod +x %")
end, { desc = "Make current file executable", nargs = '*' })

vim.api.nvim_create_user_command("GenEditorConfig", function()
    local editorconfig_path = vim.fn.getcwd() .. "/.editorconfig"

    local files = utils:scanDir(vim.fn.getcwd())
    -- print(vim.inspect(files))

    local exts = {}

    -- print(vim.inspect(exts))
    for _, file in ipairs(files) do
        local ext = utils.getFileExt(file)
        if not utils.existsInTable(exts, ext) then
            table.insert(exts, ext)
        end
    end

    local editorconfig = [[
[*]
indent_style = space
indent_size = 4
]]
    for _, ext in ipairs(exts) do
        if ext:lower() == "lua" then
            local lua_config = [[
# https://github.com/CppCXY/EmmyLuaCodeStyle/blob/master/lua.template.editorconfig
[*.lua]
# true/false or always
align_continuous_assign_statement = false
align_continuous_rect_table_field = false
# option none / always / contain_curly/
align_array_table = false
        ]]
            editorconfig = editorconfig .. lua_config
        elseif ext:lower() == "cs" then
            local cs_config = [[
# https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/code-style-rule-options?view=vs-2019
[*.cs]
# New line preferences
csharp_new_line_before_open_brace = false
csharp_new_line_before_else = false
csharp_new_line_before_catch = false
csharp_new_line_before_finally = false
csharp_new_line_before_members_in_object_initializers = false
csharp_new_line_before_members_in_anonymous_types = false
csharp_new_line_between_query_expression_clauses = false
        ]]
            editorconfig = editorconfig .. cs_config
        end
    end

    utils.writeFile(editorconfig_path, editorconfig)
end, { desc = "Generate .editorconfig", nargs = '*' })

vim.api.nvim_create_user_command("Terminal", function(opts)
    -- print(vim.inspect(opts))
    utils:openTerminal()
    -- if utils.tableSize(opts.fargs) > 0 then
    --     for _, value in ipairs(opts.fargs) do
    --         if value == "panel" then
    --             utils:openTerminal({floating = false})
    --         else
    --             utils:openTerminal({floating = true})
    --         end
    --     end
    -- else
    --     utils:openTerminal({floating = true})
    -- end
end, { desc = "Opens terminal", nargs = '*' })

----- plugins -----

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = false },
})

----- custom -----

vim.api.nvim_create_user_command("LazyGit", function(opts)
    utils:runOnTerminal({ cmd = "lazygit" })
end, { desc = "Run lazygit in a floating terminal", nargs = '*' })

vim.keymap.set("n", "<leader>gs", function()
    utils:runOnTerminal({ cmd = "lazygit" })
end, { desc = "Run lazygit in a floating terminal" })
