{
  pkgs,
  config,
  rootPath,
  ...
}:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  fishConfig = "${rootPath}/home/shell/fish";
  batPreview = "${pkgs.bat}/bin/bat --style=numbers --color=always --line-range :100 {}";
  ezaPreview = ''
    ${pkgs.eza}/bin/eza --color=always -T --level=2 --icons auto --git-ignore --git \
    --ignore-glob=.git {}
  '';
in
{
  xdg.configFile = {
    "starship.toml".source = mkOutOfStoreSymlink "${fishConfig}/starship.toml";
    "fish/themes".source = mkOutOfStoreSymlink "${fishConfig}/themes";
  };

  programs = {
    fish = {
      enable = true;
      preferAbbrs = true;
      shellAbbrs = import ../aliases.nix { inherit rootPath; };
      # shellInit = # fish
      # ''
      #   if type -q atuin
      #     atuin init fish | source
      #   end
      # '';
      shellInitLast = "source ${rootPath}/home/shell/fish/config.fish";
      shellAliases = {
        ls = "eza --icons auto";
        tree = "eza --icons never --tree --git-ignore";
        less = "less -mgiJr --underline-special --SILENT";
      };
      functions = {
        open = "xdg-open &>/dev/null $argv & disown";
      };
      binds =
        let
          bind = command: {
            inherit command;
            mode = "insert";
          };
        in
        {
          "tab" = bind "fzf-completion";
          "alt-t" =
            bind
              # fish
              ''
                set dirs (fd --type directory --exclude .git 2>/dev/null \
                    | ${pkgs.fzf}/bin/fzf --multi --reverse --preview "${ezaPreview}")

                if test -n "$dirs"
                    set escaped (string escape --style=script $dirs)
                    commandline -i -- (string join " " $escaped)
                end
                commandline -f repaint
              '';
          # Clear the current prompt's text, and restore it after running
          # another command (like in zsh)
          "ctrl-q" =
            bind
              # fish
              ''
                set -g __fish_pushed_line (commandline)
                commandline ""
                function after-next-prompt --on-event fish_postexec
                    commandline $__fish_pushed_line
                    functions --erase after-next-prompt
                end
              '';
        };
    };

    starship = {
      enable = true;
      enableFishIntegration = true;
      enableTransience = true;
    };

    fzf = {
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
      fileWidgetCommand = "${pkgs.ripgrep}/bin/rg --hidden --files --no-messages";
      fileWidgetOptions = [ "--preview '${batPreview}'" ];
      changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type directory -H --ignore-file ~/.ignore";
      changeDirWidgetOptions = [ "--preview '${ezaPreview}'" ];
    };
  };

  home.packages = with pkgs; [
    fishPlugins.fish-bd
    jj-starship
  ];
}
