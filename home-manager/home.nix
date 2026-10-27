# Home-manager entry point, shared by the NixOS machine (nixos/configuration.nix)
# and the standalone non-NixOS one (_machines/example-home.nix).
#
# Everything marked FILL IN must be set before the first switch. Optional
# features live as ready-to-edit modules in ../examples/: copy one next to
# this file (e.g. `cp ../examples/mail.nix ./mail.nix`), fill it in, and add
# it to `imports` below.
{
  inputs,
  outputs,
  suiteModules,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    suiteModules.homeManager.base
    suiteModules.homeManager.editor
    suiteModules.homeManager.dev
    suiteModules.homeManager.desktop
    suiteModules.homeManager.exwm
    # suiteModules.homeManager.example

    # ./password-manager.nix   # from ../examples/password-manager-1password.nix
    # ./encryption.nix         # from ../examples/encryption.nix
    # ./mail.nix               # from ../examples/mail.nix
    # ./dav.nix                # from ../examples/dav.nix
    # ./send-alert.nix         # from ../examples/send-alert.nix
    # ./headphones.nix         # from ../examples/headphones.nix
    # ../examples/claude.nix   # no values to fill in; import as-is
  ];

  programs.home-manager.enable = true;

  # exwm turns on desktop and base; editor/dev are independent.
  azos.suites.exwm.enable = true;
  azos.suites.editor.enable = true;
  azos.suites.dev.enable = true;

  # FILL IN: identity.
  azos.name = "User Name";
  azos.git-config.userName = "User Name";
  azos.git-config.userEmail = "user@example.com";

  # FILL IN: password manager. GNU pass is on by default and needs a GPG key;
  # for 1Password, import ../examples/password-manager-1password.nix instead
  # and delete this line.
  azos.password-manager.pass.gpgKeyId = "FILL-IN-GPG-KEY-ID";

  # FILL IN: account.
  home = {
    username = "user";
    homeDirectory = "/home/user";
  };

  systemd.user.startServices = "sd-switch";

  # Set once, on the first switch, to the then-current release; never bump it.
  home.stateVersion = "25.11";
}
