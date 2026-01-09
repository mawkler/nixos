{ config }:
{
  # -------------------------------------------------------------------------
  #   `configsPath`: a path value to a directory who's files/directories
  #   should be symlinked to from `~/.config/`.
  #
  #   `configsAbsolutePath`: an absolute path to `configsPath`.
  #
  #   The reason this function requires two path parameters to the same
  #   directory is that it uses `builtins.readDir` which would require
  #   `--impure` if only an absolute path were used. If using only a literal
  #   Nix path, the symlinks would point to the Nix store, and thereby require
  #   a build whenever a config file is edited.
  #
  #   `returns`: an attribute set suitable for `xdg.configFile`.
  # -----------------------------------------------------------------
  configSymlinks = configsPath: configsAbsolutePath:
    let
      inherit (config.lib.file) mkOutOfStoreSymlink;

      mkSymlink = name: {
        name = name;
        value.source = mkOutOfStoreSymlink "${configsAbsolutePath}/${name}";
      };
    in configsPath
      |> builtins.readDir
      |> builtins.attrNames
      |> builtins.filter (name: name !=  "default.nix") # Don't symlink this file
      |> map mkSymlink
      |> builtins.listToAttrs;
}
