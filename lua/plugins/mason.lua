return {
    {
        "mason-org/mason.nvim",
        opts = {},
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "mason-org/mason.nvim", "mfussenegger/nvim-dap" },
        opts = {
            ensure_installed = { "codelldb", "wgsl" },
            automatic_installation = true,
	    highlight = { enable = true },
        },
    },
}
