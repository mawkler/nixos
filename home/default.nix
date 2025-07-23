{ pkgs, pkgs-unstable, system, inputs, ... }: {
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
      style = # css
        ''
          .notification-row .text-box .body {
            font-size: 0.9rem;
          }
        '';
      package = pkgs-unstable.swaynotificationcenter;
    };

    avizo = {
      enable = true;
      package = pkgs-unstable.avizo;
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
  home.packages = with pkgs; [
    cmake
    inputs.quickshell.packages.${system}.default
  ];
  home.sessionVariables.QT_QML_GENERATE_QMLLS_INI = "ON";
}
