{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    opencode
    mcp-nixos # 2026-10-27 build error
  ];
}
