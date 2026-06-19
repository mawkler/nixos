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

  # OpenCode instructions
  home.file.".config/opencode/opencode.json".text = builtins.toJSON {
    instructions = [ "${inputs.rust-skills}/.opencode/instructions/rust-skills.md" ];
  };
}
