{ inputs, ... }:
{
  imports = [ inputs.agent-skills.homeManagerModules.default ];

  programs.agent-skills = {
    enable = true;
    targets.opencode.enable = true;

    sources.skills = {
      input = "skills";
      subdir = "skills";
    };
    skills.enable = [
      "neovim"
      "nix"
    ];
  };
}
