# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    outputs.homeManagerModules
    outputs.azos-core.homeManagerModules
  ];

  programs.home-manager.enable = true;

  azos.suites.base.enable = true;
  # azos.suites.editor.enable = true;
  # azos.suites.dev.enable = true;
  # azos.suites.station.enable = true;
  # azos.suites.exwm.enable = true;
  azos.name = "Aner Zakobar";

  home = {
    username = "aner";
    homeDirectory = "/home/aner";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
