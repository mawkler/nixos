{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    opencode
    mcp-nixos
  ];
}
