{ inputs, ... }: {
  imports = [
    ./zsh.nix
    ./rofi
    ./walker.nix
    ./hyprpaper
    inputs.walker.homeManagerModules.default
  ];

  services.swaync = {
    enable = true;
    settings = { notification-window-width = 300; };
  };

  home = rec {
    username = "melker";
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";

    sessionVariables = {
      MARKDOWNS = "${homeDirectory}/Dropbox/Dokument/Markdowns/";
    };
  };
}
