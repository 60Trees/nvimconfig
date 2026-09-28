return {
  -- dashboard (VS Code start page vibe)
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      return {
        theme = "hyper",
      }
    end,
  },

  -- scrollbar
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end,
  },

  -- command palette + UI (VERY VSCode-like)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      presets = {
        command_palette = true,
        long_message_to_split = true,
      },
    },
  },

  -- better input/select UI
  {
    "stevearc/dressing.nvim",
    opts = {},
  },

  -- breadcrumbs (top path bar)
  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    opts = {},
  },

  -- which-key (the “press key → show controls” thing)
  {
    "folke/which-key.nvim",
    opts = {},
  },

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- color scheme picker UI
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require("telescope.actions")
      opts.defaults = opts.defaults or {}
      return opts
    end,
  },
}
