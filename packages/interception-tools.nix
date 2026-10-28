{ pkgs, ... }:
let
  dualFunctionKeysConfig = pkgs.writeText "dual-function-keys.yaml" /* yaml */ ''
    TIMING:
      # Holding longer than this and releasing without pressing another key emits nothing
      TAP_MILLISEC: 200
      # Disable "tap then press again to hold Esc"
      DOUBLE_TAP_MILLISEC: 0
    MAPPINGS:
      - KEY: KEY_CAPSLOCK
        TAP: KEY_ESC
        HOLD: KEY_LEFTCTRL
  '';
in
{
  boot.kernelModules = [ "uinput" ];

  # Map `CapsLock` to `Esc` when tapped and `Ctrl` when held down.
  services.interception-tools = {
    enable = true;
    plugins = [ pkgs.interception-tools-plugins.dual-function-keys ];
    udevmonConfig = /* yaml */ ''
      - JOB: "intercept -g $DEVNODE | dual-function-keys -c ${dualFunctionKeysConfig} | uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_CAPSLOCK]
    '';
  };
}
