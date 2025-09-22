{ overlays, ... }: {
  imports = [ ./zsh.nix ./rofi ./hyprpaper ./caelestia.nix ];

  nixpkgs = { inherit overlays; };

  programs = {
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
        windows = {
          scale = 8;
          items_per_row = 5;
          overview = {
            key = "";
            modifier = "super";
            filter_by = [ ];
            hide_filtered = false;
            launcher = {
              default_terminal = "ghostty";
              launch_modifier = "alt";
              width = 650;
              max_items = 5;
              show_when_empty = true;
              plugins.applications = {
                run_cache_weeks = 4;
                show_execs = true;
                show_actions_submenu = true;
              };
            };
          };
          switch = {
            modifier = "alt";
            filter_by = [ ];
            switch_workspaces = false;
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
