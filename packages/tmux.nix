{ pkgs, inputs, config, ... }: {
  programs.tmux =
    let minimal-status = inputs.minimal-tmux.packages.${pkgs.system}.default;
    in with pkgs.tmuxPlugins; {
      enable = true;
      plugins = [ better-mouse-mode yank jump minimal-status ];
      extraConfigBeforePlugins = # tmux
        ''
          # These have to be set before minimal-tmux-status loads
          set -g @minimal-tmux-bg '#${config.lib.stylix.colors.base0B}'
          set -g @minimal-tmux-indicator-str ' tmux '
          set -g @jump-key 'z'
        '';
    };
}
