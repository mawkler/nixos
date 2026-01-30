{
  pkgs,
  config,
  overlays,
  rootPath,
  ...
}:
let
  dotfileUtils = (import ./dotfiles { inherit pkgs config; });
  inherit (dotfileUtils) mkSymlinks;
  dotfiles = "${rootPath}/home/dotfiles";
in
{
  imports = [
    ./other.nix
    ./shell/zsh.nix
    ./shell/fish
    ./shell/zoxide.nix
    ./ghostty.nix
    ./vicinae.nix
    ./jj.nix
  ];

  nixpkgs = { inherit overlays; };

  home = rec {
    username = "melker";
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";

    sessionVariables = {
      ZK_NOTEBOOK_DIR = "${homeDirectory}/Dropbox/Dokument/Markdowns/";
    };

    pointerCursor = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      gtk.enable = true;
    };
  };

  # Symlink every file in `./dotfiles/dot-config` to `~/.config/`
  xdg.configFile = mkSymlinks ./dotfiles/dot-config "${dotfiles}/dot-config";

  # Symlink every file in `./dotfiles/home/` to `~/`
  home.file = mkSymlinks ./dotfiles/home "${dotfiles}/home";

  # Default applications
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "org.gnome.Nautilus.desktop";
      "application/pdf" = "sioyek.desktop";
      "x-scheme-handler/http" = "brave-browser.desktop";
      "x-scheme-handler/https" = "brave-browser.desktop";
    };
  };
}
