{ pkgs, ... }: {
  home = rec {
    username = "melker";
    homeDirectory = "/home/${username}";

    packages = [ pkgs.hello ];

    stateVersion = "25.05";
  };
}
