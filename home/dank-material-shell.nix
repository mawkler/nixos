{ pkgs, inputs, ... }: {
  imports = [ inputs.dankMaterialShell.homeModules.dankMaterialShell.default ];

  programs.dankMaterialShell = {
    enable = true;
    systemd.enable = true;
  };

  home.packages = with pkgs; [ polkit ];
}
