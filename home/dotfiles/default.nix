{ config, ... }:
{
  # -------------------------------------------------------------------------
  #   `configsNixPath`: a Nix path type to a directory who's files/directories
  #   should be symlinked to from `~/.config/`.
  #
  #   `configsAbsPath`: an absolute string path to `configsPath`.
  #
  #   The reason this function requires two path parameters to the same
  #   directory is that it uses `builtins.readDir` which would require
  #   `--impure` if only an absolute path were used. If using only a literal
  #   Nix path, the symlinks would point to the Nix store, and thereby require
  #   a build whenever a config file is edited.
  #
  #   `returns`: an attribute set suitable for `xdg.configFile`.
  # -----------------------------------------------------------------
  mkSymlinks =
    configsAbsPath: configsNixPath:
    let
      inherit (config.lib.file) mkOutOfStoreSymlink;

      # Turn relative paths into xdg.configFile entries
      mkSymlink = nixPath: {
        name = nixPath;
        value.source = mkOutOfStoreSymlink "${configsNixPath}/${nixPath}";
      };

      # Recursively read in all files in all subdirectories
      readDirRecursive =
        relPath: nixPath:
        nixPath
        |> builtins.readDir
        |> builtins.attrNames
        |> map (
          name:
          let
            entryType = nixPath |> builtins.readDir |> (entries: entries.${name});
            relPath' = if relPath == "" then name else "${relPath}/${name}";
            nixPath' = "${nixPath}/${name}";
          in
          # Don't include paths to the directories themselves
          if entryType == "directory" then readDirRecursive relPath' nixPath' else [ relPath' ]
        )
        |> builtins.concatLists;
    in
    readDirRecursive "" configsAbsPath |> map mkSymlink |> builtins.listToAttrs;
}
