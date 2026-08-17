{ pkgs, hostnames, ... }:
{
  # Server
  services.nix-serve = {
    enable = true;
    openFirewall = true;
    package = pkgs.nix-serve-ng;
  };

  # Client
  nix.settings.trusted-substituters = map (hostname: "http://${hostname}.local:5000") hostnames;
  # So hosts can reach each other via `<hostname>.local`
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
}
