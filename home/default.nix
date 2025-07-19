{ pkgs-unstable, system, inputs, ... }: {
  imports = [
    ./zsh.nix
    ./rofi
    ./hyprpaper
    # ./walker.nix
    # inputs.walker.homeManagerModules.default
  ];

  services = {
    # Notifications
    swaync = {
      enable = true;
      settings = { notification-window-width = 300; };
    };

    # Clipboard history manager
    clipse = {
      enable = true;
      systemdTarget = "xdg-desktop-portal-hyprland.service";
      package = pkgs-unstable.clipse;
    };
  };

  home = rec {
    username = "melker";
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";

    sessionVariables = {
      ZK_NOTEBOOK_DIR = "${homeDirectory}/Dropbox/Dokument/Markdowns/";
    };
  };

  # Quickshell
  qt.enable = true;
  home.packages = [ inputs.quickshell.packages.${system}.default ];
}
