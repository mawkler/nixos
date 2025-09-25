{ pkgs, inputs, ... }: {
  imports = [
    ./hyprland.nix
    ./kanata.nix
    ./neovim.nix
    ./stylix.nix
    ./tmux.nix
    ./nix-search-tv.nix
    inputs.nixai.nixosModules.default
  ];

  nixpkgs.config.allowUnfree = true;

  # Fonts
  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.fira-code
    noto-fonts-emoji
  ];

  # Services
  services = {
    upower.enable = true; # Required by Caelestia

    power-profiles-daemon.enable = true;

    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn; # Includes the GUI
    };

    ollama = {
      enable = true;
      loadModels = [ "deepseek-r1:1.5b" ];
    };

    nixai = {
      enable = true;
      mcp.enable = false;
    };
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
    cargo-nextest
    cargo-update
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
    inputs.nox.packages.${system}.default
    jless
    jq
    kdePackages.dolphin
    kdePackages.filelight
    kdePackages.kate
    kdePackages.kcmutils
    kdePackages.kwallet-pam
    kdePackages.kwalletmanager
    kdePackages.qt5compat
    killall
    lazygit
    libnotify
    maestral
    maestral-gui
    manix
    mission-center
    netwdorkmanagerapplet
    networkmanager
    nix-output-monitor
    nix-search-cli
    nodejs
    nurl
    onlyoffice-bin
    overskride
    plotinus
    python3
    quicktype
    ranger
    ripdrag
    ripgrep
    rustup
    screenkey
    shutter
    signal-desktop
    sioyek
    slides
    smile
    spicetify-cli
    spotify
    sshfs
    sushi
    topgrade
    trash-cli
    tree
    typst
    unp
    unzip
    vifm
    vlc
    wget
    # wl-clipboard-rs
    wl-clipboard
    wlogout
    zathura
    zoxide
    zsh
    zsh-powerlevel10k
    # keep-sorted end
  ];
}
