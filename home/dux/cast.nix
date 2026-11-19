# DMS Cast plugin: Chromecast mirroring and playback. Also needs Avahi and TCP
# port 47830 open, which are both set up in `features/core.nix`
{ pkgs, lib, ... }:
let
  # Helper behind the plugin (Chromecast discovery, mirroring and playback).
  # Not in nixpkgs, so pinned to the release the plugin expects (it shows when
  # a newer one is out). AirPlay is left out, since it needs `doubletake`,
  # which isn't packaged either
  cast-helper = pkgs.buildGoModule (finalAttrs: {
    pname = "cast-helper";
    version = "0.2.0";

    src = pkgs.fetchFromGitHub {
      owner = "Conava";
      repo = "dux-cast";
      tag = "v${finalAttrs.version}";
      hash = "sha256-39pZjbktT/mFBesS089QnW01qefsQQAE4iHJb4wMeDg=";
    };
    vendorHash = "sha256-JdnJBwV2DHo/1EZ5v6bxC1JK/5PUIZeRmjroMnZrQoQ=";

    nativeBuildInputs = [ pkgs.makeWrapper ];

    # GStreamer is loaded with `dlopen` at runtime, so it has to be found
    # through the environment. The binary keeps its own name, because the plugin
    # stops it with `pkill -x cast-helper`
    postInstall = with pkgs; ''
      mkdir -p $out/libexec
      mv $out/bin/dux-cast $out/libexec/cast-helper
      makeWrapper $out/libexec/cast-helper $out/bin/cast-helper \
        --prefix LD_LIBRARY_PATH : ${
          lib.makeLibraryPath [
            glib
            gst_all_1.gstreamer
            gst_all_1.gst-plugins-base
          ]
        } \
        --prefix GST_PLUGIN_SYSTEM_PATH_1_0 : ${
          lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" [
            gst_all_1.gst-libav
            gst_all_1.gst-plugins-bad
            gst_all_1.gst-plugins-base
            gst_all_1.gst-plugins-good
            pipewire
          ]
        } \
        --prefix PATH : ${
          lib.makeBinPath [
            libheif
            pipewire
          ]
        }
    '';
  });
in
{
  programs.dank-material-shell.plugins.cast.enable = true;

  home.packages = [ cast-helper ];
}
