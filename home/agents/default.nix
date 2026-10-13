{ config, rootPath, ... }:
let
  agentsMd = config.lib.file.mkOutOfStoreSymlink "${rootPath}/home/agents/instructions/AGENTS.md";
in
{
  # Shared global instructions for coding agents
  xdg.configFile."opencode/AGENTS.md".source = agentsMd;
  home.file.".claude/CLAUDE.md".source = agentsMd;
}
