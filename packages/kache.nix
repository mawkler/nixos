{ inputs, ... }:
{
  imports = [ inputs.kache.nixosModules.default ];

  services.kache = {
    enable = true;
    daemon.enable = true;
  };
}
