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


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "ghostty"
local fileManager = "nautilus"
local browser     = "brave"
local editor      = "neovide"


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function ()
    hl.dispatch(hl.dsp.exec_cmd(browser,    { workspace = "1", silent = true }))
    hl.dispatch(hl.dsp.exec_cmd(editor,     { workspace = "2", silent = true }))
    hl.dispatch(hl.dsp.exec_cmd(terminal,   { workspace = "3", silent = true }))
    hl.dispatch(hl.dsp.exec_cmd("beeper",   { workspace = "4", silent = true }))
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hyprshell run")
    hl.exec_cmd("maestral_qt")
    hl.exec_cmd("mullvad-gui")
end)


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
        gaps_in  = 3,
        gaps_out = 6,

        border_size = 2,

        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = true,
        allow_tearing    = false,

        layout = "master",

        no_focus_fallback = true,
    },

    decoration = {
        rounding       = 18,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 3,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1.0}  } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 2.5,  bezier = "easeOutQuint" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 2,    bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 10.5, bezier = "linear",       style = "fade" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1,    bezier = "easeOutQuint", style = "slidevert" })

hl.config({
    dwindle = {
        preserve_split = true,
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})

hl.config({
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
        kb_layout  = "se, se",
        kb_variant = "us,",
        kb_model   = "",
        kb_options = "grp:win_space_toggle",
        kb_rules   = "",

        follow_mouse                = 0,
        float_switch_override_focus = 0,

        sensitivity  = 1,
        accel_profile = "flat",

        touchpad = {
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

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Raise-or-run app launchers
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("~/.config/hypr/scripts/raise-or-run.sh nautilus org.gnome.Nautilus"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("~/.config/hypr/scripts/raise-or-run.sh ghostty com.mitchellh.ghostty"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/raise-or-run.sh brave brave-browser"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("~/.config/hypr/scripts/raise-or-run.sh beeper Beeper"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("~/.config/hypr/scripts/raise-or-run.sh neovide neovide"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("~/.config/hypr/scripts/raise-or-run.sh spotify Spotify"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("~/.config/hypr/scripts/raise-or-run.sh onlyoffice-desktopeditors ONLYOFFICE"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("~/.config/hypr/scripts/raise-or-run.sh teams-for-linux teams-for-linux"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("~/.config/hypr/scripts/raise-or-run.sh zen zen-beta"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("~/.config/hypr/scripts/raise-or-run.sh slack slack"))

-- Ctrl variants (always launch new instance)
hl.bind(mainMod .. " + CTRL + E", hl.dsp.exec_cmd("nautilus"))
hl.bind(mainMod .. " + CTRL + T", hl.dsp.exec_cmd("ghostty"))
hl.bind(mainMod .. " + CTRL + W", hl.dsp.exec_cmd("brave"))
hl.bind(mainMod .. " + CTRL + N", hl.dsp.exec_cmd("neovide"))

-- Vicinae (launcher)
local vicinaeUrl = "vicinae://extensions/vicinae"

hl.bind("SUPER + SUPER_L", hl.dsp.exec_cmd("vicinae toggle"), { release = true })

hl.bind(mainMod .. " + V",     hl.dsp.exec_cmd("vicinae " .. vicinaeUrl .. "/clipboard/history"))
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("vicinae " .. vicinaeUrl .. "/core/search-emojis"))
hl.bind(mainMod .. " + I",     hl.dsp.exec_cmd("ghostty --command=\"hyprctl clients && read\""))

-- Screenshots
hl.bind("CTRL + PRINT", hl.dsp.exec_cmd("hyprshot --clipboard-only --mode active --mode output"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot --clipboard-only --mode window"))
hl.bind("PRINT",          hl.dsp.exec_cmd("hyprshot --clipboard-only --mode region"))

-- Manage windows
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + X", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))

hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))

hl.bind(mainMod .. " + ALT + L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }),  { locked = true, repeating = true })
hl.bind(mainMod .. " + ALT + H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { locked = true, repeating = true })
hl.bind(mainMod .. " + ALT + K", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { locked = true, repeating = true })
hl.bind(mainMod .. " + ALT + J", hl.dsp.window.resize({ x = 0, y = 20, relative = true }),  { locked = true, repeating = true })

-- Move window focus
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + code:49", hl.dsp.focus({ urgent_or_last = true })) -- Backtick

-- Switch workspaces with mainMod + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Focus/move to other monitor
hl.bind(mainMod .. " + CTRL + L",        hl.dsp.focus({ monitor = "+1" }))
hl.bind(mainMod .. " + CTRL + H",        hl.dsp.focus({ monitor = "-1" }))
hl.bind(mainMod .. " + CTRL + SHIFT + L", hl.dsp.window.move({ monitor = "+1" }))
hl.bind(mainMod .. " + CTRL + SHIFT + H", hl.dsp.window.move({ monitor = "-1" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })

hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Lid switch
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd('hyprctl keyword monitor "eDP-1, enable"'),  { locked = true })
hl.bind("switch:on:Lid Switch",  hl.dsp.exec_cmd('hyprctl keyword monitor "eDP-1, disable"'), { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- This rule doesn't seem to apply
hl.window_rule({
    name     = "vicinae-rounding",
    match    = { class = "vicinae" },
    animation      = "gnomed",
})
hl.layer_rule({
    name       = "vicinae-blur",
    match      = { namespace = "vicinae" },
    blur       = true,
})

