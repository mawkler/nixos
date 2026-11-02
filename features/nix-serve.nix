{
  lib,
  pkgs,
  hostnames,
  hostname,
  ...
}:
let
  cacheUrls = hostnames |> builtins.filter (h: h != hostname) |> map (h: "http://${h}.local:5000");

  # `nix-serve serve`/`stop` toggles this host's cache. `nix-serve client` opens
  # a shell (or runs a command) that uses the caches of the hosts that are up
  nix-serve =
    pkgs.writers.writeFishBin "nix-serve" # fish
      ''
        switch "$argv[1]"
            case serve
                sudo systemctl start nix-serve && echo "Serving http://${hostname}.local:5000"
            case stop
                sudo systemctl stop nix-serve
            case client
                for url in ${toString cacheUrls}
                    if ${lib.getExe pkgs.curl} --silent --fail --max-time 2 $url/nix-cache-info >/dev/null
                        set -a urls $url
                    end
                end
                if not set -q urls[1]
                    echo "No binary cache is up, tried: ${toString cacheUrls}" >&2
                    exit 1
                end
                echo "Using binary caches: $urls"
                # Picked up by every `nix` command, which forwards it to the daemon
                set -gx NIX_CONFIG "extra-substituters = $urls"
                if set -q argv[2]
                    exec $argv[2..]
                else
                    exec $SHELL
                end
            case '*'
                echo "Usage: nix-serve serve | stop | client [command...]" >&2
                exit 1
        end
      '';
in
{
  # Server. Off by default; toggled with `nix-serve serve`/`stop`
  services = {
    nix-serve = {
      enable = true;
      openFirewall = true;
      package = pkgs.nix-serve-ng;
      secretKeyFile = "/var/secrets/nix-serve/secret.key";
    };

    # So hosts can reach each other via `<hostname>.local`
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
  };

  # Don't start nix-serve at boot
  systemd.services.nix-serve.wantedBy = lib.mkForce [ ];

  environment.systemPackages = [ nix-serve ];

  # Client. Opt-in with `nix-serve client`, since the other hosts are usually off
  nix.settings = {
    trusted-substituters = cacheUrls;
    trusted-public-keys = [
      "cache.thinkpad-nixos.local-1:GOD9LtryYSo83u53HDM7YxYRmsnrltvSFsOUlaqsWjo="
      "cache.beauty.local-1:FRLDLnUQ+Shu5AzUenJ93K1NryLDFKvwHUOHmUEbtD8="
    ];
  };
}
