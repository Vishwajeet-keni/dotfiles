-- ----------------------------------------------------------------------------------------------
-- Animations
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
-- ----------------------------------------------------------------------------------------------

-- NOTE: your old config had "enabled = yes, please :" which was a leftover/typo (that trailing
-- text did nothing). Cleaned up to a plain boolean below.
hl.config({ animations = { enabled = true } })

-- Default curves, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/#curves
--         NAME              X0     Y0     X1    Y1
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1} } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1} } })

-- Default animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.animation({ leaf = "global",     enabled = true, speed = 6,   bezier = "default" })
hl.animation({ leaf = "windows",    enabled = true, speed = 3,   bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",  enabled = true, speed = 3,   bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.5, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fade",       enabled = true, speed = 2,   bezier = "quick" })
hl.animation({ leaf = "layers",     enabled = true, speed = 2.5, bezier = "easeOutQuint" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2,   bezier = "almostLinear", style = "fade" })

-- Extra leaves that exist in 0.55+ but weren't in your old config — uncomment any you want:
-- hl.animation({ leaf = "border",         enabled = true, speed = 5,   bezier = "easeOutQuint" })
-- hl.animation({ leaf = "fadeIn",         enabled = true, speed = 1.7, bezier = "almostLinear" })
-- hl.animation({ leaf = "fadeOut",        enabled = true, speed = 1.5, bezier = "almostLinear" })
-- hl.animation({ leaf = "layersIn",       enabled = true, speed = 4,   bezier = "easeOutQuint", style = "fade" })
-- hl.animation({ leaf = "layersOut",      enabled = true, speed = 1.5, bezier = "linear",       style = "fade" })
-- hl.animation({ leaf = "workspacesIn",   enabled = true, speed = 1.2, bezier = "almostLinear", style = "fade" })
-- hl.animation({ leaf = "workspacesOut",  enabled = true, speed = 1.9, bezier = "almostLinear", style = "fade" })
-- hl.animation({ leaf = "zoomFactor",     enabled = true, speed = 7,   bezier = "quick" })
