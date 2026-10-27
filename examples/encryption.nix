# GPG / YubiKey / signing. gpg-agent (with pinentry in Emacs) is on by
# default; everything here is opt-in.
{...}: {
  # Sign commits.
  azos.git-config.signing = {
    enable = true;
    key = "FILL-IN-GPG-KEY-ID";
  };

  # YubiKey tooling (ykinfo, ykpersonalize).
  azos.encryption.yubikey.enable = true;

  # Browser autofill from GNU pass.
  # azos.encryption.browserpass.enable = true;

  # Use a GPG authentication subkey as the SSH key.
  # Keygrip: `gpg --list-keys --with-keygrip`; public key: `gpg --export-ssh-key <id>`.
  azos.encryption.gpgSsh = {
    enable = true;
    keygrip = "FILL-IN-KEYGRIP";
    publicKey = "ssh-rsa FILL-IN openpgp:0xFILLIN";
    # extraSshConfig = ''
    #   Host example
    #     HostName example.com
    # '';
  };

  # Git over HTTPS via pass-git-helper. Prefer azos.git-config.credentials,
  # which works with any password manager.
  # azos.git-config.credentials = {"git.example.com" = "example.com";};
}
