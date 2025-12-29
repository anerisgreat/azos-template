{
  lib,
  config,
  pkgs,
  ...
}: let
  isEnabled =
    config.azos.bluetooth.enable;
in {
  options.azos.bluetooth.enable = lib.mkOption {
    default = true;
    example = true;
    type = lib.types.bool;
  };

  config = lib.mkIf isEnabled {
    services.blueman.enable = true;
    hardware.bluetooth.enable = true;
  };
}
