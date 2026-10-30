{
  imports = [ ./hardware-configuration.nix ];

  custom.swapGb = 8; # doesn't hibernate, just a zswap backing buffer
}
