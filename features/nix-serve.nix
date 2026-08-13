{ pkgs, hostnames, ... }:
{
  # Server
  services.nix-serve = {
    enable = true;
    openFirewall = true;
    package = pkgs.nix-serve-ng;
  };

  # Client
  services.avahi.enable = true; # So hosts can reach each other via `<hostname>.local`
  nix.settings.trusted-substituters = map (hostname: "http://${hostname}.local:5000") hostnames;
}
