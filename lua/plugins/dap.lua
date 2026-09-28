return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            local cmake = require("cmake-tools")

            dapui.setup()
            require("nvim-dap-virtual-text").setup({
                virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
                highlight_changed_variables = true,
                all_references = true,
                show_stop_reason = true,
            })

            local function lldb_init_commands()
                local commands = {}
                local sources = { vim.env.HOME .. "/.lldbinit", vim.fn.getcwd() .. "/.lldbinit" }

                for _, source in ipairs(sources) do
                    local file = io.open(source, "r")
                    if file then
                        table.insert(commands, "command source " .. source)
                        file:close()
                    end
                end

                return commands
            end

            -- LLDB (C/C++/Rust)
            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
                    args = { "--port", "${port}" },
                },
                name = "codelldb",
            }
            dap.adapters.lldb = dap.adapters.codelldb

            local cpp_config = {
                name = "Launch file",
                type = "codelldb",
                request = "launch",

                program = function()
                    local launch_target = cmake.get_launch_target_path()

                    if launch_target and launch_target ~= "" then
                        return launch_target
                    end

                    return vim.fn.input(
                        "Path: ",
                        vim.fn.getcwd() .. "/",
                        "file"
                    )
                end,

                cwd = "${workspaceFolder}",
                stopOnEntry = false,

                initCommands = lldb_init_commands,

                stopCommands = {
                    "select-useful-frame",
                },
            }

            dap.configurations.cpp = {
                cpp_config,
            }

            dap.configurations.c = dap.configurations.cpp
            dap.configurations.rust = dap.configurations.cpp

            dap.listeners.after.event_initialized.dapui_config = function()
                dapui.open()
            end

            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end

            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            -- keymaps under <leader>d
            vim.keymap.set("n", "<leader>dc", dap.continue)
            vim.keymap.set("n", "<leader>do", dap.step_over)
            vim.keymap.set("n", "<leader>di", dap.step_into)
            vim.keymap.set("n", "<leader>dO", dap.step_out)
            vim.keymap.set("n", "<leader>dr", dap.repl.open)
            vim.keymap.set("n", "<leader>dt", dap.terminate)

            vim.keymap.set("n", "<F5>", function()
                if dap.session() then
                    dap.continue()
                else
                    vim.cmd("CMakeDebug")
                end
            end)
            vim.keymap.set("n", "<S-F5>", function()
                dap.terminate()
            end)
        end,
    },
}
