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
  };
}
