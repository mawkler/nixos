{ pkgs, inputs, ... }:
{
  imports = [
    inputs.dank-material-shell.homeModules.dank-material-shell
    inputs.dms-plugin-registry.homeModules.default
  ];
  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
    enableCalendarEvents = false; # khal fails to build 2026-10-23
    plugins = {
      dankKDEConnect.enable = true;
      systemMonitor.enable = true;
    };
  };

  home.sessionVariables = {
    # Required by KDE applications under a non-Plasma compositor
    XDG_MENU_PREFIX = "plasma-";
  };

  home.packages = with pkgs; [
    # keep-sorted start
    accountsservice # For persisint user profile picture
    polkit
    prettier # For formatting `settings.json`
    sshfs # For DankKDEConnect
    # keep-sorted end
  ];
}
