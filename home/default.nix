{
  pkgs,
  config,
  overlays,
  inputs,
  rootPath,
  ...
}:
let
  dotfileUtils = (import ./dotfiles { inherit pkgs config; });
  inherit (dotfileUtils) mkSymlinks;
  dotfiles = "${rootPath}/home/dotfiles";
in
{
  imports = [
    inputs.zen-browser.homeModules.beta
    ./shell/zsh.nix
    ./shell/fish
    ./shell/zoxide.nix
    ./ghostty.nix
    # ./hyprpaper
    # ./caelestia.nix
    ./dank-material-shell.nix
    ./vicinae.nix
  ];

  nixpkgs = { inherit overlays; };

  home = rec {
    username = "melker";
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";

    sessionVariables = {
      ZK_NOTEBOOK_DIR = "${homeDirectory}/Dropbox/Dokument/Markdowns/";
    };

    pointerCursor = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      gtk.enable = true;
    };
  };

  # Symlink every file in `./dotfiles/dot-config` to `~/.config/`
  xdg.configFile = mkSymlinks ./dotfiles/dot-config "${dotfiles}/dot-config";

  # Symlink every file in `./dotfiles/home/` to `~/`
  home.file = mkSymlinks ./dotfiles/home "${dotfiles}/home";

  # TODO: DankMaterialShell has this stuff built-in now?
  services.swayidle =
    let
      minutes = 60;
      suspend = "${pkgs.systemd}/bin/systemctl suspend";
      lock = "${pkgs.systemd}/bin/loginctl lock-session";
      display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
    in
    {
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
      events = {
        before-sleep = lock;
      };
    };

  programs = {
    # TODO: move to `shell.nix`
    atuin = {
      enable = true;
      flags = [ "--disable-up-arrow" ];
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

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

    mullvad-vpn = {
      enable = true;
      settings = {
        autoConnect = true;
        enableSystemNotifications = true;
        monochromaticIcon = true;
        startMinimized = true;
      };
    };

    jujutsu.enable = true;
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
      "application/pdf" = "sioyek.desktop";
      "x-scheme-handler/http" = "brave-browser.desktop";
      "x-scheme-handler/https" = "brave-browser.desktop";
    };
  };
}
