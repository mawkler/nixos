{ overlays, ... }: {
  imports = [ ./zsh.nix ./rofi ./hyprpaper ./quickshell.nix ./caelestia.nix ];

  nixpkgs = { inherit overlays; };

  programs = { tealdeer = { enable = true; }; };

  services = {
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
