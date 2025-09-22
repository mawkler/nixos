{ inputs, pkgs, ... }: {
  imports = [ inputs.caelestia.homeManagerModules.default ];

  programs.caelestia = {
    enable = true;
    systemd = {
      enable = true;
      target = "xdg-desktop-portal-hyprland.service";
    };
    settings = {
      # paths.wallpaperDir = "~/Images";
      appearance = {
        anim = { durations = { scale = 0.7; }; };
        padding = { scale = 0.5; };
        transparency = {
          enabled = true;
          base = 0.6;
          layers = 0.4;
        };
      };
      general = {
        apps = {
          terminal = [ "ghostty" ];
          audio = [ "pavucontrol" ];
        };
      };
      background = { desktopClock = { enabled = true; }; };
      bar = {
        sizes = { innerWidth = 32; };
        status = {
          showAudio = true;
          showMicrophone = true;
        };
        tray = { recolour = false; };
        workspaces = {
          activeLabel = "";
          label = "";
          occupiedLabel = "";
          shown = 5;
        };
      };
      border = { thickness = 1; };
      dashboard = { dragThreshold = 10; };
      launcher = {
        vimKeybinds = true;
        enableDangerousActions = true;
        maxShown = 10;
      };
      notifs = {
        actionOnClick = true;
        defaultExpireTimeout = 3000;
      };
      osd = { hideDelay = 1000; };
      session = {
        vimKeybinds = true;
        commands = {
          logout = [ "loginctl" "terminate-user" "" ];
          shutdown = [ "systemctl" "poweroff" ];
          hibernate = [ "systemctl" "hibernate" ];
          reboot = [ "systemctl" "reboot" ];
        };
      };
    };

    cli = { enable = true; };
  };

  home.packages = with pkgs; [
    # Not sure if all these dependencies are necessary or not
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    hyprpicker
    hypridle
    wl-clipboard
    cliphist
    bluez
    bluez-tools
    inotify-tools
    app2unit
    wireplumber
    trash-cli
    foot
    fish
    fastfetch
    starship
    btop
    jq
    socat
    imagemagick
    curl
    adw-gtk3
    papirus-icon-theme
    kdePackages.qt6ct
    libsForQt5.qt5ct
    nerd-fonts.jetbrains-mono
  ];
}
