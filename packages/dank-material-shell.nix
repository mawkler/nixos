# There's no home-manager module because it has to run at system level
{ inputs, ... }: {
  imports = [ inputs.dank-material-shell.nixosModules.greeter ];

  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor.name = "niri";
  };
}
