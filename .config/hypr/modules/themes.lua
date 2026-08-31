local function get_wal_colors()
    local home = os.getenv("HOME")
    local f = io.open(home .. "/.cache/wal/colors", "r")
    if not f then return nil end
    local lines = {}
    for line in f:lines() do
        local hex = line:match("^%s*(#?%x%x%x%x%x%x)%s*$")
        if hex then table.insert(lines, hex) end
    end
    f:close()
    return lines
end

local wal = get_wal_colors()
-- fallback if wal not found
if not wal or #wal < 16 then
    wal = {
        "#1d1f21", "#cc6666", "#b5bd68", "#f0c674",
        "#81a2be", "#b294bb", "#8abeb7", "#c5c8c6",
        "#969896", "#cc6666", "#b5bd68", "#f0c674",
        "#81a2be", "#b294bb", "#8abeb7", "#ffffff"
    }
end

-- Helper to add alpha (two hex digits) to a hex color
local function hex_to_rgba(hex, alpha)
    alpha = alpha or "ff"
    return "rgba(" .. hex:gsub("^#", "") .. alpha .. ")"
end

-- Build the theme table that will be imported
local theme = {
    border1  = hex_to_rgba(wal[2], "ff"),   -- color1, solid
    border2  = hex_to_rgba(wal[3], "ff"),   -- color2, solid
    inactive = hex_to_rgba(wal[8], "aa"),   -- color7 with transparency
    shadow   = hex_to_rgba(wal[1], "ee"),   -- color0 (background) with transparency
    -- You can add more entries later if needed, e.g.:
    -- background = hex_to_rgba(wal[1], "ee"),
    -- foreground = hex_to_rgba(wal[15], "ff"),
    -- etc.
}

return theme