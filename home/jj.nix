# I put `nix` as language for the revsets because tree-sttier doesn't have a parser for them (yet)
{ pkgs, ... }:
{
  programs.jujutsu = {
    enable = true;
    settings =
      let
        cmd = pkgs.lib.splitString " ";
        exec = command: (cmd "util exec -- bash -c") ++ [ command ];
      in
      {
        user = {
          name = "Melker Ulander";
          email = "melker.ulander@pm.me";
        };
        ui = {
          diff-formatter = "delta";
          # Hide output when quitting pager
          pager = cmd "delta --pager less";
          default-command = "status";
          merge-editor = "diffconflicts";
          diff-editor = [
            "nvim"
            "-c"
            "DiffEditor $left $right $output"
          ];
        };
        templates = {
          draft_commit_description = /* nix */ ''
            concat(
              builtin_draft_commit_description,
              "\nJJ: ignore-rest\n",
              diff.git(),
            )
          '';
        };
        merge-tools = {
          delta = {
            # Fixes `tool exited with exit status: 1` warning
            diff-expected-exit-codes = [
              0
              1
            ];
          };
          diffconflicts = {
            program = "nvim";
            merge-tool-edits-conflict-markers = true;
            merge-args = [
              "-c"
              "let g:jj_diffconflicts_marker_length=$marker_length"
              "-c"
              "JJDiffConflicts"
              "$output"
              "$base"
              "$left"
              "$right"
            ];
          };
        };
        revset-aliases = {
          "closest_pushable(to)" = # nix
            ''heads(::to & mutable() & ~description(exact:"") & (~empty() | merges()))'';
          "closest_bookmark(to)" = # nix
            "heads(::to & bookmarks())";

          "stack()" = /* nix */ "stack(@)";
          "stack(x)" = /* nix */ "stack(x, 2)";
          "stack(x, n)" = /* nix */ "ancestors(reachable(x, mutable()), n)";
          "feature_branch(x)" = /* nix */ "reachable(x, ~::trunk())";
        };
        aliases = {
          # Move the closest bookmark (or passed in bookmark name) to the closest pushable commit
          tug = exec /* sh */ ''
            if [ -z "$(jj log -r 'closest_pushable(@)')" ]; then
              echo "No commit is tuggable" && exit 0
            fi
            if [ "x$1" = "x" ]; then
              jj bookmark move --from "closest_bookmark(@)" --to "closest_pushable(@)"
            else
              jj bookmark move --to "closest_pushable(@)" "$@"
            fi
          '';

          pull = exec /* sh */ ''
            closest="$(jj log -r 'closest_bookmark(@)' -n 1 -T 'bookmarks' --no-graph | cut -d ' ' -f 1)"
            closest="''${closest%\*}"
            jj git fetch
            jj log -n 1 -r "''${closest}" 2>&1 > /dev/null && jj rebase -d "''${closest}" || jj rebase -d 'trunk()'
            jj log -r 'stack()'
          '';

          push = exec /* sh */ ''
            tuggable="$(jj log -r 'closest_bookmark(@)..closest_pushable(@)' -T '"n"' --no-graph)"
            [[ -n "$tuggable" ]] && jj tug
            pushable="$(jj log -r 'remote_bookmarks(remote=origin)..@' -T 'bookmarks' --no-graph)"
            [[ -n "$pushable" ]] && jj git push || echo "Nothing to push."
            closest="$(jj log -r 'closest_bookmark(@)' -n 1 -T 'bookmarks' --no-graph | cut -d ' ' -f 1)"
            closest="''${closest%\*}"
            tracked="$(jj bookmark list -r ''${closest} -t -T 'if(remote == "origin", name)')"
            [[ "$tracked" == "$closest" ]] || jj bookmark track "''${closest}@origin"
          '';

          init = exec /* sh */ ''
            jj git init --colocate
            jj bookmark track 'glob:*' --remote 'origin' # only track origin branches, not upstream or others
          '';

          z = exec /* sh */ ''
            if [ "x$1" = "x" ]; then
              jj bookmark list
            else
              jj bookmark list -a -T 'separate("@", name, remote) ++ "
            "' 2> /dev/null \
                | sort | uniq | fzf -f "$1" | head -n1 | xargs jj new
            fi

          '';
          za = cmd "bookmark list -a";

          pr = exec /* sh */ ''
            gh pr create --head $(jj log -r 'closest_bookmark(@)' \
              -T 'bookmarks' --no-graph | cut -d ' ' -f 1)
          '';

          mr = exec /* sh */ ''
            glab mr create --source-branch $(jj log -r 'closest_bookmark(@)' \
              -T 'bookmarks' --no-graph| cut -d ' ' -f 1)
          '';
        };
      };
  };
  home.packages = with pkgs; [
    lazyjj
    jjui
  ];
}
