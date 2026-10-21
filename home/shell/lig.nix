{ inputs, ... }:
{
  imports = [ inputs.lig.homeModules.default ];

  programs.lig = {
    enable = true;
    # zsh only execs fish (see ./zsh.nix), and lig has to wrap fish, not zsh
    enableZshIntegration = false;
  };
}
