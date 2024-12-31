local env = require("nvim_env")

local dap_executable = function(exec_text, exec_path)
    local nvim_env = env.get_env()

    if nvim_env ~= nil then
        if nvim_env.dap_executable_path == "" then
            local input = vim.fn.input(exec_text, exec_path, "file")
            nvim_env.dap_executable_path = input
            env.write_json_env(nvim_env)
            return input
        else
            return nvim_env.dap_executable_path
        end
    else
        local input = vim.fn.input(exec_text, exec_path, "file")
        return input
    end
end

local function adapters(dap)
    local mason_folder = vim.fn.stdpath("data") .. "/mason"
    local nvim_env = env.get_env()

    -- GDB
    dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" }
    }

    dap.configurations.rust = {
        {
            name = "Launch",
            type = "gdb",
            request = "launch",
            program = function()
                return dap_executable("Path to executable: ", vim.fn.getcwd() .. "/target/debug/")
            end,
            cwd = "${workspaceFolder}",
            stopAtBeginningOfMainSubprogram = false,
        },
    }

    dap.configurations.zig = {
        {
            name = "Launch",
            type = "gdb",
            request = "launch",
            program = function()
                return dap_executable("Path to executable: ", vim.fn.getcwd() .. "/zig-out/bin/")
            end,
            cwd = "${workspaceFolder}",
            stopAtBeginningOfMainSubprogram = false,
        },
    }

    -- godot
    dap.adapters.godot = {
        type = "server",
        host = "127.0.0.1",
        port = 6006, -- Editor -> Editor Settings -> Network -> Debug Adapter
    }

    dap.configurations.gdscript = {
        {
            type = "godot",
            request = "launch",
            name = "Launch scene",
            project = "${workspaceFolder}",
        }
    }

    -- dotnet
    dap.adapters.coreclr = {
        type = "executable",
        command = mason_folder .. "/bin/netcoredbg",
        args = { "--interpreter=vscode" }
    }

    local cs_coreclr = {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            return dap_executable("Path to dll", vim.fn.getcwd() .. "/bin/Debug/")
        end,
    }

    local cs_godot = {
        type = "godot",
        request = "launch",
        name = "Launch scene",
        project = "${workspaceFolder}",
    }

    if nvim_env ~= nil then
        if nvim_env.dap_type == "godot" then
            dap.configurations.cs = {
                cs_godot,
            }
        else
            dap.configurations.cs = {
                cs_coreclr,
            }
        end
    else
        dap.configurations.cs = {
            cs_coreclr,
        }
    end
end

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
        },
        config = function()
            local dap = require("dap")
            local ui = require("dapui")
            local icons = require("utils").icons

            ---@diagnostic disable-next-line: missing-fields
            ui.setup({
                layouts = { {
                    elements = {
                        {
                            id = "console",
                            size = 0.25
                        },
                        {
                            id = "scopes",
                            size = 0.25
                        },
                        {
                            id = "breakpoints",
                            size = 0.25
                        },
                        {
                            id = "stacks",
                            size = 0.25
                        },
                    },
                    position = "right",
                    size = 40
                }, {
                    elements = {
                        {
                            id = "repl",
                            size = 0.5
                        },
                        {
                            id = "watches",
                            size = 0.5
                        },
                    },
                    position = "bottom",
                    size = 10
                } },
            })
            require("nvim-dap-virtual-text").setup({})

            adapters(dap)

            local modes = require("utils").key_modes

            local keybindings = {
                { modes.normal, "<leader>db", dap.toggle_breakpoint, "DAP: Toggle breakpoint" },
                { modes.normal, "<leader>dc", dap.run_to_cursor,     "DAP: Run to cursor" },
                { modes.normal, "<leader>dv", function()
                    ui.eval(nil, { enter = true })
                end, "DAP: Eval under cursor" },
                { modes.normal, "<F4>",  dap.restart,   "DAP: restart" },
                { modes.normal, "<F5>",  dap.continue,  "DAP: continue" },
                { modes.normal, "<F8>",  dap.step_back, "DAP: step back" },
                { modes.normal, "<F9>",  dap.step_out,  "DAP: step out" },
                { modes.normal, "<F10>", dap.step_over, "DAP: step over" },
                { modes.normal, "<F11>", dap.step_into, "DAP step into" },
                { modes.normal, "<leader>do", function()
                    ui.open()
                end, "DAP: Open ui" },
                { modes.normal, "<leader>dx", function()
                    ui.close()
                end, "DAP: Close ui" },
            }

            for _, key in ipairs(keybindings) do
                vim.keymap.set(key[1], key[2], key[3], { silent = true, desc = key[4] })
            end

            vim.fn.sign_define("DapBreakpoint", {
                text = icons.Circle,
                texthl = "DiagnosticSignError",
                linehl = "",
                numhl = "",
            })

            vim.fn.sign_define("DapBreakpointCondition", {
                text = "C",
                texthl = "DiagnosticSignWarn",
                linehl = "",
                numhl = "",
            })

            vim.fn.sign_define("DapLogPoint", {
                text = "L",
                texthl = "DiagnosticSignWarn",
                linehl = "",
                numhl = "",
            })

            vim.fn.sign_define("DapStopped", {
                text = icons.BoldArrowRight,
                texthl = "DiagnosticSignWarn",
                linehl = "Visual",
                numhl = "DiagnosticSignWarn",
            })

            vim.fn.sign_define("DapBreakpointRejected", {
                text = icons.error,
                texthl = "DiagnosticSignError",
                linehl = "",
                numhl = "",
            })

            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                ui.close()
            end
        end,
    },
}
