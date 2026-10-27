# 1Password as the password manager (instead of the default GNU pass).
#
# Host side first (see ../fedora/README.org): install the 1Password app and
# CLI from 1Password's RPM repo, sign in to the app, and enable
# Settings -> Developer -> "Integrate with 1Password CLI". Check with
# `op item list` before switching.
{...}: {
  azos.password-manager.pass.enable = false;
  azos.password-manager.onepassword = {
    enable = true;
    # The host's `op` (from the RPM) is used by default. Only install it from
    # nixpkgs if there's no host package -- that one can't unlock via the app.
    # installCli = true;
    # opCommand = "op";

    # Vault entries are looked up in. Leave null to search all vaults;
    # Emacs auth-source lookups then use "Private".
    vault = "Private";
  };

  # 1Password's SSH agent owns SSH_AUTH_SOCK; keep gpg-agent off it. Also
  # point ssh at it: Settings -> Developer -> "Use the SSH agent".
  azos.encryption.sshSupport = false;
  home.sessionVariables.SSH_AUTH_SOCK = "$HOME/.1password/agent.sock";

  # Git over HTTPS via the password manager: host -> item. The item's
  # "password" field is used, and its "username" field if present.
  # azos.git-config.credentials = {
  #   "git.example.com" = "git.example.com";
  # };
}
