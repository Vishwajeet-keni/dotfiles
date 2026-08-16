-- ----------------------------------------------------------------------------------------------
-- PLUGINS
-- https://wiki.hypr.land/Plugins/Using-Plugins/
-- ----------------------------------------------------------------------------------------------

if hl.plugin.dynamic_cursors then
    hl.config({
        plugin = {
            dynamic_cursors = {
                enabled = true,
                mode = "none",
                shake = {
                    enabled = true,
                    threshold = 4.0,
                    base = 1.0,
                    speed = 2.0,
                    influence = 0.0,
                    limit = 0.0,
                    timeout = 100,
                    effects = false,
                },
                hyprcursor = {
                    enabled = true,
                    nearest = 1,
                },
            },
        },
    })
end

hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")
