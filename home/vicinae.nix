{ config, pkgs, ... }: {
  programs.vicinae = {
    enable = true;
    systemd.enable = true;

    settings = {
      faviconService = "twenty";
      font.size = 12;
      popToRootOnClose = false;
      rootSearch.searchFiles = false;
      theme.name = "github-dark-dimmed";
      window = {
        csd = true;
        # opacity = 0.5; # Disabled until Niri gets blur support https://github.com/YaLTeR/niri/issues/54
        rounding = 25;
      };
    };

    extensions = let
      mkExtension = name:
        (config.lib.vicinae.mkExtension {
          inherit name;
          src = pkgs.fetchFromGitHub {
            owner = "vicinaehq";
            repo = "extensions";
            rev = "ec7334e9bb636f4771580238bd3569b58dbce879";
            sha256 = "sha256-C2b6upygLE6xUP/cTSKZfVjMXOXOOqpP5Xmgb9r2dhA=";
          } + "/extensions/${name}";
        });
    in [
      (mkExtension "mullvad")
      (mkExtension "bluetooth")
      (mkExtension "nix")
      (mkExtension "niri")
      (mkExtension "power-profile")
      (mkExtension "port-killer")
      (mkExtension "wifi-commander")
      # (mkExtension "systemd")

      (config.lib.vicinae.mkRayCastExtension {
        name = "gif-search";
        sha256 = "sha256-G7il8T1L+P/2mXWJsb68n4BCbVKcrrtK8GnBNxzt73Q=";
        rev = "4d417c2dfd86a5b2bea202d4a7b48d8eb3dbaeb1";
      })
    ];
  };
}
