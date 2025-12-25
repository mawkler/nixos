{
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  home.sessionVariables = {
    _ZO_FZF_OPTS = ''
      --no-sort
      --keep-right
      --info=inline
      --layout=reverse
      --exit-0
      --select-1
      --bind=ctrl-z:ignore
      --preview-window=right
      --preview=\"$EZA_DIR_PREVIEW {2..} \"
      $FZF_DEFAULT_OPTS
    '';
  };

}
