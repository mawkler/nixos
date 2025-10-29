{ pkgs, username, ... }: {
  services.onedrive.enable = true;

  environment.systemPackages = with pkgs; [
    # keep-sorted start
    aws-workspaces
    firefox
    slack
    teams-for-linux
    # keep-sorted end
  ];

  # Docker
  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
  };
  users.users.${username}.extraGroups = [ "docker" ];
}
