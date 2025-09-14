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
