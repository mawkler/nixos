# This computer doesn't run NixOS, and therefore only uses the home-manager config
{ inputs, pkgs, config, rootPath, ... }: {
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
    cargo-insta
    cargo-nextest
    comma
    eza
    fd
    fishPlugins.bass
    font-awesome
    fzf
    gimp
    github-cli
    glab
    jjui
    jless
    just
    keep-sorted
    librepods
    luarocks
    neovide
    neovim
    nerd-fonts.fira-code
    nix-search
    nixd
    nodejs
    noto-fonts-color-emoji
    prettierd
    ripdrag
    ripgrep
    rumdl
    rustup
    signal-desktop
    sioyek
    spotify
    tmux
    trash-cli
    wl-clipboard
    # redisinsight
    # keep-sorted end
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

  # Makes Vim mode in scroll mode no longer work for some reason
  programs.tmux = let
    system = pkgs.stdenv.hostPlatform.system;
    minimal-status = inputs.minimal-tmux.packages.${system}.default;
  in with pkgs.tmuxPlugins; {
    enable = true;
    plugins = [ better-mouse-mode yank jump minimal-status ];
    extraConfig = # tmux
      ''
        set -g @minimal-tmux-indicator-str ' tmux '
        set -g @jump-key 'z'
        set-option -g default-shell /home/melker/.nix-profile/bin/fish
        source-file ~/.tmux.conf
      '';
  };
}
