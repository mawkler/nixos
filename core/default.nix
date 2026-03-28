# This was once a `configuration.nix`
{
  pkgs,
  overlays,
  hostname,
  ...
}:
{
  imports = [
    ./boot.nix
    ../hosts/${hostname}/hardware-configuration.nix
  ];

  # Overlays
  nixpkgs = { inherit overlays; };

  # Networking
  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  # Locale
  time.timeZone = "Europe/Stockholm";
  console.keyMap = "us";
  i18n =
    let
      swedish = "sv_SE.UTF-8";
    in
    {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = swedish;
        LC_IDENTIFICATION = swedish;
        LC_MEASUREMENT = swedish;
        LC_MONETARY = swedish;
        LC_NAME = swedish;
        LC_NUMERIC = swedish;
        LC_PAPER = swedish;
        LC_TELEPHONE = swedish;
        LC_TIME = swedish;
      };
    };

  # Printin
  services.printing.enable = true;

  # Sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Users
  users.users.melker = {
    isNormalUser = true;
    description = "Melker";
    extraGroups = [
      "networkmanager"
      "wheel"
      # Enable serial port access in the browser (i.e. CharaCorder connection)
      "dialout"
    ];
  };

  # Shell
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  programs.fish.enable = true;

  services.displayManager = {
    # Enable automatic login for the user.
    autoLogin.enable = true;
    autoLogin.user = "melker";
  };

  # To be able to see disks in file explorers
  services.gvfs.enable = true;

  # Nix
  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
    "pipe-operators"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
