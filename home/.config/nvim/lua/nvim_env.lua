local env_path = vim.fn.getcwd() .. "/.nvim_env"

local env_table = {
    dap_executable_path = ""
}

local file_exists = function(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

local read_file = function(path)
    local file = assert(io.open(path, "rb"))
    local content = file:read("*a")
    file:close()
    return content
end

local write_file = function(path, content)
    local file = assert(io.open(path, "w"))
    file:write(content)
    file:close()
end

local read_json = function(path)
    local content = read_file(path)
    local json = vim.json.decode(content)
    return json
end

vim.api.nvim_create_user_command("NvimEnvGenerate", function()
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
