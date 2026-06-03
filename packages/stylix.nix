{ pkgs, inputs, ... }:
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/onedark.yaml";
    polarity = "dark";

    targets.plymouth.enable = false;

    # workaround for build error after upgrading to NixOS 26.05
    # TODO: remove me when fixed
    targets.kmscon.enable = false;
  };
}
