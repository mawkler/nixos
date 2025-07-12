{ pkgs, ... }: {
  programs.rofi = {
    enable = true;
    # Importing the theme like this allows modifying the theme without
    # reloading home-manager.
    #
    # TODO: rewrite as Nix and inject Stylix colors
    theme = { "@import" = "~/.config/nixos/home/rofi/rofi-theme"; };
    extraConfig = {
      # Keybindings
      kb-row-down = "Control+j,Down";
      kb-row-up = "Control+k,Up";
      kb-entry-history-up = "Control+n";
      kb-entry-history-down = "Control+p";
      kb-mode-next = "Alt+l";
      kb-mode-previous = "Alt+h";
      kb-accept-entry = "Return,Control+m";
      kb-remove-to-eol = ""; # Unset Control+k mapping
      kb-mode-complete = ""; # Unset Control+l mapping
    };
  };

  home.packages = with pkgs; [ rofi-power-menu ];
}
