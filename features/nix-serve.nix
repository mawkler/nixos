{
  inputs,
  pkgs,
  hostnames,
  ...
}:
{
  imports = [ inputs.nix-servant.nixosModules.default ];

  services = {
    nix-servant = {
      enable = true;
      hosts = hostnames;
    };

    nix-serve = {
      package = pkgs.nix-serve-ng;
      secretKeyFile = "/var/secrets/nix-serve/secret.key";
    };
  };

  nix.settings.trusted-public-keys = [
    "cache.thinkpad-nixos.local-1:GOD9LtryYSo83u53HDM7YxYRmsnrltvSFsOUlaqsWjo="
    "cache.beauty.local-1:FRLDLnUQ+Shu5AzUenJ93K1NryLDFKvwHUOHmUEbtD8="
  ];
}
