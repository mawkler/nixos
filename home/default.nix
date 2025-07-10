{ inputs, ... }: {
  imports = [
    ./zsh.nix
    ./walker.nix
    ./rofi.nix
    inputs.walker.homeManagerModules.default
  ];

  home = rec {
    username = "melker";
    homeDirectory = "/home/${username}";

    stateVersion = "25.05";
  };
}
