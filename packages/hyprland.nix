{ pkgs, username, inputs, ... }:
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
      # Copy DMS settings, session (wallpaper) and colors into the greeter on
      # each greetd start, i.e. the NixOS equivalent of `dms-greeter sync`
      configHome = "/home/${username}";
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
    # Loaded from `/run/current-system/sw/lib` in `hyprland.lua`
    (callPackage "${inputs.hyprexpo}/default.nix" { })
  ];
}
