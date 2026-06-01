{
  config,
  inputs,
  ...
}: {
  config.flake.nixosConfigurations.example = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
      outputs = config.flake;
      suiteModules = config.flake.modules;
    };
    modules = [../nixos/configuration.nix];
  };
}
