{ lib, ... }: {

  # Allow unfree package
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "zsh-abbr" ];

  programs.fzf.enableZshIntegration = true;
  programs.fzf.enableBashIntegration = true;

  programs.zsh = {
    enable = true;
    history.size = 10000;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    zsh-abbr.enable = true;
    oh-my-zsh.enable = true;

    dotDir = ".config/zsh";
    initContent = (builtins.readFile "/home/melker/.zshrc");

    shellAliases = {
      nrs = "sudo nixos-rebuild switch";
      hms = "home-manager switch --impure --flake ~/.config/nixos/#melker";
    };

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-history-substring-search"; }
        { name = "ael-code/zsh-colored-man-pages"; }
        { name = "mawkler/zsh-bd"; }
        { name = "hlissner/zsh-autopair"; }
        { name = "Aloxaf/fzf-tab"; }
        { name = "olets/zsh-abbr"; }
        {
          name = "romkatv/powerlevel10k";
          tags = [ "as:theme" "depth:1" ];
        }
      ];
    };
  };
}
