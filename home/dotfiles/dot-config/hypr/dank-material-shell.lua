local cmd = hl.dsp.exec_cmd
local bind = hl.bind

require('dms.colors')
require('dms.layout')
require('dms.outputs')
require('dms.windowrules')

-- DMS IPC calls
bind("SUPER + COMMA", cmd("dms ipc call notifications toggle"))
bind("SUPER + SHIFT + COMMA", cmd("dms ipc call notifications dismissAllPopups"))
bind("CTRL + SHIFT + Escape", cmd("dms ipc call processlist toggle"))
bind("SUPER + CTRL + COMMA", cmd("dms ipc call settings focusOrToggle"))
bind("SUPER + BACKSPACE", cmd("dms ipc call powermenu toggle"))

-- playerctl doesn't play nice with KDE Connect/Valent but DMS's MPRIS controls do
bind("XF86AudioPause", cmd("dms ipc mpris playPause"), { locked = true })
bind("XF86AudioPlay", cmd("dms ipc mpris playPause"), { locked = true })
bind("XF86AudioNext", cmd("dms ipc mpris next"), { locked = true })
bind("XF86AudioPrev", cmd("dms ipc mpris previous"), { locked = true })

-- Audio volume
bind("XF86AudioRaiseVolume", cmd("dms ipc audio increment 5"), { locked = true, repeating = true })
bind("XF86AudioLowerVolume", cmd("dms ipc audio decrement 5"), { locked = true, repeating = true })
bind("XF86AudioMute", cmd("dms ipc audio mute"), { locked = true })
bind("XF86AudioMicMute", cmd("dms ipc audio micmute"), { locked = true })
