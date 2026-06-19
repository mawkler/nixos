local cmd = hl.dsp.exec_cmd
local bind = hl.bind

local repeat_locked = { locked = true, repeating = true }

local function bind_super(keys, call, options)
    bind(("%s + %s"):format("SUPER", keys), call, options)
end

-- Ctrl variants (always launch new instance)
bind_super("CTRL + E", cmd("nautilus"))
bind_super("CTRL + T", cmd("ghostty"))
bind_super("CTRL + W", cmd("brave"))
bind_super("CTRL + N", cmd("neovide"))

-- Vicinae (launcher)
local vicinaeUrl = "vicinae://launch"

local function vicinae(path)
    return cmd("vicinae " .. vicinaeUrl .. path)
end

bind("SUPER + SUPER_L", cmd("vicinae toggle"), { release = true })

bind_super("V", vicinae("/clipboard/history"))
bind_super("period", vicinae("/core/search-emojis"))

-- Screenshots
bind("CTRL + PRINT", cmd("hyprshot --clipboard-only --mode active --mode output"))
bind("SHIFT + PRINT", cmd("hyprshot --clipboard-only --mode window"))
bind("PRINT", cmd("hyprshot --clipboard-only --mode region"))

-- Manage windows
bind_super("Q", hl.dsp.window.close())
bind_super("X", hl.dsp.window.float({ action = "toggle" }))
bind_super("SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
-- bind_super("F", hl.dsp.window.fullscreen({ mode = "maximized" }))
-- temporary workaround for issue where DMS's top bar disappears when maximizing (should be resolved in v. 0.55.1)
local scroll_max_state = {}
bind_super("F", function()
    local ws = hl.get_active_workspace()
    if not ws then return end
    local was_max = scroll_max_state[ws.id]
    hl.dispatch(hl.dsp.layout(was_max and "colresize 0.5" or "colresize 1"))
    scroll_max_state[ws.id] = not was_max
end)

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
bind_super("SHIFT + J", hl.dsp.window.move({ workspace = "+1" }))
bind_super("SHIFT + K", hl.dsp.window.move({ workspace = "-1" }))
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
