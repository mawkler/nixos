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

  # Make DMS's panels launchable from Vicinae, since DMS doesn't ship visible
  # desktop entries for them
  xdg.desktopEntries =
    let
      mkDmsEntry = name: ipc: {
        inherit name;
        exec = "dms ipc call ${ipc}";
        icon = "dev.duxlabs.shell";
      };
    in
    {
      # keep-sorted start
      dms-clipboard = mkDmsEntry "DMS Clipboard" "clipboard open";
      dms-control-center = mkDmsEntry "DMS Control Center" "control-center open";
      dms-keybinds = mkDmsEntry "DMS Keybinds" "keybinds open hyprland";
      dms-notepad = mkDmsEntry "DMS Notepad" "notepad open";
      dms-notifications = mkDmsEntry "DMS Notifications" "notifications open";
      dms-powermenu = mkDmsEntry "DMS Power Menu" "powermenu open";
      dms-processlist = mkDmsEntry "DMS System Monitor" "processlist open";
      dms-settings = mkDmsEntry "DMS Settings" "settings open";
      dms-wallpaper = mkDmsEntry "DMS Wallpaper" "dankdash wallpaper";
      # keep-sorted end
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
