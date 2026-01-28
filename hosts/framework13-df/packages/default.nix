{ pkgs, username, ... }: {
  # https://community.frame.work/t/rdseed32-is-broken-disabling-the-corresponding-cpuid-bit/77830/12
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.fprintd.enable = true;

  environment.systemPackages = with pkgs;
    [
      # keep-sorted start
      slack
      # keep-sorted end
    ];

  # Docker
  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
  };
  users.users.${username}.extraGroups = [ "docker" ];
}
