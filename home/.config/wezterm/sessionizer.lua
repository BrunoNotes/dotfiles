local wezterm = require("wezterm")
local act = wezterm.action

-- Based on https://github.com/wez/wezterm/discussions/4796

local function concat_path(path, new_path)
    if path == "" then
        path = new_path
    else
        path = path .. new_path
    end
    return path
end

local home = wezterm.home_dir

local fd = "/bin/fd"

local search_folders = {
    { path = home .. "/SharedConfig", depth = "1" },
    { path = home .. "/Code",         depth = "2" },
    { path = home .. "/dotfiles",     depth = "3" },
}

local M = {}

M.toggle = function(window, pane)
    local projects = {}

    local paths = ""

    for _, folder in ipairs(search_folders) do
        ---@diagnostic disable-next-line: unused-local
        local _success, stdout, _stderr = wezterm.run_child_process({
            fd,
            "-HI",
            "-td",
            "--max-depth=" .. folder.depth,
            ".",
            folder.path })

        paths = concat_path(paths, stdout)
    end

    for line in paths:gmatch("([^\n]*)\n?") do
        if string.find(line, ".git") == nil then
            local project = line
            local label = project
            local id = project
            table.insert(projects, { label = tostring(label), id = tostring(id) })
        end
    end

    window:perform_action(
        act.InputSelector {
            action = wezterm.action_callback(function(win, _, id, label)
                if not id and not label then
                    wezterm.log_info "Cancelled"
                else
                    wezterm.log_info("Selected " .. label)
                    win:perform_action(act.SwitchToWorkspace { name = id, spawn = { cwd = label } }, pane)
                end
            end),
            fuzzy = true,
            title = "Sessionizer",
            choices = projects,
        },
        pane
    )
end

return M
