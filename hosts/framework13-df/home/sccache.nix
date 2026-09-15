{ username, ... }:
{
  home.file = {
    ".config/sccache/config".text = # toml
      ''
        [cache.disk]
        dir = "/home/${username}/.cache/sccache"
        size = 53_687_091_200 # 54 GB
      '';
    ".cargo/config.toml".text = # toml
      ''
        [build]
        target-dir = "/home/${username}/.cargo/targets/dfmain"
        rustc-wrapper = "sccache"
        incremental = false

        [target.x86_64-unknown-linux-gnu]
        rustflags = ["--remap-path-prefix=/home/${username}/gitrepos=/workspace"]
      '';
  };
}
