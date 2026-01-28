# This computer doesn't run NixOS, and therefore only uses the home-manager config
{ pkgs, config, rootPath, ... }: {
  targets = {
    # Make home-manager work better on non-NixOS
    genericLinux.enable = true;
    genericLinux.gpu.enable = true;
  };

  home.packages = with pkgs; [
    font-awesome
    nerd-fonts.fira-code
    noto-fonts-color-emoji
    nixd
    neovide
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 10";
      flake = rootPath;
    };
  };

  fonts.fontconfig.enable = true;
}
