{ ... }: {
  programs.vicinae = {
    enable = true;
    systemd.enable = true;

    settings = {
      faviconService = "twenty";
      font.size = 12;
      popToRootOnClose = false;
      rootSearch.searchFiles = false;
      theme.name = "github-dark-dimmed";
      window = {
        csd = true;
        opacity = 0.5;
        rounding = 25;
      };
    };
  };
}
