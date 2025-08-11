{ overlays, ... }: {
  imports = [ ./zsh.nix ./rofi ./hyprpaper ./quickshell.nix ];

  nixpkgs = { inherit overlays; };

  programs = {
    waybar = {
      enable = true;
      systemd.enable = true;
      systemd.target = "xdg-desktop-portal-hyprland.service";
    };

    tealdeer = { enable = true; };
  };

  services = {
    # Notifications
    swaync = {
      enable = true;
      settings = { notification-window-width = 400; };
      style = # css
        ''
          .notification-row .text-box .body {
            font-size: 0.9rem;
          }
        '';
    };

    avizo.enable = true;

    # Clipboard history manager
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
