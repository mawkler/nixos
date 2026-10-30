{
  imports = [
    ./hardware-configuration.nix
    ./features/fingerprint-reader-synaptics.nix
  ];

  custom.swapGb = 16; # matches RAM, hibernates
}
