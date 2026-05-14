local cmd = hl.dsp.exec_cmd
local bind = hl.bind

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

-- Always open these programs on the corresponding workspace
hl.window_rule({ match = { class = "brave-browser" }, workspace = "1" })
hl.window_rule({ match = { class = "neovide" }, workspace = "2" })
hl.window_rule({ match = { class = "com.mitchellh.ghostty" }, workspace = "3" })
hl.window_rule({ match = { class = "Spotify" }, workspace = "4" })
hl.window_rule({ match = { class = "beepertexts" }, workspace = "5" })

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

---------------------
---- KEYBINDINGS ----
---------------------

local super = "SUPER"

local repeat_locked = { locked = true, repeating = true }

local function bind_super(keys, call, options)
    bind(("%s + %s"):format(super, keys), call, options)
end

local function raise_or_run(key, name, class)
    local command = cmd(
        ("~/.config/hypr/scripts/raise-or-run.sh %s %s"):format(name, class)
    )
    bind_super(key, command)
end

-- Raise-or-run app launchers
raise_or_run("E", "nautilus", "org.gnome.Nautilus")
raise_or_run("T", "ghostty", "com.mitchellh.ghostty")
raise_or_run("W", "brave", "brave-browser")
raise_or_run("B", "beeper", "beepertexts")
raise_or_run("N", "neovide", "neovide")
raise_or_run("S", "spotify", "Spotify")
raise_or_run("D", "onlyoffice-desktopeditors", "ONLYOFFICE")
raise_or_run("A", "teams-for-linux", "teams-for-linux")
raise_or_run("Z", "zen", "zen-beta")
raise_or_run("SHIFT + S", "slack", "slack")

-- Ctrl variants (always launch new instance)
bind_super("CTRL + E", cmd("nautilus"))
bind_super("CTRL + T", cmd("ghostty"))
bind_super("CTRL + W", cmd("brave"))
bind_super("CTRL + N", cmd("neovide"))

-- Vicinae (launcher)
local vicinaeUrl = "vicinae://extensions/vicinae"

bind("SUPER + SUPER_L", cmd("vicinae toggle"), { release = true })

bind_super("V", cmd("vicinae " .. vicinaeUrl .. "/clipboard/history"))
bind_super("period", cmd("vicinae " .. vicinaeUrl .. "/core/search-emojis"))
bind_super("I", cmd("ghostty --command=\"hyprctl clients && read\""))

-- Screenshots
bind("CTRL + PRINT", cmd("hyprshot --clipboard-only --mode active --mode output"))
bind("SHIFT + PRINT", cmd("hyprshot --clipboard-only --mode window"))
bind("PRINT", cmd("hyprshot --clipboard-only --mode region"))

-- Manage windows
bind_super("Q", hl.dsp.window.close())
bind_super("X", hl.dsp.window.float({ action = "toggle" }))
bind_super("SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
bind_super("F", hl.dsp.window.fullscreen({ mode = "maximized" }))

bind_super("SHIFT + L", hl.dsp.window.move({ direction = "r" }))
bind_super("SHIFT + K", hl.dsp.window.move({ direction = "u" }))
bind_super("SHIFT + J", hl.dsp.window.move({ direction = "d" }))
bind_super("SHIFT + H", hl.dsp.window.move({ direction = "l" }))

bind_super("ALT + L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), repeat_locked)
bind_super("ALT + H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), repeat_locked)
bind_super("ALT + K", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), repeat_locked)
bind_super("ALT + J", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), repeat_locked)

-- Move window focus
bind_super("H", hl.dsp.focus({ direction = "l" }))
bind_super("J", hl.dsp.focus({ direction = "d" }))
bind_super("K", hl.dsp.focus({ direction = "u" }))
bind_super("L", hl.dsp.focus({ direction = "r" }))
bind_super("code:49", hl.dsp.focus({ urgent_or_last = true })) -- Backtick

-- Switch workspaces with mainMod + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    bind_super(key, hl.dsp.focus({ workspace = i }))
    bind_super("SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Focus/move to other monitor
bind_super("CTRL + L", hl.dsp.focus({ monitor = "+1" }))
bind_super("CTRL + H", hl.dsp.focus({ monitor = "-1" }))
bind_super("CTRL + SHIFT + L", hl.dsp.window.move({ monitor = "+1" }))
bind_super("CTRL + SHIFT + H", hl.dsp.window.move({ monitor = "-1" }))

-- Scroll through existing workspaces with mainMod + scroll
bind_super("mouse_down", hl.dsp.focus({ workspace = "e+1" }))
bind_super("mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
bind_super("mouse:272", hl.dsp.window.drag(), { mouse = true })
bind_super("mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
bind("XF86AudioRaiseVolume", cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), repeat_locked)
bind("XF86AudioLowerVolume", cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), repeat_locked)
bind("XF86AudioMute", cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), repeat_locked)
bind("XF86AudioMicMute", cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), repeat_locked)

bind("XF86MonBrightnessUp", cmd("brightnessctl -e4 -n2 set 5%+"), repeat_locked)
bind("XF86MonBrightnessDown", cmd("brightnessctl -e4 -n2 set 5%-"), repeat_locked)

local locked = { locked = true }

-- Requires playerctl
bind("XF86AudioNext", cmd("playerctl next"), locked)
bind("XF86AudioPause", cmd("playerctl play-pause"), locked)
bind("XF86AudioPlay", cmd("playerctl play-pause"), locked)
bind("XF86AudioPrev", cmd("playerctl previous"), locked)

-- Lid switch
bind("switch:off:Lid Switch", cmd('hyprctl keyword monitor "eDP-1, enable"'), locked)
bind("switch:on:Lid Switch", cmd('hyprctl keyword monitor "eDP-1, disable"'), locked)


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
