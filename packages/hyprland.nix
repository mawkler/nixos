{ pkgs, inputs, ... }:
{
  programs.hyprland =
    let
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;

      # TODO: remove these two lines once the flake is removed in favour of nixpkgs
      package = package.hyprland;
      portalPackage = package.xdg-desktop-portal-hyprland;
    };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

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
