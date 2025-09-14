{ pkgs, ... }:
let
  # Script with Fzf integration
  ns = {
    url =
      "https://raw.githubusercontent.com/3timeslazy/nix-search-tv/refs/heads/main/nixpkgs.sh";
    hash = "sha256-bEiwM2i9+AKpUuWV3D4y+EIm5AxArczz8Dpmf0R8svw=";
  }
  |> pkgs.fetchurl
  |> builtins.readFile
  |> pkgs.writeShellScriptBin "ns";
in { environment.systemPackages = with pkgs; [ nix-search-tv ns ]; }
