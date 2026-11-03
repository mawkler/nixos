{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    stable.opencode
    mcp-nixos
  ];
}
