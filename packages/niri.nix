{ pkgs, username, inputs, ... }: {
  programs.niri.enable = true;

  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    gnome.gnome-keyring.enable = true;
  };

  # Auto unlock wallet on login
  security.pam.services.${username}.kwallet.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl
    playerctl
    alacritty
    fuzzel

    xwayland-satellite
    inputs.raisin.defaultPackage.${system}
  ];
}
