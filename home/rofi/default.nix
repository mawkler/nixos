{ ... }: {
  programs.rofi = {
    enable = true;
    # Importing the theme like this allows modifying the theme without
    # reloading home-manager.
    #
    # TODO: rewrite as Nix and inject Stylix colors
    theme = { "@import" = "~/.config/nixos/home/rofi/rofi-theme"; };
  };
}
