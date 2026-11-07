# This computer doesn't run NixOS, and therefore only uses the home-manager config
{
  inputs,
  pkgs,
  rootPath,
  username,
  ...
}:
{
  imports = [
    ./sccache.nix
  ];

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
    entr
    eza
    fd
    fishPlugins.bass
    font-awesome
    fzf
    gimp
    github-cli
    glab
    herdr
    htop-vim
    kache
    jjui
    jless
    just
    keep-sorted
    libreoffice
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
    stable.luaPackages.xml2lua # 2026-10-15: the unstable version is marked as broken
    neovide
    neovim
    tree-sitter

    # Sandboxed (FHS) Nix apps like Beeper and OnlyOffice can't see Ubuntu's
    # /usr/share/fonts, so text fonts must come from the Nix profile
    noto-fonts
    ubuntu-sans
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
        Jr = "just run";
      };
      shellInitLast = "source ~/gitrepos/dfmain/tools/rust_tools/completions/completions.fish";
    };

    onlyoffice.enable = true;
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
}
