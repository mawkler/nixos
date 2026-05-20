{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Because GTX 980 is too old
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_580;

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/mapper/luks-19c39624-bab4-4c25-a084-3c0065a8005a";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-19c39624-bab4-4c25-a084-3c0065a8005a".device =
    "/dev/disk/by-uuid/19c39624-bab4-4c25-a084-3c0065a8005a";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/E733-6A09";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
