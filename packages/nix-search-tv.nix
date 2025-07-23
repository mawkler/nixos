{ pkgs, ... }:
let
  # Script with Fzf integration
  ns = {
    url =
      "https://raw.githubusercontent.com/3timeslazy/nix-search-tv/refs/heads/main/nixpkgs.sh";
    hash = "sha256-v3O1g6LXlSPzTNgSTshISw2s+NeWuPncyHy9P1Cb+0w=";
  }
  |> pkgs.fetchurl
  |> builtins.readFile
  |> pkgs.writeShellScriptBin "ns";
in { environment.systemPackages = with pkgs; [ nix-search-tv ns ]; }
