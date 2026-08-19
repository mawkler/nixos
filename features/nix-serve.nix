{ pkgs, hostnames, ... }:
{
  # Server
  services.nix-serve = {
    enable = true;
    openFirewall = true;
    package = pkgs.nix-serve-ng;
    secretKeyFile = "/var/secrets/nix-serve/secret.key";
  };

  # Client
  nix.settings = {
    trusted-substituters = map (hostname: "http://${hostname}.local:5000") hostnames;
    trusted-public-keys = [
      "cache.thinkpad-nixos.local-1:GOD9LtryYSo83u53HDM7YxYRmsnrltvSFsOUlaqsWjo="
    ];
  };

  # So hosts can reach each other via `<hostname>.local`
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
}
