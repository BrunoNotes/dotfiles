local write_file = require("utils").write_file
local read_json = require("utils").read_json
local file_exists = require("utils").file_exists

-- a json file to configure some options per project

local env_path = vim.fn.getcwd() .. "/.nvim_env"

-- config options per project
local env_table = {
    dap_executable_path = "",
    dap_type = "", -- like godot for c#
}

vim.api.nvim_create_user_command("GenNvimEnv", function()
    local json = vim.json.encode(env_table)
    write_file(env_path, json)
end, { desc = "Generate empty nvim env file", nargs = '*' })


local M = {}

M.get_env = function()
    if file_exists(env_path) then
        return read_json(env_path)
    else
        return nil
    end
end

M.write_json_env = function(json)
    local json_content = vim.json.encode(json)
    write_file(env_path, json_content)
end

return M
