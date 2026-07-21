-- ----------------------------------------------------------------------------------------------
-- PLUGINS
-- https://wiki.hypr.land/Plugins/Using-Plugins/
-- ----------------------------------------------------------------------------------------------

-- ------------------------------------------------------------------------------------------
-- hypr-dynamic-cursors — "shake to find" cursor magnification (macOS/Fedora-style)
-- https://github.com/VirtCode/hypr-dynamic-cursors
--
-- Install once (not managed by this file):
--   hyprpm add https://github.com/virtcode/hypr-dynamic-cursors
--   hyprpm enable dynamic-cursors
--
-- hyprpm loads the plugin at runtime, so its config table (hl.plugin.dynamic_cursors) won't
-- exist until hyprpm has actually loaded it — hence the guard below. Per the plugin's own
-- docs: wrap all config for a plugin in `if hl.plugin.<name> then ... end` to avoid config
-- errors on any reload where the plugin isn't loaded yet (e.g. right after a fresh install
-- before the first `hyprpm reload`).
-- ------------------------------------------------------------------------------------------
if hl.plugin.dynamic_cursors then
    hl.config({
        plugin = {
            dynamic_cursors = {
                enabled = true,

                -- "none" disables tilt/rotate/stretch entirely — shake to find only,
                -- exactly like the macOS/Fedora behaviour you asked for
                mode = "none",

                shake = {
                    enabled = true,

                    -- lower = triggers on a gentler shake
                    threshold = 4.0,

                    -- magnification factor the instant a shake is detected
                    base = 1.0,
                    -- extra magnification per second while continuing to shake
                    speed = 2.0,
                    influence = 0.0,

                    -- 0 = no upper limit on magnification
                    limit = 0.0,

                    -- how long (ms) the cursor stays big after you stop shaking
                    timeout = 100,

                    -- keep false since mode = "none" already disables tilt/rotate effects;
                    -- this specifically controls whether those effects show *during* a shake
                    effects = false,
                },

                hyprcursor = {
                    enabled = true,
                    -- 1 = use nearest-neighbour scaling only when no high-res image exists
                    nearest = 1,
                },
            },
        },
    })
end

-- ------------------------------------------------------------------------------------------
-- Ensure hyprpm is allowed to load plugins without a permission popup each time.
-- Requires ecosystem.enforce_permissions to be enabled (commented out in settings.lua by
-- default) — safe to leave uncommented even if permissions enforcement is off.
-- ------------------------------------------------------------------------------------------
hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")
