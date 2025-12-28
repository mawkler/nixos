{ pkgs, inputs, username, rootPath, ... }: {
  imports = [
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
      flake = rootPath;
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
      enable = false;
      loadModels = [ "deepseek-r1:1.5b" ];
    };

    # nixai = {
    #   enable = true;
    #   mcp.enable = false;
    # };
  };

  # All other packages
  environment.systemPackages = with pkgs; [
    # keep-sorted start
    antigen
    bacon
    bat
    beeper
    bitwarden-cli
    calibre
    cargo-nextest
    cargo-update
    clipboard-jh
    comma
    delta
    discord
    duf
    dust
    entr
    evil-helix
    eza
    fd
    file
    fx
    fzf
    gimp
    git
    git-standup
    github-cli
    gnome-disk-utility
    gnumake
    go
    grayjay
    gum
    headsetcontrol
    home-manager
    htop-vim
    hurl
    hyperfine
    inputs.nox.packages.${stdenv.hostPlatform.system}.default
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
    localsend
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
    popsicle
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
    spacedrive
    spicetify-cli
    spotify
    sshfs
    stable.anytype # unstable version throws an error on startup
    stable.maestral
    stable.maestral-gui
    stable.plotinus
    steam
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
    zsh
    zsh-powerlevel10k
    # keep-sorted end
  ];
}
