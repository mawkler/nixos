{ inputs, ... }: {
  imports = [
    ./zsh.nix
    ./rofi
    ./walker.nix
    ./hyprpaper
    inputs.walker.homeManagerModules.default
  ];

  services = {
    # Notifications
    swaync = {
      enable = true;
      settings = { notification-window-width = 300; };
    };

    clipse = {
      enable = true;
      systemdTarget = "xdg-desktop-portal-hyprland.service";
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
}
