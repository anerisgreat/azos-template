# Claude Code with azos' org-roam memory and skills. Not part of azos-core;
# this module is self-contained, just import it.
{pkgs, ...}: {
  home.packages = with pkgs; [claude-code claude-agent-acp];
  azos.agent-memory.backends.claude.enable = true;
  azos.agent-skills.backends.claude.enable = true;
}
