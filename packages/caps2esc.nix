{ pkgs, ... }:
{
  boot.kernelModules = [ "uinput" ];

  # Map `CapsLock` to `Esc` when tapped and `Ctrl` when held down.
  services.interception-tools = {
    enable = true;
    plugins = [ pkgs.interception-tools-plugins.caps2esc ];
    udevmonConfig = /* yaml */ ''
      # `-m 1`: only remap CapsLock (the default mode also turns Esc into CapsLock)
      - JOB: "intercept -g $DEVNODE | caps2esc -m 1 | uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_CAPSLOCK]
    '';
  };
}
