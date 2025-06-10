{ pkgs, ... }:

let
  pkgConfig = { allowUnfree = true; }; # Allow unfree packages
  unstable = import <nixos-unstable> { config = pkgConfig; };
in {
  nixpkgs.config = pkgConfig;

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = unstable.neovim-unwrapped;
  };

  # All other packages
  environment.systemPackages = with pkgs; [
    antigen
    atuin
    bacon
    bat
    bitwarden-cli
    brave
    clipboard-jh
    delta
    duf
    dust
    eza
    fd
    fprintd
    fx
    fzf
    gcc
    ghostty
    gimp
    git
    git-standup
    github-cli
    gnumake
    go
    htop-vim
    hurl
    hyperfine
    jless
    jq
    kdePackages.kate
    languagetool
    lazygit
    luajit
    luarocks
    mdsf
    mission-center
    neovide
    nerd-fonts.fira-code
    nix-search-cli
    nixd
    nodejs
    plotinus
    python3
    quicktype
    ranger
    ripdrag
    ripgrep
    rustup
    screenkey
    shfmt
    shutter
    sioyek
    slides
    spicetify-cli
    spotify
    sshfs
    sushi
    tealdeer
    tmux
    topgrade
    trash-cli
    tree
    typst
    unp
    unstable.beeper
    unstable.evil-helix
    unzip
    vifm
    vlc
    wget
    wl-clipboard-rs
    zathura
    zoxide
    zsh
    zsh-powerlevel10k
  ];
}
