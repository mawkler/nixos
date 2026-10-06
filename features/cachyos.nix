{ pkgs, inputs, ... }:
{
  # Also adds Chaotic-Nyx's binary cache. Must be rebuilt once before switching
  # the kernel over to Chaotic-Nyx's, so that the cache is active
  imports = [ inputs.chaotic.nixosModules.default ];

  boot.kernelPackages = pkgs.linuxPackages_cachyos;
}
