local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local M = {}

M.setup = function()
end

-- our picker function: colors
local colors = function(opts)
    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "colors",
        finder = finders.new_table {
            results = { "red", "green", "blue" }
        },
        sorter = conf.generic_sorter(opts),
    }):find()
end

-- to execute the function
colors()

return M
