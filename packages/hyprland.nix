{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    # Properly activate `graphical-session.target` related services (e.g. DMS and Vicinae)
    withUWSM = true;
  };

  services.displayManager = {
    dux-greeter = {
      enable = true;
      compositor.name = "hyprland";
    };
    defaultSession = "hyprland-uwsm";
  };

  # Optional, hint electron apps to use wayland (from Hyprland's docs)
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    brightnessctl
    hyprshot
    playerctl
    hyprshutdown
  ];
}
