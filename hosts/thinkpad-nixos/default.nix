{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  custom.swapGb = 16; # matches RAM, hibernates

  # VA-API driver for the Intel iGPU, which Mesa doesn't provide. Needed for
  # hardware video encoding/decoding, e.g. by the DMS Cast plugin's mirroring
  hardware.graphics.extraPackages = [ pkgs.intel-media-driver ];
}
