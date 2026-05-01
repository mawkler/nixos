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
    sources.nix-skill = {
      input = "nix-skill";
      subdir = "nixos-config/.claude/skills";
    };
    skills.enable = [
      "neovim"
      "Nix"
    ];
  };
}
