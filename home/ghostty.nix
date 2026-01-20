{ pkgs, ... }:
let
  ghosttyShaders = pkgs.fetchFromGitHub {
    owner = "sahaj-b";
    repo = "ghostty-cursor-shaders";
    rev = "14f7cd035f1b483dfe46ba11aef7377b6c4c687d";
    sha256 = "sha256-ky343PVJklT4MqF5whULGwC5e5YfKF7PRGjB+CoBVUI=";
  };
in
{
  programs.ghostty.enable = true;
  home.file.".config/ghostty/shaders".source = ghosttyShaders;
}
