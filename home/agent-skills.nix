{ inputs, ... }:
{
  imports = [ inputs.agent-skills.homeManagerModules.default ];

  programs.agent-skills = {
    enable = true;
    targets.opencode.enable = true;
    targets.claude.enable = true;

    sources.skills = {
      input = "skills";
      subdir = "skills";
    };
    sources.ponytail = {
      input = "ponytail";
      subdir = "skills";
    };
    skills.enable = [
      "neovim"
      "nix"
    ];
    skills.enableAll = [ "ponytail" ];
  };

  # OpenCode instructions
  home.file.".config/opencode/opencode.json".text = builtins.toJSON {
    instructions = [ "${inputs.rust-skills}/.opencode/instructions/rust-skills.md" ];
  };
}
