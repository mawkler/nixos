{ pkgs, inputs, ... }: {
  programs.niri.enable = true;

  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  # This is an attempt at removing the "keyring did not get unlocked" prompt at
  # startup, but it doesn't seem to work as of 2025-12-27.
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  security.pam.services = {
    greetd.enableGnomeKeyring = true;
    greetd-password.enableGnomeKeyring = true;
    login.enableGnomeKeyring = true;
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    playerctl
    alacritty
    fuzzel

    xwayland-satellite
    inputs.raisin.defaultPackage.${stdenv.hostPlatform.system}
  ];
}
