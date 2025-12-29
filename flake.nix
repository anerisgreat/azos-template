{
  description = "Aner's NIX config for his systems!";

  inputs = {
    self.submodules = true;
    # Nixpkgs
    #Temporarily
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Unused unstable
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      # Follow corresponding `release` branch from Home Manager
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    azos-core = {
      url = "./azos-core";
      flake = true;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "aarch64-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    overlays = import ./overlays {inherit inputs;};
    azos-core.nixosModules = inputs.azos-core.nixosModules.nixosModules;
    nixosModules = import ./modules/nixos;
    azos-core.homeManagerModules = inputs.azos-core.nixosModules.homeManagerModules;
    homeManagerModules = import ./modules/home-manager;

    #Systems configured
    nixosConfigurations = {
      #Example hardware
      # example_hardware = nixpkgs.lib.nixosSystem {
      #   specialArgs = {inherit inputs outputs;};
      #   modules = [
      #     ./nixos/configuration.nix
      #   ];
      # };
    };

    devShells = forAllSystems (system: ((import ./shells) {pkgs = nixpkgs.legacyPackages.${system}; }));
  };
}
