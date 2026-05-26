{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore;

  nix.settings = {
    substituters = [
      "https://cache.garnix.io"
      "https://attic.xuyh0120.win/lantian"
    ];
    trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    ];
  };
}
