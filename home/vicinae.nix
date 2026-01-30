{ config, pkgs, inputs, ... }: {
  programs.vicinae = {
    enable = true;
    systemd.enable = true;

    settings = {
      providers.core.entrypoints.search-emojis.preferences.skinTone = "light";
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
      system = pkgs.stdenv.hostPlatform.system;
      extensions = inputs.vicinae-extensions.packages.${system};
      gifSearch = config.lib.vicinae.mkRayCastExtension {
        name = "gif-search";
        sha256 = "sha256-NKmNqRqAnxtOXipFZFXOIgFlVzc0c3B5/Qr4DzKzAx4=";
        rev = "27c8726a793b985df4cc8f1a771e354e9c12b195";
      };
      builtinExtensions = with extensions; [
        mullvad
        bluetooth
        nix
        niri
        power-profile
        port-killer
        wifi-commander
      ];
    in builtinExtensions ++ [ gifSearch ];
  };
}
