{ pkgs, ... }:

let pkgConfig = { allowUnfree = true; };
in {
  imports = [ ./hyprland.nix ./kanata.nix ];

  nixpkgs.config = pkgConfig;

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Fonts
  fonts.packages = with pkgs; [ nerd-fonts.fira-code noto-fonts-emoji ];

  # Ollama
  services.ollama = {
    enable = true;
    loadModels = [ "deepseek-r1:1.5b" ];
  };

  # NixAI
  services.nixai = {
    enable = true;
    mcp.enable = true;
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
    # hurl
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
    networkmanager
    networkmanagerapplet
    nil
    nix-search-cli
    nixd
    nixfmt-classic
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
    beeper
    evil-helix
    unzip
    vifm
    vlc
    wget
    wl-clipboard-rs
    wlogout
    zathura
    zoxide
    zsh
    zsh-powerlevel10k
  ];
}
