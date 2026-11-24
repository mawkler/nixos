# The NixOS hosts use `features/nix-serve.nix` instead. Dining also needs the
# other hosts in `trusted-substituters` and their keys in
# `extra-trusted-public-keys` in /etc/nix/nix.conf
{ inputs, hostnames, ... }:
{
  imports = [ inputs.nix-servant.homeModules.default ];

  services.nix-servant = {
    enable = true;
    hosts = hostnames;
  };
}
