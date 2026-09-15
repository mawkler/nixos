# This computer doesn't run NixOS, and therefore only uses the home-manager config
{
  inputs,
  lib,
  pkgs,
  config,
  rootPath,
  username,
  ...
}:
{
  targets = {
    # Make home-manager work better on non-NixOS
    genericLinux.enable = true;
    genericLinux.gpu.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # keep-sorted start
    bacon
    bat
    beeper
    btop
    cargo-insta
    cargo-nextest
    chromedriver
    claude-code
    comma
    eza
    fd
    fishPlugins.bass
    font-awesome
    fzf
    gimp
    github-cli
    glab
    herdr
    htop
    jjui
    jless
    just
    keep-sorted
    librepods
    luarocks
    maestral
    maestral-gui
    nerd-fonts.fira-code
    nix-search
    nixd
    nodejs
    noto-fonts-color-emoji
    pnpm
    prettierd
    ripdrag
    ripgrep
    rumdl
    rustup
    sccache
    signal-desktop
    sioyek
    spotify
    tmux
    trash-cli
    wl-clipboard
    zed-editor
    # keep-sorted end

    # For Neovim
    luaPackages.mimetypes
    luaPackages.xml2lua
    neovide
    neovim
    tree-sitter
  ];

  programs = {
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 10";
      flake = rootPath;
    };
    fish = {
      shellAbbrs = {
        rt = "just run-tool";
      };
      shellInitLast = "source ~/gitrepos/dfmain/tools/rust_tools/completions/completions.fish";
    };
  };

  fonts.fontconfig.enable = true;

  # Makes Vim mode in scroll mode no longer work for some reason
  programs.tmux =
    let
      system = pkgs.stdenv.hostPlatform.system;
      minimal-status = inputs.minimal-tmux.packages.${system}.default;
    in
    with pkgs.tmuxPlugins;
    {
      enable = true;
      plugins = [
        better-mouse-mode
        yank
        jump
        minimal-status
      ];
      extraConfig = # tmux
        ''
          set -g @minimal-tmux-indicator-str ' tmux '
          set -g @jump-key 'z'
          set-option -g default-shell /home/melker/.nix-profile/bin/fish
          source-file ~/.tmux.conf
        '';
    };


  home.file =
    let
      inherit (config.lib.file) mkOutOfStoreSymlink;
      homeConfig = "${rootPath}/hosts/framework13-df/home";
    in
  {
    ".cargo/config.toml".source = lib.mkForce (mkOutOfStoreSymlink "${homeConfig}/.cargo/config.toml");
    ".config/sccache".source = # toml
    ''
      [cache.disk]
      dir = "/home/${username}/.cache/sccache"
      size = 53_687_091_200 # 54 GB
    '';
  };
}
