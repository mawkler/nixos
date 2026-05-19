{
  imports = [
    # keep-sorted start
    ./fish
    ./zoxide.nix
    ./zsh.nix
    # keep-sorted end
  ];
  programs = {
    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };

    mergiraf = {
      enable = true;
      enableJujutsuIntegration = false;
    };

    atuin = {
      enable = true;
      flags = [ "--disable-up-arrow" ];
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

  };
}
