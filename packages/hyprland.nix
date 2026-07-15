{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    # Properly activate `graphical-session.target` related services (e.g. DMS and Vicinae)
    withUWSM = true;
  };

  services.displayManager = {
    dms-greeter = {
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
  ];

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
}
