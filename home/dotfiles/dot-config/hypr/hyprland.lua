-------------------
----  IMPORTS  ----
-------------------

require("keybinds")

require("dank-material-shell")

--------------------
----  MONITORS  ----
--------------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

local scaling = 1

hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080",
    position = "auto",
    scale    = scaling,
})

hl.monitor({
    output   = "HDMI-A-2",
    mode     = "1920x1080@120",
    position = "auto-left",
    scale    = "auto",
})

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("brave")
    hl.exec_cmd("neovide")
    hl.exec_cmd("ghostty")
    hl.exec_cmd("beeper")

    hl.exec_cmd("maestral_qt")
end)

---Always open program on the given workspace
---@param class string
---@param ws string
local function open_on_workspace(class, ws)
    hl.window_rule({ match = { class = class }, workspace = ws })
end

open_on_workspace("brave-browser", "1")
open_on_workspace("neovide", "2")
open_on_workspace("com.mitchellh.ghostty", "3")
open_on_workspace("Spotify", "4")
open_on_workspace("beepertexts", "5")

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("GDK_SCALE", tostring(scaling))
hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_SIZE", "20")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in           = 3,
        gaps_out          = 6,

        border_size       = 2,

        col               = {
            active_border = {
                colors = { "rgba(33ccffee)", "rgba(00ff99ee)" },
                angle = 45,
            },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border  = true,
        allow_tearing     = false,

        layout            = "scrolling",

        no_focus_fallback = true,
    },

    decoration = {
        rounding         = 18,
        rounding_power   = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow           = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        blur             = {
            enabled  = true,
            size     = 3,
            passes   = 3,
            vibrancy = 0.1696,
        },
    },
})

local function bezier_curve(name, c1, c2)
    hl.curve(name, { type = "bezier", points = { c1, c2 } })
end

local function animation(leaf, speed, bezier, style)
    local opts = { leaf = leaf, enabled = true, speed = speed, bezier = bezier }
    if style then opts.style = style end
    hl.animation(opts)
end

bezier_curve("easeOutQuint", { 0.23, 1 }, { 0.32, 1 })
bezier_curve("easeInOutCubic", { 0.65, 0.05 }, { 0.36, 1 })
bezier_curve("linear", { 0, 0 }, { 1, 1 })
bezier_curve("almostLinear", { 0.5, 0.5 }, { 0.75, 1.0 })
bezier_curve("quick", { 0.15, 0 }, { 0.1, 1 })

animation("global", 10, "default")
animation("border", 5.39, "easeOutQuint")
animation("windows", 2.5, "easeOutQuint")
animation("fadeIn", 1.73, "almostLinear")
animation("fadeOut", 1.46, "almostLinear")
animation("fade", 2, "quick")
animation("layers", 3.81, "easeOutQuint")
animation("layersIn", 4, "easeOutQuint", "fade")
animation("layersOut", 10.5, "linear", "fade")
animation("workspaces", 1, "easeOutQuint", "slidevert")

hl.config({
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
    scrolling = {
        explicit_column_widths = "0.5, 0.667, 0.333",
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
        focus_on_activate       = true,
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout                   = "se, se",
        kb_variant                  = "us,",
        kb_model                    = "",
        kb_options                  = "grp:win_space_toggle",
        kb_rules                    = "",

        follow_mouse                = 0,
        float_switch_override_focus = 0,

        sensitivity                 = 1,
        accel_profile               = "flat",

        touchpad                    = {
            natural_scroll = true,
            scroll_factor  = 0.3,
            drag_3fg       = 1,
        },
    },
})

hl.config({
    cursor = {
        inactive_timeout = 1,
    },
})

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- This rule doesn't seem to apply
hl.window_rule({
    name      = "vicinae-rounding",
    match     = { class = "vicinae" },
    animation = "gnomed",
})
hl.layer_rule({
    name  = "vicinae-blur",
    match = { namespace = "vicinae" },
    blur  = true,
})
