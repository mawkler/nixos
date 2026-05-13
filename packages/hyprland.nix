{ pkgs, inputs, ... }:
{
  imports = [ inputs.dank-material-shell.nixosModules.greeter ];

  programs.hyprland =
    let
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;
      # Properly activate `graphical-session.target` related services (e.g. DMS and Vicinae)
      withUWSM = true;

      # TODO: remove these two lines once the flake is removed in favour of nixpkgs
      package = package.hyprland;
      portalPackage = package.xdg-desktop-portal-hyprland;
    };

  # Display manager
  programs.dank-material-shell.greeter = {
    enable = true;
    compositor.name = "hyprland";
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
