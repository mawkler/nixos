{ pkgs, inputs, ... }:
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs = {
    # TODO: move to `shell.nix`
    atuin = {
      enable = true;
      flags = [ "--disable-up-arrow" ];
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    zen-browser = {
      enable = true;
      # 2026-02-23: since update 18.18.6b:
      # https://github.com/0xc000022070/zen-browser-flake?tab=readme-ov-file#missing-configuration-after-update
      suppressXdgMigrationWarning = true;
    };

    tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    brave = {
      enable = true;
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
