{
  pkgs,
  inputs,
  rootPath,
  ...
}:
let
  flake = name: name.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  imports = [
    # keep-sorted start
    ./hyprland.nix
    ./kanata.nix
    ./opencode.nix
    ./stylix.nix
    ./tmux.nix
    inputs.neovim.nixosModules.default
    inputs.nix-index-database.nixosModules.nix-index
    # keep-sorted end
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

    kdeconnect.enable = true;

    steam.enable = true;
  };

  # Services
  services = {
    upower.enable = true; # Required by Caelestia

    power-profiles-daemon.enable = true;

    mullvad-vpn = {
      enable = true;
      gui.enable = true;
    };

    ollama = {
      enable = false;
      loadModels = [ "deepseek-r1:1.5b" ];
    };
  };

  # All other packages
  environment.systemPackages = with pkgs; [
    # keep-sorted start
    (flake inputs.nox)
    (flake inputs.ns-tui)
    antigen
    bacon
    bat
    beeper
    bitwarden-cli
    # bitwarden-desktop # depends electron-39.8.10 which is EOL
    btop
    # calibre
    cargo-nextest
    cargo-update
    cheese
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
    gram
    gum
    headsetcontrol
    home-manager
    htop-vim
    hurl
    hyperfine
    inputs.raisin.defaultPackage.${stdenv.hostPlatform.system} # TODO: export `.default`
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
    libnotify
    librepods
    localsend
    maestral
    maestral-gui
    manix
    mission-center
    nautilus
    networkmanager
    networkmanagerapplet
    nix-converter
    nix-inspect
    nix-search
    nodejs
    nps
    nurl
    onlyoffice-desktopeditors
    overskride
    plotinus
    popsicle
    python3
    quicktype
    ranger
    ripdrag
    ripgrep
    rumdl
    screenkey
    shutter
    signal-desktop
    sioyek
    slides
    spicetify-cli
    spotify
    spotube
    sshfs
    stable.anytype
    stable.grayjay
    stable.spacedrive # "broken: This package is broken"
    superfile
    sushi
    tailscale
    tokei
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

  environment.sessionVariables = {
    RUMDL_CACHE_DIR = "$HOME/.cache/rumdl";
  };
}
