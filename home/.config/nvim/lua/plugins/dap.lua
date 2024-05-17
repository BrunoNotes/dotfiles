local function adapters(dap)
    local mason_folder = vim.fn.stdpath("data") .. "/mason"

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
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
            end,
            cwd = "${workspaceFolder}",
            stopAtBeginningOfMainSubprogram = false,
        },
    }

    -- dotnet
    dap.adapters.coreclr = {
        type = 'executable',
        command = mason_folder .. "/bin/netcoredbg",
        args = { '--interpreter=vscode' }
    }

    dap.configurations.cs = {
        {
            type = "coreclr",
            name = "launch - netcoredbg",
            request = "launch",
            program = function()
                return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
            end,
        },
    }

    -- godot
    dap.adapters.godot = {
        type = "server",
        host = '127.0.0.1',
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
            local nmap = require("utils").nmap
            local icons = require("utils").icons

            ui.setup()
            require("nvim-dap-virtual-text").setup({})

            adapters(dap)

            nmap("<leader>db", dap.toggle_breakpoint, { "Toggle breakpoint" })
            nmap("<leader>dc", dap.run_to_cursor, { "Run to cursor" })
            nmap("<leader>?", function()
                ui.eval(nil, { enter = true })
            end, { "Eval under cursor" })
            nmap("<F4>", dap.step_back, { "DAP step back" })
            nmap("<F5>", dap.continue, { "DAP continue" })
            nmap("<F6>", dap.step_into, { "DAP step into" })
            nmap("<F7>", dap.step_over, { "DAP step over" })
            nmap("<F8>", dap.step_out, { "DAP step out" })
            nmap("<F3>", dap.restart, { "DAP restart" })
            nmap("<leader>do", function()
                ui.open()
            end, { "Open DAP ui" })
            nmap("<leader>dx", function()
                ui.close()
            end, { "Close DAP ui" })

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
