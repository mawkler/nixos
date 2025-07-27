{ pkgs, ... }: {
  programs = {
    hyprland.enable = true;
    hyprlock.enable = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    hyprpaper
    hyprshot
    playerctl
    waybar
    wofi
  ];
}
