{ pkgs, inputs, ... }:
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs = {
    zen-browser.enable = true;

    brave-origin = {
      enable = true;
      # TEMPORARY: from a pinned nixpkgs until nixos-unstable has brave-origin
      # again. Drop `package` once it does (see `nixpkgs-brave` in flake.nix)
      package =
        (import inputs.nixpkgs-brave {
          system = pkgs.stdenv.hostPlatform.system;
          config.allowUnfree = true;
        }).brave-origin;
      # Send proper notifications, don't just spawn a window with the notification
      nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];
    };

    mullvad-vpn = {
      enable = true;
      settings = {
        autoConnect = true;
        enableSystemNotifications = true;
        monochromaticIcon = true;
        startMinimized = true;
      };
    };
  };
}
