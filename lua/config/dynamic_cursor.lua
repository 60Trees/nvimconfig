local M = {}

-- Minimum contrast difference before disabling
-- Increase if you want stricter filtering.
local MIN_CONTRAST = 40

local function hex_to_rgb(hex)
    hex = hex:gsub("#", "")
    return {
        r = tonumber(hex:sub(1, 2), 16),
        g = tonumber(hex:sub(3, 4), 16),
        b = tonumber(hex:sub(5, 6), 16),
    }
end

local function brightness(rgb)
    return (rgb.r * 299 + rgb.g * 587 + rgb.b * 114) / 1000
end

local function contrast(c1, c2)
    return math.abs(brightness(hex_to_rgb(c1)) - brightness(hex_to_rgb(c2)))
end






local function get_syn_hl()
    local pos = vim.api.nvim_win_get_cursor(0)
    local row = pos[1] - 1
    local col = pos[2]

    -- 1. LSP semantic tokens (MOST accurate)
    for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
        if client.server_capabilities.semanticTokensProvider then
            local tokens = vim.lsp.semantic_tokens.get_at_pos(0, row, col)
            if tokens and tokens.type then
                local hl = vim.api.nvim_get_hl(0, {
                    name = "@" .. tokens.type,
                    link = false,
                })
                if hl and (hl.fg or hl.foreground) then
                    return hl
                end
            end
        end
    end

    -- 2. Treesitter (true parsed color)
    local node = vim.treesitter.get_node({ pos = { row, col } })
    if node then
        local captures = vim.treesitter.get_captures_at_pos(0, row, col)
        for i = #captures, 1, -1 do
            local hl = vim.api.nvim_get_hl(0, {
                name = "@" .. captures[i].capture,
                link = false,
            })
            if hl and (hl.fg or hl.foreground) then
                return hl
            end
        end
    end

    -- 3. fallback: syntax
    local syn_id = vim.fn.synID(row + 1, col + 1, 1)
    local trans = vim.fn.synIDtrans(syn_id)
    local name = vim.fn.synIDattr(trans, "name")

    if name ~= "" then
        local hl = vim.api.nvim_get_hl(0, {
            name = name,
            link = false,
        })
        if hl and (hl.fg or hl.foreground) then
            return hl
        end
    end

    return nil
end




function M.update_cursor()
    local mode = vim.fn.mode()

    local enabled_modes = {
        n = true,
        v = true,
        V = true,
        ["\22"] = true, -- CTRL-V block visual
        r = true,
    }

    if not enabled_modes[mode] then
        vim.api.nvim_set_hl(0, "Cursor", {})
        return
    end

    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    local syn = get_syn_hl()

    if not syn or not syn.fg or not normal.bg then
        vim.api.nvim_set_hl(0, "Cursor", {})
        return
    end
    if not syn then return end

    local fg = string.format("#%06x", syn.fg)
    local bg = string.format("#%06x", normal.bg)

    ---- Disable when contrast is too low
    --if contrast(fg, bg) < MIN_CONTRAST then
    --    vim.api.nvim_set_hl(0, "Cursor", {})
    --    return
    --end

    -- Cursor block = token colour
    -- Text inside cursor = background colour
    if mode == "r" or mode == "R" then
        vim.api.nvim_set_hl(0, "ReplaceCursor", {
            bg = fg,
            fg = syn.fg,
        })
    else
        vim.api.nvim_set_hl(0, "Cursor", {
            fg = bg,
            bg = fg,
        })
    end
end

vim.api.nvim_create_autocmd({
    "CursorMoved",
    "ModeChanged",
    "ColorScheme",
}, {
    callback = function()
        vim.cmd("redraw")
        vim.schedule(M.update_cursor)
    end,
})

vim.api.nvim_set_hl(0, "CursorReplace", {})

vim.opt.guicursor = table.concat({
    "n-v:block-Cursor",
    "i-ci-ve:ver25",
    "r:hor50-CursorReplace",
    "o:hor50",
}, ",")

return M
