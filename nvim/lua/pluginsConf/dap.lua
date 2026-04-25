require("dapui").setup()
require("nvim-dap-virtual-text").setup()

local dap = require("dap")
local ui = require("dapui")
local js_debug_path = vim.fn.expand("~/dap/js-debug/src/dapDebugServer.js")

if vim.fn.filereadable(js_debug_path) == 1 then
    dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
            command = "node",
            args = { js_debug_path, "${port}" },
        },
    }

    dap.configurations.javascript = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch debugger",
            program = "${file}",
            cwd = "${workspaceFolder}",
        },
    }

    dap.configurations.typescript = {
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach debugger",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
        },
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch test debugger",
            runtimeExecutable = "node",
            runtimeArgs = {
                "./node_modules/jest/bin/jest.js",
                "${file}",
                "--runInBand",
                "--no-cache",
            },
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
            outputCapture = "std",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
            resolveSourceMapLocations = {
                "${workspaceFolder}/**",
                "!**/node_modules/**",
            },
        },
    }
end
-- use: node --inspect=9229 dist/server.js
-- dap -> continue, select running process in picker, set BP.
-- Now listening for debug connections.

vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<space>gb", dap.run_to_cursor)
vim.keymap.set("n", "<space>?", function()
    ui.eval(nil, { enter = true })
end)
vim.keymap.set("n", "<space>dc", dap.continue)
vim.keymap.set("n", "<space>dsi", dap.step_into)
vim.keymap.set("n", "<space>ds", dap.step_over)
vim.keymap.set("n", "<space>dso", dap.step_out)
vim.keymap.set("n", "<space>dsb", dap.step_back)
vim.keymap.set("n", "<space>dr", dap.restart)

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
