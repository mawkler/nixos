{ ... }: {
  imports = [ ./zsh.nix ];

  home = rec {
    username = "melker";
    homeDirectory = "/home/${username}";

    stateVersion = "25.05";
  };
}
