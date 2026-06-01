{...}: {
  config.flake.modules.homeManager.example = {
    lib,
    config,
    pkgs,
    ...
  }: {
    options.azos.example.enable = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
    };

    config = lib.mkIf config.azos.example.enable {
      azos.suites.base.enable = lib.mkDefault true;

      home.packages = with pkgs; [
        hello
      ];
    };
  };

  config.flake.modules.nixos.example = {
    lib,
    config,
    ...
  }: {
    options.azos.nixos-example.enable = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
    };

    config = lib.mkIf config.azos.nixos-example.enable {
    };
  };
}
