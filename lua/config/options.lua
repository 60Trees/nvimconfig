local tab_size = 4

vim.opt.expandtab = true         -- Use spaces instead of tabs
vim.opt.tabstop = tab_size       -- Number of visual spaces per <Tab>
vim.opt.shiftwidth = tab_size    -- Number of spaces for auto-indent operations
vim.opt.softtabstop = tab_size   -- Number of spaces inserted when <Tab> is pressed
vim.opt.smoothscroll = false

if vim.g.neovide then
    vim.o.guifont = "0xProto Nerd Font"
    vim.g.neovide_opacity = 1
    vim.g.neovide_scroll_animation = 0
    vim.g.neovide_hide_mouse_when_typing = true
end
