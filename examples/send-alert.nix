# azos-send-alert: local notification plus a remote push, and the Claude Code
# long-command notifier. remoteCommand gets TITLE, PRIORITY, TAGS and MESSAGE
# in its environment. With AZOS_SEND_ALERT_PRINT_REMOTE=1 it should instead
# print a self-contained command (secrets resolved) for remote hosts to run.
{pkgs, ...}: let
  ntfy = pkgs.writeShellApplication {
    name = "azos-ntfy-alert";
    runtimeInputs = [pkgs.curl];
    text = ''
      TOKEN="$(azos-password-get ntfy-token)"
      CMD=(curl -sf -H "Authorization: Bearer $TOKEN" -H "Priority: ''${PRIORITY:-default}")
      [[ -n "''${TITLE:-}" ]] && CMD+=(-H "Title: $TITLE")
      [[ -n "''${TAGS:-}" ]] && CMD+=(-H "Tags: $TAGS")
      CMD+=(-d "''${MESSAGE:-}" https://ntfy.example.com/alerts)
      if [[ -n "''${AZOS_SEND_ALERT_PRINT_REMOTE:-}" ]]; then
        printf '%q ' "''${CMD[@]}"
        printf '\n'
      else
        "''${CMD[@]}"
      fi
    '';
  };
in {
  azos.send-alert.enable = true;
  azos.send-alert.remoteCommand = "${ntfy}/bin/azos-ntfy-alert";
  # azos.send-alert.longCommandThresholdSeconds = 300;
}
