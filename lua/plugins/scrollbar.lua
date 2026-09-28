return {
    "petertriho/nvim-scrollbar",
    dependencies = {
        "lewis6991/gitsigns.nvim",
        "kevinhwang91/nvim-hlslens",
    },
    config = function()
        require("scrollbar").setup({
            show = true,
            show_in_active_only = false,
            set_highlights = true,
            folds = 1000,
            max_lines = false,
        })

        require("scrollbar.handlers.gitsigns").setup()
        require("scrollbar.handlers.search").setup()
        require("scrollbar.handlers.diagnostic").setup()
    end,
}
