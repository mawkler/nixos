{ inputs, ... }:
[
  # Add stable packages to `pkgs.stable`
  (final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  })

  # nixpkgs' cargo setup hook exports ZSTD_SYS_USE_PKG_CONFIG=1
  # and LIBSQLITE3_SYS_USE_PKG_CONFIG=1, but kache's upstream package doesn't
  # provide pkg-config/zstd/sqlite, so the -sys crates fail to build/link.
  # The kache NixOS module picks up `pkgs.kache` automatically.
  (final: _prev: {
    kache = inputs.kache.packages.${final.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ final.pkg-config ];
      buildInputs = (old.buildInputs or [ ]) ++ [
        final.zstd
        final.sqlite
      ];
    });
  })
]
