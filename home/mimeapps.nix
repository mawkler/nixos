{ rootPath, ... }:
{
  # Default applications
  xdg.mimeApps = {
    enable = true;
    defaultApplications = let browser = "brave-origin.desktop"; in {
      # keep-sorted start
      "application/pdf" = "sioyek.desktop";
      "inode/directory" = "org.gnome.Nautilus.desktop";
      "text/calendar" = browser;
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

  # Diff `~/.config/mimeapps.list`'s default applications against this file
  programs.fish.functions.mimediff =
    # fish
    ''
      awk -F= '
        /^\[/ { in_section = ($0 == "[Default Applications]"); next }
        in_section && NF { printf "      \"%s\" = \"%s\";\n", $1, $2 }
      ' ~/.config/mimeapps.list \
        | sort \
        | diff -u (
            sed -n '/keep-sorted[ ]start/,/keep-sorted[ ]end/{//!p}' \
              ${rootPath}/home/mimeapps.nix \
              | psub
          ) - \
        | delta
    '';
}
