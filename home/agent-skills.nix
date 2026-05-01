{ inputs, ... }:
{
  imports = [ inputs.agent-skills.homeManagerModules.default ];

  programs.agent-skills = {
    enable = true;
    targets.opencode.enable = true;

    sources.neovim-skill = {
      input = "neovim-skill";
      subdir = "stow/shared/.claude/skills";
    };
    skills.enable = [
      "neovim"
    ];
  };
}
