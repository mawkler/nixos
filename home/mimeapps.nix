{
  # Default applications
  xdg.mimeApps = {
    enable = true;
    defaultApplications = let browser = "brave-browser.desktop"; in {
      # keep-sorted start
      "application/pdf" = "sioyek.desktop";
      "inode/directory" = "dev.duxlabs.files.desktop";
      "text/markdown" = browser;
      "text/plain" = "neovide.desktop";
      "x-scheme-handler/beeper" = "beepertexts.desktop";
      "x-scheme-handler/claude-cli" = "claude-code-url-handler.desktop";
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/mailto" = browser;
      "x-scheme-handler/slack" = "slack.desktop";
      # keep-sorted end
    };
  };
}
