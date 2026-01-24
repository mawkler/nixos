# Launch tmux if it isn't already running
if not tmux list-sessions &>/dev/null
    exec tmux
end

# Theme
fish_config theme choose onedark

# Disable greeting when starting a new shell
set -g fish_greeting

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

# Functions

# Clear the current prompt's text, and restore it after running another command
function push-line
    set -g __fish_pushed_line (commandline)
    commandline ""
    # @fish-lsp-disable-next-line 4004
    function after-next-prompt --on-event fish_postexec
        commandline $__fish_pushed_line
        functions --erase after-next-prompt
    end
end
bind -M insert ctrl-q push-line
