{ inputs, ... }:
[
  # Add unstable packages to `pkgs.unstable`
  (final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  })
]
