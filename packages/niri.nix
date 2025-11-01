{ pkgs, ... }: {
  programs.niri.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    playerctl
    alacritty
    fuzzel

    xwayland-satellite
  ];
}
