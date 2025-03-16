local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local getFiles = function(opts)
    opts = opts or {}
    -- print(vim.inspect(opts))
    local home = os.getenv("HOME")
    local files = {}

    for _, value in ipairs(opts.paths) do
        -- for dir in io.popen([[ls -pa  ]] .. home .. "/" .. value .. [[ | grep -v /]]):lines() do
        for dir in io.popen("ls -d  " .. home .. "/" .. value):lines() do
            table.insert(files, dir);
        end
    end

    return files
end

local openSession = function(path)
    vim.fn.chdir(path)

    local scratch_buf = vim.api.nvim_create_buf(false, true);
    -- vim.api.nvim_buf_set_option(buf,);
    vim.api.nvim_set_current_buf(scratch_buf)
    -- vim.cmd.buffer(buf);

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        -- local current_buf = vim.api.nvim_get_current_buf()
        if (scratch_buf ~= buf) then
            vim.api.nvim_buf_delete(buf, { force = true })
        end
    end
end

local default_opts = {
    paths = {},
    telescope_opts = require("telescope.themes").get_ivy {},
}

local M = {}

M.setup = function(opts)
    opts = M.getOpts(opts)

    vim.api.nvim_create_user_command("Sessions", function()
        M.findSession(opts)
    end, { desc = "Open a nvim session", nargs = '*' })
end

M.getOpts = function(opts)
    opts = opts or {}

    if (opts.paths == nil) then
        opts.paths = default_opts.paths
    else
        default_opts.paths = opts.paths
    end

    if (opts.telescope_opts == nil) then
        opts.telescope_opts = default_opts.telescope_opts
    else
        default_opts.telescope_opts = opts.telescope_opts
    end

    return opts
end

M.findSession = function(opts)
    opts = M.getOpts(opts)

    pickers.new(opts.telescope_opts, {
        prompt_title = "Sessions",
        finder = finders.new_table {
            results = getFiles(opts)
        },
        sorter = conf.generic_sorter(opts.telescope_opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                -- print(vim.inspect(selection))

                if (selection[1] ~= "") then
                    openSession(selection[1])
                end
            end)
            return true
        end,
    }):find()
end


return M
