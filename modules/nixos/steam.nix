{
  lib,
  config,
  pkgs,
  ...
}: let
  isEnabled =
    config.azos.steam.enable;
in {
  options.azos.steam.enable = lib.mkOption {
    default = true;
    example = true;
    type = lib.types.bool;
  };

  config = lib.mkIf isEnabled {
    programs.steam.enable = true;
  };
}
