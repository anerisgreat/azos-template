# Standalone home-manager for a non-NixOS host (e.g. Fedora with a user-level
# Nix install). Rename "user@example" to "<your user>@<hostname>" so a bare
# `home-manager switch --flake '.?submodules=1'` picks it up automatically.
{
  config,
  inputs,
  ...
}: let
  system = "x86_64-linux";
  pkgs = import inputs.nixpkgs {
    inherit system;
    overlays = [
      config.flake.overlays.addpkgs
      config.flake.overlays.modifications
      config.flake.overlays.unstable-packages
    ];
    config.allowUnfree = true;
  };
in {
  config.flake.homeConfigurations."user@example" = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = {
      inherit inputs;
      outputs = config.flake;
      suiteModules = config.flake.modules;
    };
    modules = [
      ../home-manager/home.nix
      {azos.genericLinux.enable = true;}
    ];
  };
}
