{ inputs, ... }:
{
  imports = [ inputs.dux-files.homeModules.dux-files ];

  programs.dux-files = {
    enable = true;
    # Keep the daemon running so that `dfiles` opens a window instantly
    systemd.enable = true;
  };
}
