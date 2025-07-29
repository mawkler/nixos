{ pkgs, inputs, overlays, ... }: {
  imports = [
    ./zsh.nix
    ./rofi
    ./hyprpaper
    ./ashell.nix
    # ./walker.nix
    # inputs.walker.homeManagerModules.default
  ];

  nixpkgs = { inherit overlays; };

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

  # Quickshell
  qt.enable = true;
  home.packages = with pkgs; [
    cmake
    inputs.quickshell.packages.${pkgs.system}.default
  ];
  home.sessionVariables.QT_QML_GENERATE_QMLLS_INI = "ON";
}
