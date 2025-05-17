{ pkgs, ... }:

let
  unstable = import <nixos-unstable> { config.allowUnfree = true; };
in
{
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
    unstable.beeper
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
    mission-center
    neovide
    nix-search-cli
    nodejs
    plotinus
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
    vifm
    vlc
    wget
    wl-clipboard-rs
    zathura
    zoxide
    zsh
    zsh-powerlevel10k
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
