{
  description = "Azos NIX config template";

  inputs = {
    self.submodules = true;

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    azos-core = {
      url = "./azos-core";
      flake = true;
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.azos-core.flakeModules.default
        ./overlays/default.nix
        (inputs.import-tree ./features)
        ./_machines/example.nix
      ];

      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      perSystem = {
        system,
        pkgs,
        ...
      }: {
        formatter = pkgs.alejandra;
        devShells = (import ./shells) {inherit pkgs;};
      };
    };
}
