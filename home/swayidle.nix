{ pkgs, ... }: {
  # TODO: DankMaterialShell has this stuff built-in now?
  services.swayidle =
    let
      minutes = 60;
      suspend = "${pkgs.systemd}/bin/systemctl suspend";
      lock = "${pkgs.systemd}/bin/loginctl lock-session";
      display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
    in
    {
      enable = true;
      timeouts = [
        {
          timeout = 10 * minutes;
          command = lock;
        }
        {
          timeout = 11 * minutes;
          command = display "off";
          resumeCommand = display "on";
        }
        {
          timeout = 25 * minutes;
          # Don't suspend if laptop charger is plugged in
          command = "systemd-ac-power || ${suspend}";
        }
      ];
      events = {
        before-sleep = lock;
      };
    };
}
