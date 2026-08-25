{ pkgs, hostnames, ... }:
{
  # Server
  services = {
    nix-serve = {
      enable = true;
      openFirewall = true;
      package = pkgs.nix-serve-ng;
      secretKeyFile = "/var/secrets/nix-serve/secret.key";
    };

    # So hosts can reach each other via `<hostname>.local`
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
  };

  # Client
  nix.settings =
    let
      cacheUrls = map (hostname: "http://${hostname}.local:5000") hostnames;
    in
    {
      substituters = cacheUrls;
      trusted-substituters = cacheUrls;
      trusted-public-keys = [
        "cache.thinkpad-nixos.local-1:GOD9LtryYSo83u53HDM7YxYRmsnrltvSFsOUlaqsWjo="
        "cache.beauty.local-1:FRLDLnUQ+Shu5AzUenJ93K1NryLDFKvwHUOHmUEbtD8="
      ];
    };
}
