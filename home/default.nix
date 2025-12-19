{ overlays, inputs, pkgs, ... }: {
  imports = [
    inputs.zen-browser.homeModules.beta
    ./ghostty.nix
    ./zsh.nix
    ./hyprpaper
    # ./caelestia.nix
    ./dank-material-shell.nix
    ./vicinae.nix
  ];

  nixpkgs = { inherit overlays; };

  services.swayidle = let
    minutes = 60;
    suspend = "${pkgs.systemd}/bin/systemctl suspend";
    lock = "${pkgs.systemd}/bin/loginctl lock-session";
    display = status:
      "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
  in {
    enable = true;
    timeouts = [
      {
        timeout = 10 * minutes;
        command = lock;
      }
      {
        timeout = 11 * minutes;
        command = display "off";
        resumeCommand = display "on";
      }
      {
        timeout = 25 * minutes;
        # Don't suspend if laptop charger is plugged in
        command = "systemd-ac-power || ${suspend}";
      }
    ];
    events = { before-sleep = lock; };
  };

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

    brave = {
      enable = true;
      # Send proper notifications, don't just spawn a window with the notification
      nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];
    };
  };

  services = {
    avizo.enable = true;
    hyprshell = {
      # Disabled because I'm not on hyprland
      enable = false;
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
