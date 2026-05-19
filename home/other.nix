{ pkgs, inputs, ... }:
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs = {
    zen-browser.enable = true;

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
