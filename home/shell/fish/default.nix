{ config, rootPath, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  fishConfig = "${rootPath}/home/shell/fish";
in {
  xdg.configFile = {
    "starship.toml".source = mkOutOfStoreSymlink "${fishConfig}/starship.toml";
    "fish/themes".source = mkOutOfStoreSymlink "${fishConfig}/themes";
  };

  programs = {
    fish = {
      enable = true;
      preferAbbrs = true;
      shellAbbrs = import ../aliases.nix { inherit rootPath; };
      shellInitLast = "source ${rootPath}/home/shell/fish/config.fish";
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      enableTransience = true;
    };

    fzf = let
      eza =
        "eza --color=always -T --level=2 --icons auto --git-ignore --git --ignore-glob=.git {}";
      bat = "bat --style=numbers --color=always --line-range :100 {}";
    in {
      enable = true;
      enableFishIntegration = true;
      defaultOptions = [
        "--history=$HOME/.fzf_history"
        "--history-size=10000"
        "--height 50%"
        "--pointer '▶'"
        "--gutter ' '"
      ];
      colors = {
        "fg" = "-1";
        "fg+" = "#61afef";
        "bg" = "-1";
        "bg+" = "#444957";
        "hl" = "#E06C75";
        "hl+" = "#E06C75";
        "gutter" = "-1";
        "pointer" = "#61afef";
        "marker" = "#98C379";
        "header" = "#61afef";
        "info" = "#98C379";
        "spinner" = "#61afef";
        "prompt" = "#c678dd";
        "border" = "#798294";
      };
      # TODO: switch to real nix paths for rg, bat and eza
      fileWidgetCommand = "rg --hidden --files --no-messages";
      fileWidgetOptions = [ "--preview '${bat}'" ];
      changeDirWidgetCommand = "fd --type directory -H --ignore-file ~/.ignore";
      changeDirWidgetOptions = [ "--preview '${eza}'" ];
    };
  };
}
