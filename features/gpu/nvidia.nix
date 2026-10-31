{
  config,
  lib,
  pkgs,
  ...
}:
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

  systemd.services =
    let
      sleepServices = [
        "systemd-suspend.service"
        "systemd-hibernate.service"
      ];
      signalHyprland = signal: {
        wantedBy = sleepServices;
        serviceConfig = {
          Type = "oneshot";
          # `-` because `pkill` fails when Hyprland isn't running
          ExecStart = "-${pkgs.procps}/bin/pkill -${signal} -f '^Hyprland( |$)'";
        };
      };
    in
    {
      # With a kernel built by a cross stdenv (e.g. Chaotic-Nyx's LTO
      # `linuxPackages_cachyos`), the driver's `nvidia-sleep.sh` keeps its
      # `#!/bin/bash` shebang, which doesn't exist on NixOS, so every
      # suspend/hibernate aborts. Upstream won't fix it:
      # https://github.com/chaotic-cx/nyx/issues/1189
      nvidia-suspend.serviceConfig.ExecStart = lib.mkForce "${lib.getExe pkgs.bash} ${config.hardware.nvidia.package.out}/bin/nvidia-sleep.sh 'suspend'";
      nvidia-hibernate.serviceConfig.ExecStart = lib.mkForce "${lib.getExe pkgs.bash} ${config.hardware.nvidia.package.out}/bin/nvidia-sleep.sh 'hibernate'";
      nvidia-resume.serviceConfig.ExecStart = lib.mkForce "${lib.getExe pkgs.bash} ${config.hardware.nvidia.package.out}/bin/nvidia-sleep.sh 'resume'";

      # `nvidia-sleep.sh` switches to VT 63 on suspend and back on resume, and
      # Hyprland dies when its session is reactivated mid-resume. Freezing it
      # around the NVIDIA sleep hooks keeps it from seeing the VT switches.
      # https://github.com/MysticBytes786/hyprland-suspend-fix
      hyprland-suspend = signalHyprland "STOP" // {
        before = sleepServices ++ [
          "nvidia-suspend.service"
          "nvidia-hibernate.service"
        ];
      };
      hyprland-resume = signalHyprland "CONT" // {
        after = sleepServices ++ [ "nvidia-resume.service" ];
      };
    };

  services.xserver.videoDrivers = [ "nvidia" ];

  environment.systemPackages = with pkgs; [ nvtopPackages.nvidia ];
}
