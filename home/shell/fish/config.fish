# Launch tmux if it isn't already running
if not tmux list-sessions &> /dev/null
  exec tmux
end

# Enable Vi mode
set -g fish_key_bindings fish_vi_key_bindings

# Keybindings
bind -M insert ctrl-p 'up-or-search'
bind -M insert ctrl-n 'down-or-search'
bind -M insert ctrl-f 'forward-char'
