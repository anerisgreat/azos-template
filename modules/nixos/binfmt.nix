{
  lib,
  config,
  pkgs,
  ...
}: let
  isEnabled =
    config.azos.binfmt.enable;
in {
  options.azos.binfmt.enable = lib.mkOption {
    default = true;
    example = true;
    type = lib.types.bool;
  };

  config = lib.mkIf isEnabled {
    boot.binfmt.emulatedSystems = ["aarch64-linux"];
  };
}
