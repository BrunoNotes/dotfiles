local mason_folder = vim.fn.stdpath("data") .. "/mason"

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

            -- adapters --

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
                        local text = "Path to executable: "
                        local path = vim.fn.getcwd() .. "/target/debug/"
                        return vim.fn.input(text, path, "file")
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
                        local text = "Path to executable: "
                        local path = vim.fn.getcwd() .. "/zig-out/bin/"
                        return vim.fn.input(text, path, "file")
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

            -- dap.configurations.cs = {
            --     type = "godot",
            --     request = "launch",
            --     name = "Launch scene",
            --     project = "${workspaceFolder}",
            -- }

            -- dotnet
            dap.adapters.coreclr = {
                type = "executable",
                command = mason_folder .. "/bin/netcoredbg",
                args = { "--interpreter=vscode" }
            }

            dap.configurations.cs = {
                type = "coreclr",
                name = "launch - netcoredbg",
                request = "launch",
                program = function()
                    local text = "Path to executable: "
                    local path = vim.fn.getcwd() .. "/bin/Debug/"
                    return vim.fn.input(text, path, "file")
                end,
            }

            -- end adapters --

            local modes = require("utils").key_modes

            local keybindings = {
                { modes.normal, "<leader>db", dap.toggle_breakpoint, "DAP: Toggle breakpoint" },
                { modes.normal, "<leader>dc", dap.run_to_cursor, "DAP: Run to cursor" },
                { modes.normal, "<leader>dv", function()
                    ui.eval(nil, { enter = true })
                end, "DAP: Eval under cursor" },
                { modes.normal, "<F4>", dap.restart, "DAP: restart" },
                { modes.normal, "<F5>", dap.continue, "DAP: continue" },
                { modes.normal, "<F8>", dap.step_back, "DAP: step back" },
                { modes.normal, "<F9>", dap.step_out, "DAP: step out" },
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
