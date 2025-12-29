{
  lib,
  config,
  pkgs,
  ...
}: let
  isEnabled =
    config.azos.hardware-audio.enable;
in {
  options.azos.hardware-audio.enable = lib.mkOption {
    default = true;
    example = true;
    type = lib.types.bool;
  };

  config = lib.mkIf isEnabled {
    services = {
      pipewire = {
        enable = true;
         audio.enable = true;
         pulse.enable = true;
         alsa = {
          enable = true;
          support32Bit = true;
         };
        jack.enable = true;
      };
    };
    # hardware.pulseaudio.enable = true;
    environment.systemPackages = with pkgs; [pavucontrol];
    musnix.enable = true;
  };
}
