{ pkgs, ... }: {
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl
    hyprpaper
    playerctl
    waybar
    wofi
  ];
}
