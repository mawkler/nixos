{ pkgs, inputs, ... }:
{
  imports = [
    inputs.dank-material-shell.homeModules.dank-material-shell
    inputs.dms-plugin-registry.modules.default
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = true;
    plugins = {
      dankKDEConnect.enable = true;
    };
  };

  home.packages = with pkgs; [
    polkit
    prettier # For formatting `settings.json`

    # For DankKDEConnect
    sshfs
  ];
}
