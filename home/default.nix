{ overlays, inputs, ... }: {
  imports = [
    inputs.zen-browser.homeModules.beta
    ./ghostty.nix
    ./zsh.nix
    ./hyprpaper
    ./caelestia.nix
    ./vicinae.nix
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
  };

  # Default applications
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "org.gnome.Nautilus.desktop";
      "application/pdf" = "sioyek-4.desktop";
      "x-scheme-handler/http" = "brave-browser.desktop";
      "x-scheme-handler/https" = "brave-browser.desktop";
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
