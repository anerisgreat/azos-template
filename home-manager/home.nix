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
  ];

  nixpkgs = {
    overlays = [
      inputs.azos-core.overlays.addpkgs
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  programs.home-manager.enable = true;

  #Enable relevant suites
  # azos.suites.base.enable = true;
  # azos.suites.editor.enable = true;
  # azos.suites.dev.enable = true;
  # azos.suites.station.enable = true;
  # azos.suites.exwm.enable = true;
  # azos.name = "Aner Zakobar";

  # TODO: Set your username
  # home = {
  #   username = "aner";
  #   homeDirectory = "/home/aner";
  # };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
