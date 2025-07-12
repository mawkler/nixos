{ inputs, ... }: {
  imports =
    [ ./zsh.nix ./rofi ./walker.nix inputs.walker.homeManagerModules.default ];

  home = rec {
    username = "melker";
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
  };
}
