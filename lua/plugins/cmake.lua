return {
    {
        "Civitasv/cmake-tools.nvim",
        opts = {
            cmake_use_preset = true,
            cmake_regenerate_on_save = true,
            cmake_show_disabled_build_presets = true,
            cmake_build_directory = function()
                return "out/${variant:buildType}"
            end,
            cmake_compile_commands_options = {
                action = "soft_link",
                target = vim.loop.cwd,
            },
            cmake_dap_configuration = {
                name = "CMake Debug",
                type = "codelldb",
                request = "launch",
                stopOnEntry = false,
                runInTerminal = true,
                console = "integratedTerminal",
                expressions = "native"
            },
        },
    },
}
