{ pkgs, lib, ... }:
let
  kache = lib.getExe pkgs.kache;
in
{
  environment.systemPackages = [ pkgs.kache ];
  environment.variables.RUSTC_WRAPPER = kache;

  systemd.user.services.kache = {
    description = "kache build cache daemon";
    after = [ "default.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${kache} daemon run";
      Restart = "on-failure";
      RestartSec = "5s";
    };
    environment.KACHE_LOG = "kache=info";
  };
}
