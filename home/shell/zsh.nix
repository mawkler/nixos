{ lib, config, rootPath, ... }: {
  # Allow unfree package
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "zsh-abbr" ];

  programs.fzf.enableZshIntegration = true;
  programs.fzf.enableBashIntegration = true;

  programs.zsh = rec {
    enable = true;
    history.size = 10000;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh.enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    initContent = let
      # Load fish instead of zsh
      # https://wiki.nixos.org/wiki/Fish#Setting_fish_as_default_shell
      loadFish = lib.mkBefore # sh
        ''
          if [[ $(ps -o command= -p "$PPID" | awk '{print $1}') != 'fish' ]]
          then
              exec fish -l
          fi
        '';
      loadZsh = "source ~/.zshrc";
    in lib.mkMerge [ loadFish loadZsh ];

    shellAliases = import ./aliases.nix { inherit rootPath; };
    zsh-abbr = {
      enable = true;
      abbreviations = shellAliases;
    };

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-history-substring-search"; }
        { name = "ael-code/zsh-colored-man-pages"; }
        { name = "mawkler/zsh-bd"; }
        { name = "hlissner/zsh-autopair"; }
        { name = "Aloxaf/fzf-tab"; }
        {
          name = "romkatv/powerlevel10k";
          tags = [ "as:theme" "depth:1" ];
        }
      ];
    };
  };

  # Enable zsh-abbr custom cursor placement
  home.sessionVariables.ABBR_SET_EXPANSION_CURSOR = 1;
}
