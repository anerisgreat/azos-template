# Mail: mbsync + msmtp + mu4e. Accounts are plain home-manager
# accounts.email.accounts; azos-core derives the mu setup from them.
#
# NOTE: mu4e contexts/bookmarks are currently still hardcoded in
# azos-core/suites/desktop/emacs/config.org and won't match these accounts.
{
  lib,
  config,
  pkgs,
  ...
}: let
  common = {
    realName = config.azos.name;
    mbsync = {
      enable = true;
      create = "maildir";
      remove = "both";
      expunge = "both";
    };
    msmtp.enable = true;
  };
in {
  azos.mail.enable = true;

  # Optional: skip timer syncs unless this command succeeds, e.g. a smartcard
  # presence check when passwords need a YubiKey to decrypt.
  # azos.mail.presenceCheckCommand = "gpg --card-status >/dev/null 2>&1";

  accounts.email.accounts = {
    # Gmail / Google Workspace: needs an App Password
    # (myaccount.google.com/apppasswords), not the account password.
    work =
      common
      // {
        flavor = "gmail.com";
        primary = true;
        address = "user@example.com";
        userName = "user@example.com";
        passwordCommand = "azos-password-get mbsync/user@example.com";
      };

    # Generic IMAP/SMTP.
    # personal =
    #   common
    #   // {
    #     address = "me@example.org";
    #     userName = "me@example.org";
    #     imap.host = "mail.example.org";
    #     smtp = {
    #       host = "mail.example.org";
    #       port = 587;
    #       tls = {
    #         enable = true;
    #         useStartTls = true;
    #         # Distro-independent CA bundle (Fedora has no
    #         # /etc/ssl/certs/ca-certificates.crt).
    #         certificatesFile = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
    #       };
    #     };
    #     passwordCommand = "azos-password-get example.org";
    #   };
  };
}
