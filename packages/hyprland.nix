{ pkgs, ... }: {
  programs = { hyprland.enable = true; };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  environment.systemPackages = with pkgs; [ brightnessctl hyprshot playerctl ];
}
