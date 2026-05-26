{ pkgs, ... }:
{
  hardware = {
    graphics.enable = true;
    nvidia = {
      open = false;
      nvidiaPersistenced = true;
      modesetting.enable = true;
      powerManagement.enable = true;
    };
  };

  nixpkgs.config = {
    cudaSupport = true;
    cudaCapability = [ "6.1" ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  environment.systemPackages = with pkgs; [ nvtopPackages.nvidia ];
}
