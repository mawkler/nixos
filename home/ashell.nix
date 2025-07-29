{ pkgs, ... }: {
  programs = {
    ashell = {
      enable = true;
      systemd.target = "xdg-desktop-portal-hyprland.service";
      systemd.enable = true;
    };
  };

  home.packages = with pkgs; [ upower bluez cliphist blueman ];
}
