{
  pkgs,
  config,
  overlays,
  rootPath,
  inputs,
  ...
}:
let
  dotfileUtils = (import ./dotfiles { inherit pkgs config; });
  inherit (dotfileUtils) mkSymlinks;
  dotfiles = "${rootPath}/home/dotfiles";
in
{
  imports = [
    # keep-sorted start
    ./agent-skills.nix
    ./ghostty.nix
    ./jj.nix
    ./other.nix
    ./shell/fish
    ./shell/zoxide.nix
    ./shell/zsh.nix
    ./vicinae.nix
    # keep-sorted end
  ];

  nixpkgs = { inherit overlays; };

  home = rec {
    username = "melker";
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";

    pointerCursor = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      gtk.enable = true;
    };
  };

  # System variables
  systemd.user.sessionVariables = {
    # keep-sorted start
    HYPRLAND_LUA_STUBS = "${inputs.hyprland.packages.${pkgs.system}.hyprland}/share/hypr/stubs";
    UWSM_FINALIZE_VARNAMES = "ZK_NOTEBOOK_DIR";
    ZK_NOTEBOOK_DIR = "${config.home.homeDirectory}/Dropbox/Dokument/Markdowns/";
    # keep-sorted end
  };

  # Symlink every file in `./dotfiles/dot-config` to `~/.config/`
  xdg.configFile = mkSymlinks ./dotfiles/dot-config "${dotfiles}/dot-config";

  # Symlink every file in `./dotfiles/home/` to `~/`
  home.file = mkSymlinks ./dotfiles/home "${dotfiles}/home";

  # Minimal version of Neovim (fewer plugins, faster startup time)
  home.sessionVariables.EDITOR = "nvim --cmd 'lua vim.g.minimal_config = true'";

  # Default applications
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "org.gnome.Nautilus.desktop";
      "application/pdf" = "sioyek.desktop";
      "x-scheme-handler/http" = "brave-browser.desktop";
      "x-scheme-handler/https" = "brave-browser.desktop";
      "text/plain" = "neovide.desktop";
    };
  };
}
