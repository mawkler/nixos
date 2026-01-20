{ pkgs, ... }:
{
  boot = {
    # Silence the log outputs to make the boot process more aesthetically clean
    consoleLogLevel = 3;
    initrd.verbose = false;
    initrd.systemd.enable = true;
    kernelParams = [
      "quiet"
      "splash"
      "intremap=on"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    # Hide the OS choice for bootloaders. It's still possible to open the
    # bootloader list by pressing `Esc`.
    loader.timeout = 0;

    # Plymouth theme
    plymouth = rec {
      theme = "circle_hud";
      enable = true;
      font = "${pkgs.hack-font}/share/fonts/truetype/Hack-Regular.ttf";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          # https://github.com/adi1090x/plymouth-themes
          selected_themes = [ theme ];
        })
      ];
    };
  };
}
