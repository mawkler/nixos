{ pkgs, inputs, ... }: {
  imports =
    [ ./hyprland.nix ./kanata.nix ./neovim.nix ./stylix.nix ./tmux.nix ];

  nixpkgs.config.allowUnfree = true;

  # Mullvad VPN
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
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
    mcp.enable = false;
  };

  # All other packages
  environment.systemPackages = with pkgs; [
    # keep-sorted start
    antigen
    anytype
    atuin
    bacon
    bat
    beeper
    bitwarden-cli
    brave
    clipboard-jh
    delta
    duf
    dust
    evil-helix
    eza
    fd
    fprintd
    fx
    fzf
    ghostty
    gimp
    git
    git-standup
    github-cli
    gnumake
    go
    home-manager
    htop-vim
    hurl
    hyperfine
    inputs.hyprshell.packages.x86_64-linux.hyprshell
    jless
    jq
    kdePackages.dolphin
    kdePackages.filelight
    kdePackages.kate
    kdePackages.kwallet-pam
    lazygit
    maestral
    maestral-gui
    mission-center
    networkmanager
    networkmanagerapplet
    nix-output-monitor
    nix-search-cli
    nodejs
    nurl
    plotinus
    python3
    quicktype
    ranger
    ripdrag
    ripgrep
    rustup
    screenkey
    shutter
    sioyek
    slides
    spicetify-cli
    spotify
    sshfs
    sushi
    tealdeer
    topgrade
    trash-cli
    tree
    typst
    unp
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
    # keep-sorted end
  ];
}
