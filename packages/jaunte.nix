{ inputs, ... }:
{
  imports = [ inputs.jaunte.nixosModules.default ];

  services.jaunte.enable = true;
}
