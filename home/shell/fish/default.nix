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
      shellAbbrs = (import ../aliases.nix { inherit rootPath; }) // {
        nr = {
          expansion = "nix run nixpkgs#%";
          setCursor = true;
        };
      };
      # shellInit = # fish
      # ''
      #   if type -q atuin
      #     atuin init fish | source
      #   end
      # '';
      shellInitLast = "source ${rootPath}/home/shell/fish/config.fish";
      shellAliases = {
        ls = "eza --icons auto";
        tree = "eza --tree --git-ignore";
        less = "less -mgiJr --underline-special --SILENT";
      };
      functions = {
        open = "xdg-open &>/dev/null $argv & disown";
        # Re-print the NixOS and home-manager diffs against the closures passed
        # as arguments, so the system's diff doesn't get buried by home-manager's
        nh-recap = {
          description = "Diff the given system and home-manager closures against the current ones";
          body = # fish
            ''
              set -l titles NixOS home-manager
              set -l profiles /run/current-system $HOME/.local/state/nix/profiles/home-manager
              for i in 1 2
                  set -l new (readlink -f $profiles[$i])
                  test -z "$argv[$i]" -o "$argv[$i]" = "$new"; and continue
                  echo
                  set_color --bold magenta
                  echo "━━━ $titles[$i] ━━━"
                  set_color normal
                  ${pkgs.dix}/bin/dix diff $argv[$i] $new
              end
            '';
        };
      };
      binds =
        let
          bind = command: {
            inherit command;
            mode = "insert";
          };
        in
        {
          # Overrides fzf's `fzf_complete` binding, which would compete with lig
          "shift-tab" = bind "complete";
          "ctrl-o" = bind "fzf_complete";
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
      fileWidget.command = "${pkgs.ripgrep}/bin/rg --hidden --files --no-messages";
      fileWidget.options = [ "--preview '${batPreview}'" ];
      changeDirWidget.command = "${pkgs.fd}/bin/fd --type directory -H --ignore-file ~/.ignore";
      changeDirWidget.options = [ "--preview '${ezaPreview}'" ];
    };
  };

  home.packages = with pkgs; [
    fishPlugins.fish-bd
  ];
}
