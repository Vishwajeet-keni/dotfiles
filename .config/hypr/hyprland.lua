--  _   _                  _                 _
-- | | | |_   _ _ __  _ __| | __ _ _ __   __| |
-- | |_| | | | | '_ \| '__| |/ _` | '_ \ / _` |
-- |  _  | |_| | |_) | |  | | (_| | | | | (_| |
-- |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_|
--        |___/|_|
-- ==============================================================================================
-- Hyprland 0.55+ Lua config (converted from your hyprland.conf)
-- Entry point — everything else is require()'d in from modules/
-- See https://wiki.hypr.land/Configuring/Start/
-- ==============================================================================================

-- ----------------------------------------------------------------------------------------------
-- Monitor Setup
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- ----------------------------------------------------------------------------------------------
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })
hl.monitor({ output = "HDMI-A-1", mode = "3840x2160@70", position = "0x0", scale = 1 })

-- ----------------------------------------------------------------------------------------------
-- My Programs
-- NOTE: declared as globals (no "local") on purpose, so modules/binds.lua — which is its own
-- require()'d scope — can still see terminal / fileManager / menu / mainMod.
-- ----------------------------------------------------------------------------------------------
terminal    = "kitty"
fileManager = "dolphin"
menu        = "~/.config/rofi/launchers/type-6/launcher.sh" -- wofi --show drun
mainMod     = "SUPER" -- Sets "Windows" key as main modifier

-- ----------------------------------------------------------------------------------------------
-- Auto Start
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
--   old "exec-once" -> runs once, so it goes inside hl.on("hyprland.start", ...)
--   old "exec"      -> used to re-run on every config reload too, so it stays a top-level
--                      hl.exec_cmd() call outside the hyprland.start handler
-- ----------------------------------------------------------------------------------------------
hl.exec_cmd("wl-paste -t text --watch clipman store --no-persist")

hl.on("hyprland.start", function()
    hl.exec_cmd("hypridle")
    hl.exec_cmd("udiskie &")
    hl.exec_cmd("eww daemon; eww open hypr_bar")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("swww-daemon")

    -- eDP-1
    hl.exec_cmd("sleep 1 && swww img ~/wallpapers/static/w1.jpg --output eDP-1")

    -- HDMI-A-1
    hl.exec_cmd("sleep 1 && swww img ~/wallpapers/static/w1.jpg --output HDMI-A-1")
end)

-- ----------------------------------------------------------------------------------------------
-- Environment Variables
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
-- (If you use uwsm, Arch's wiki now recommends putting these in ~/.config/uwsm/env-hyprland
-- instead of here — totally optional, your old setup didn't use uwsm so this is fine as-is.)
-- ----------------------------------------------------------------------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- ----------------------------------------------------------------------------------------------
-- Permissions
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- ----------------------------------------------------------------------------------------------
-- hl.config({ ecosystem = { enforce_permissions = true } })
-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-- ----------------------------------------------------------------------------------------------
-- Split config — each require() is its own error-isolated Lua scope, so a mistake in one
-- file (e.g. binds.lua) won't stop the others from loading.
-- ----------------------------------------------------------------------------------------------
require("modules/settings")
require("modules/animations")
require("modules/input")
require("modules/binds")
