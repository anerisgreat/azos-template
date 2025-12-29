{
  lib,
  config,
  pkgs,
  azos-utils,
  ...
}: let
  isEnabled =
    config.azos.emacs.enable && config.azos.suites.example.enable;
  emacspkgs = config.azos.emacs.emacspkg.pkgs;
  localPkgName = "azos-emacs-example";
in {
  #Set config
  options.azos.suites.example.enable = azos-utils.mkSuiteEnableOption {};
  config = lib.mkIf isEnabled {
    azos.emacs.enabledSuites = [localPkgName];

    #Base emacs suite definition
    azos.emacs.pkgs = [pkgs.azos-emacs-example];
  };
}
