{ lib, config, ... }:
{
  options.custom.swapGb = lib.mkOption {
    type = lib.types.ints.positive;
    description = ''
      Size (in GiB) of the swap file backing zswap. Hosts that hibernate
      need this to be >= their RAM; others just need enough to catch
      whatever zswap's in-RAM pool (`maxPoolPercent`) overflows.
    '';
  };

  config = {
    boot.zswap = {
      enable = true;
      compressor = "zstd";
      maxPoolPercent = 20;
    };

    swapDevices = [
      {
        device = "/var/lib/swapfile";
        size = config.custom.swapGb * 1024;
      }
    ];
  };
}
