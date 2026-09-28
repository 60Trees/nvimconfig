return {
    "oskarrrrrrr/symbols.nvim",

    keys = {
        { "<leader>ls", "<cmd>Symbols<CR>", desc = "Open Symbols" },
        { "<leader>lS", "<cmd>SymbolsClose<CR>", desc = "Close Symbols" },
    },

    config = function()
        local r = require("symbols.recipes")

        require("symbols").setup(
            r.DefaultFilters,
            r.AsciiSymbols,
            {
                sidebar = {
                    -- custom settings here
                },
            }
        )
    end,
}
