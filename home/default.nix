{ overlays, inputs, ... }: {
  imports = [
    inputs.zen-browser.homeModules.beta
    ./zsh.nix
    ./rofi
    ./hyprpaper
    ./caelestia.nix
  ];

  nixpkgs = { inherit overlays; };

  programs = {
    zen-browser.enable = true;

    tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };

  services = {
    avizo.enable = true;
    hyprshell = {
      enable = true;
      settings = {
        version = 2;
        windows = {
          switch = {
            switch_workspaces = false;
            modifier = "alt";
          };
        };
      };
    };

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
