{ pkgs, inputs, ... }:
{
  # Fingerprint reader (Synaptics 06cb:00a2): the REA-FS libfprint-TOD driver.
  # fprintd-tod loads it; templates live on the sensor. Rollback: enable = false
  imports = [ inputs.syna-00a2.nixosModules.default ];
  services.syna-00a2 = {
    enable = true;
    # Keeps recent login touches as templates; see the option for the risk
    refresh = true;
  };

  # Fingerprint reader (Synaptics 06cb:00a2). Lets the logged-in user open it
  # without sudo while reverse-engineering its driver with REA-FS. Remove once
  # the driver ships as a root service.
  # Not `services.udev.extraRules`: that lands in 99-local.rules, after
  # 73-seat-late.rules applies `uaccess`, so the tag would be ignored
  services.udev.packages = [
    (pkgs.writeTextDir "lib/udev/rules.d/70-syna-00a2.rules" ''
      SUBSYSTEM=="usb", ATTRS{idVendor}=="06cb", ATTRS{idProduct}=="00a2", MODE="0660", TAG+="uaccess"
    '')
  ];
}
