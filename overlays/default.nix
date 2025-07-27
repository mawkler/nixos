{ inputs, ... }:
[
  # Add stable packages to `pkgs.stable`
  (final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  })
]
