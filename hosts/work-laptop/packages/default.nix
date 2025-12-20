{ pkgs, username, ... }: {
  services.onedrive.enable = true;

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
