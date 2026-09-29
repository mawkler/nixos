{
  username,
  lib,
  pkgs,
  ...
}:
{
  home.file = {
    ".config/sccache/config".text = # toml
      ''
        [cache.disk]
        dir = "/home/${username}/.cache/sccache"
        size = 214_748_364_800 # 200 GB
      '';
    # to override `home/dotfiles/home/.cargo/config.toml`
    ".cargo/config.toml".source = lib.mkForce (
      pkgs.writeText "cargo-config.toml" # toml
        ''
          [build]
          target-dir = "/home/${username}/.cargo/targets/dfmain"
          rustc-wrapper = "sccache"
          incremental = false

          [target.x86_64-unknown-linux-gnu]
          rustflags = ["--remap-path-prefix=/home/${username}/gitrepos=/workspace"]
        ''
    );
  };
}
