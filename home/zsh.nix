{ lib, config, ... }: {
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
    initContent = "source ~/.zshrc";

    zsh-abbr = {
      enable = true;
      abbreviations = shellAliases;
    };

    shellAliases = let
      pipeToNom = "--log-format internal-json |& nom --json";
      nixIcon = "~/.config/nixos/assets/nix.svg";
      notifyDone = message: "notify-send --icon ${nixIcon} NixOS '${message}'";
      nixosRebuild = subcommand:
        "sudo true && sudo nixos-rebuild ${subcommand} ${pipeToNom} || ${
          notifyDone "NixOS rebuild finished"
        }";
      homeManager = "home-manager --flake ~/.config/nixos/#melker";
    in {
      # TODO: switch to nixos-rebuild-ng
      nrs = nixosRebuild "switch";
      nru = nixosRebuild "switch --upgrade";
      nrt = nixosRebuild "test";
      hm = homeManager;
      hms = "${homeManager} switch --impure ${pipeToNom} || ${
          notifyDone "Home Manager finished"
        }";
      nr = "nix run nixpkgs#%";

      dots = "dot status";

      src = "exec zsh";
      screenkey = "screenkey -t 1.5 -s small";
      Bat = "bat --pager='less - mgi - -underline-special - -SILENT'";
      myip = "hostname -i";
      mv = "mv -i";
      ag = "ag --hidden --pager='less -R'";
      rg = "rg --hidden --smart-case";
      fd = "fd --hidden";
      mvc = "mullvad connect";
      mvd = "mullvad disconnect";
      mvr = "mullvad reconnect";

      g = "git";
      gs = "git status";
      gl = "git log --decorate";
      gd = "git diff -- :!package-lock.json :!yarn.lock :!Cargo.lock";
      gds = "git diff --staged -- :!package-lock.json :!yarn.lock :!Cargo.lock";
      gc = "git commit -v";
      gco = "git checkout";
      gcom = "git checkout `_master_branch`";
      gmm = "git merge master";
      gp = "git pull --autostash";
      gP = "git push";
      gb = "git branch";
      gw = "git whatchanged";
      ga = "git add";
      gcm = "git commit -mv";
      gcam = "git commit -avm";
      gca = "git commit -av";
      gcaa = "git commit -av --amend";
      gcA = "git commit -v --amend";
      gu = "git diff HEAD@{1} HEAD";
      gly = "git log --since='yesterday'";
      gr = "git reset";
      grc = "git rebase --continue";
      gra = "git rebase --abort";
      gdm = "git diff `_master_branch`..HEAD";
      gdu = "diff upstream/`_master_branch`";
      gru = "git pull --rebase --autostash upstream `_master_branch`";
      gsp = "git stash pop";
      gss = "git stash show -p";
      glm = "git log `_master_branch`";
      gldm = "git log --decorate --oneline `_master_branch`..";
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
