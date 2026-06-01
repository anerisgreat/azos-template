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
    # suiteModules.homeManager.dev
    # suiteModules.homeManager.editor
    # suiteModules.homeManager.station
    # suiteModules.homeManager.exwm
    # suiteModules.homeManager.example
  ];

  programs.home-manager.enable = true;

  azos.suites.base.enable = true;
  azos.name = "User Name";

  home = {
    username = "user";
    homeDirectory = "/home/user";
  };

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.11";
}
