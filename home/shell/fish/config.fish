# Launch tmux if it isn't already running
if not tmux list-sessions &> /dev/null
  exec tmux
end

# Theme
fish_config theme choose onedark

# Disable greeting when starting a new shell
set -U fish_greeting

# Enable Vi mode
set -g fish_key_bindings fish_vi_key_bindings

# Keybindings
bind -M insert ctrl-p up-or-search
bind -M insert ctrl-n down-or-search
bind -M insert ctrl-f forward-char
bind -M insert alt-backspace backward-kill-path-component
bind -M insert alt-shift-p fish_clipboard_paste
bind -M insert alt-L 'commandline "ls -a"' execute
bind -M insert alt-z zi repaint
