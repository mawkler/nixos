{ pkgs, ... }: {
  services.onedrive.enable = true;

  environment.systemPackages = with pkgs; [
    # keep-sorted start
    aws-workspaces
    firefox
    slack
    teams-for-linux
    # keep-sorted end
  ];
}
