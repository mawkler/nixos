{ inputs, ... }:
{
  imports = [ inputs.jaunt.nixosModules.default ];

  services.jaunt.enable = true;
}
