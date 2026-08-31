-- modules/settings.lua

local theme = require("modules/themes")   -- Load the Wal colours

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border  = { colors = { theme.border1, theme.border2 }, angle = 45 },
            inactive_border = theme.inactive,
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 8,
        rounding_power = 4,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 20,
            render_power = 3,
            color = theme.shadow,
        },
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },
})

-- layer_rule and window_rule remain unchanged
hl.layer_rule({ match = { namespace = "eww-control-panel" }, blur = true, ignore_alpha = 0.5 })

hl.window_rule({
    name  = "conky-clock-float",
    match = { class = "conky-clock" },
    float    = true,
    no_focus = true,
    pin      = true,
    no_anim  = true,
})