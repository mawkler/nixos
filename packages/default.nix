{ pkgs, inputs, username, ... }: {
  imports = [
    # ./hyprland.nix
    ./niri.nix
    ./kanata.nix
    ./neovim.nix
    ./stylix.nix
    ./tmux.nix
    # ./nix-search-tv.nix
    inputs.nixai.nixosModules.default
    inputs.nix-index-database.nixosModules.nix-index
  ];

  nixpkgs.config.allowUnfree = true;

  # Fonts
  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.fira-code
    noto-fonts-color-emoji
  ];

  # Programs
  programs = {
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 10";
      flake = "/home/${username}/.config/nixos/";
    };

    nix-index-database.comma.enable = true;
  };

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
    cargo-nextest
    cargo-update
    clipboard-jh
    comma
    delta
    duf
    dust
    entr
    evil-helix
    eza
    fd
    file
    fprintd
    fx
    fzf
    gimp
    git
    git-standup
    github-cli
    gnumake
    go
    gum
    headsetcontrol
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
    kitty
    lazygit
    libnotify
    manix
    mission-center
    nautilus
    networkmanager
    networkmanagerapplet
    nix-converter
    nix-search
    nodejs
    nurl
    onlyoffice-desktopeditors
    overskride
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
    spicetify-cli
    spotify
    sshfs
    stable.maestral
    stable.maestral-gui
    stable.plotinus
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
