return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "html", "css", "javascript", "jsdoc", "json" },
            highlight = { enable = true }
        }
    },

    { "windwp/nvim-ts-autotag",  opts = {} }, -- auto close/rename html tags

    { "mason-org/mason.nvim", opts = {} },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = { ensure_installed = { "html", "cssls", "ts_ls", "emmet_language_server", "eslint" } }
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            local caps = require("blink.cmp").get_lsp_capabilities()
            local lsp = require("lspconfig")
            lsp.html.setup { capabilities = caps }
            lsp.cssls.setup { capabilities = caps }
            lsp.emmet_language_server.setup { capabilities = caps,
                filetypes = { "html", "css", "javascript" } }
            lsp.eslint.setup { capabilities = caps }
            lsp.ts_ls.setup { capabilities = caps } -- this is what gives you JSDoc type inference
        end
    },

    -- autocomplete
    {
        "hrsh7th/nvim-cmp",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        config = function()
            local cmp = require("cmp")
            cmp.setup { mapping = cmp.mapping.preset.insert({
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping.select_next_item(),
            }), sources = { { name = "nvim_lsp" } } }
        end
    },
}
