{ ... }: {
  programs.quickshell = {
    enable = true;
    systemd.enable = true;
    systemd.target = "xdg-desktop-portal-hyprland.service";
  };
}
