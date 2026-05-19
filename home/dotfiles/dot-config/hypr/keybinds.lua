local cmd = hl.dsp.exec_cmd
local bind = hl.bind

local repeat_locked = { locked = true, repeating = true }

local function bind_super(keys, call, options)
    bind(("%s + %s"):format("SUPER", keys), call, options)
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
raise_or_run("B", "beeper", "Beeper")
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
local vicinaeUrl = "vicinae://launch"

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
bind_super("grave", hl.dsp.focus({ last = true })) -- Backtick

-- Switch workspaces with SUPER + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    bind_super(key, hl.dsp.focus({ workspace = i }))
    bind_super("SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

bind_super("J", hl.dsp.focus({ workspace = 'e+1' }))
bind_super("K", hl.dsp.focus({ workspace = 'e-1' }))

-- Horizontal resizing
bind_super("R", hl.dsp.layout("colresize +conf"))
bind_super("SHIFT + R", hl.dsp.layout("colresize -conf"))
bind_super("equal", hl.dsp.layout("colresize +0.05"))
bind_super("minus", hl.dsp.layout("colresize -0.05"))

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

-- Laptop multimedia keys for LCD brightness
bind("XF86MonBrightnessUp", cmd("brightnessctl -e4 -n2 set 5%+"), repeat_locked)
bind("XF86MonBrightnessDown", cmd("brightnessctl -e4 -n2 set 5%-"), repeat_locked)

-- Handled by DankMaterialShell in `dank-material-shell.lua`
-- bind("XF86AudioRaiseVolume", cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), repeat_locked)
-- bind("XF86AudioLowerVolume", cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), repeat_locked)
-- bind("XF86AudioMute", cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), repeat_locked)
-- bind("XF86AudioMicMute", cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), repeat_locked)

local locked = { locked = true }

-- Lid switch
bind("switch:off:Lid Switch", cmd('hyprctl keyword monitor "eDP-1, enable"'), locked)
bind("switch:on:Lid Switch", cmd('hyprctl keyword monitor "eDP-1, disable"'), locked)
