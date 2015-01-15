--------------------------
-- Default luakit theme --
--------------------------

local theme = {}

-- Color definitions:

color_lwhite                  = "#ebdbb2"
color_dwhite                  = "#a89984"
color_lblack                  = "#504945"
color_dblack                  = "#282828"
color_dcyan                   = "#689d6a"
color_dgreen                  = "#98971a"
color_dred                    = "#cc241d"


-- Default settings
-- theme.font                    = "Droid Sans Mono 10" -- large
-- theme.font                    = "LM Mono Light Cond 10" -- quite narrow
-- theme.font                    = "LM Mono 10" -- quite narrow
theme.font                    = "inconsolata 10"
-- theme.font                    = "DejaVu Sans Mono Cond 10" -- large
-- theme.font                    = "DejaVu Sans Mono 10" -- large
theme.fg                      = color_lwhite
theme.bg                      = color_dblack

-- Genaral colours
theme.success_fg              = color_dgreen
theme.loaded_fg               = color_dcyan
theme.error_fg                = color_lwhite
theme.error_bg                = color_dblack

-- Warning colours
theme.warning_fg              = color_dred
theme.warning_bg              = color_dgreen

-- Notification colours
theme.notif_fg                = color_dcyan
theme.notif_bg                = color_lwhite

-- Menu colours
theme.menu_fg                 = color_lwhite
theme.menu_bg                 = color_dblack
theme.menu_selected_fg        = color_dblack
theme.menu_selected_bg        = color_lwhite
theme.menu_title_bg           = color_dblack
theme.menu_primary_title_fg   = color_dred
theme.menu_secondary_title_fg = color_dred

-- Proxy manager
theme.proxy_active_menu_fg    = color_dblack
theme.proxy_active_menu_bg    = color_lwhite
theme.proxy_inactive_menu_fg  = color_lblack
theme.proxy_inactive_menu_bg  = color_lwhite

-- Statusbar specific
theme.sbar_fg                 = color_lwhite
theme.sbar_bg                 = color_dblack

-- Downloadbar specific
theme.dbar_fg                 = color_dblack
theme.dbar_bg                 = color_lwhite
theme.dbar_error_fg           = color_dred

-- Input bar specific
theme.ibar_fg                 = color_dblack
theme.ibar_bg                 = color_lwhite

-- Tab label
theme.tab_fg                  = color_dwhite
theme.tab_bg                  = color_lblack
theme.tab_ntheme              = color_dwhite
theme.selected_fg             = color_lwhite
theme.selected_bg             = color_dblack
theme.selected_ntheme         = color_dwhite
theme.loading_fg              = color_dcyan
theme.loading_bg              = color_dblack

-- Trusted/untrusted ssl colours
theme.trust_fg                = color_dgreen
theme.notrust_fg              = color_dred

return theme
-- vim: et:sw=4:ts=8:sts=4:tw=80
