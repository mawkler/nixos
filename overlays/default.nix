{ inputs, ... }:
[
  # Add stable packages to `pkgs.stable`
  (final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  })

  inputs.jj-starship.overlays.default

  inputs.nix-cachyos-kernel.overlays.default
]
