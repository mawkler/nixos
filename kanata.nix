{ ... }: {
  # Enable the uinput module
  boot.kernelModules = [ "uinput" ];

  # Enable uinput
  hardware.uinput.enable = true;

  # Set up udev rules for uinput
  services.udev.extraRules = # udev
    ''
      KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '';

  # Ensure the uinput group exists
  users.groups.uinput = { };

  # Add the Kanata service user to necessary groups
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [ "input" "uinput" ];
  };

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        extraDefCfg = "process-unmapped-keys yes";
        # Map `CapsLock` to `Esc` when tapped and `Ctrl` when held down
        config = # scheme
          ''
            (defsrc
              caps
            )

            (defalias
              escctrl (tap-hold-press 150 150 esc lctrl)
            )

            (deflayer base
              @escctrl
            )
          '';
      };
    };
  };
}
