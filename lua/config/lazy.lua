local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "LazyVim/LazyVim",                                      import = "lazyvim.plugins" },

    -- VS Code-like extras
    { import = "lazyvim.plugins.extras.ui.mini-animate",      enabled = false },
    { import = "lazyvim.plugins.extras.ui.treesitter-context" },
    { import = "lazyvim.plugins.extras.editor.navic" },
    { import = "lazyvim.plugins.extras.dap.core" },
    { import = "lazyvim.plugins.extras.dap.nlua" },
    { import = "lazyvim.plugins.extras.lang.cmake" },
    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "lazyvim.plugins.extras.lang.clangd" },

    -- your custom plugins
    { import = "plugins.ui" },
    { import = "plugins.dap" },
    { import = "plugins.cmake" },
    { import = "plugins.leetcode" },
    { import = "plugins.keymaps" },
    { import = "plugins.lazygit" },
    { import = "plugins.symbols" },
    { import = "plugins.scrollbar" },
    { import = "plugins.web" },
    { import = "plugins.copilot" },
    {
        "folke/snacks.nvim",
        opts = {
            scroll = {
                enabled = false,
            },
        },
    },
    { "catppuccin/nvim",              name = "catppuccin" },
    { "folke/tokyonight.nvim" },
    { "rebelot/kanagawa.nvim" },
    { "EdenEast/nightfox.nvim" },
    { "rose-pine/neovim",             name = "rose-pine" },
    { "Mofiqul/vscode.nvim" },
    { "navarasu/onedark.nvim" },
    { "scottmckendry/cyberdream.nvim" },

}, {
    defaults = { lazy = true },
    install = { colorscheme = { "tokyonight" }
    },
})

vim.opt.termguicolors = true

vim.schedule(function()
    vim.cmd.colorscheme("tokyonight-night")
end)
