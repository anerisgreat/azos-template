{
  lib,
  config,
  pkgs,
  ...
}: let
  isEnabled =
    config.azos.virtualization.enable;
in {
  options.azos.virtualization.enable = lib.mkOption {
    default = true;
    example = true;
    type = lib.types.bool;
  };

  config = lib.mkIf isEnabled {
    virtualisation.libvirtd = {
      enable = true; # start / run libvirtd as a system service
      qemu = {
        swtpm.enable = true; # (optional) enable software TPM for guests
      };
    };
    environment.systemPackages = with pkgs; [
      qemu_kvm
      libvirt
      virt-manager
      virt-viewer
    ];

    services.spice-vdagentd.enable = true;
    networking.firewall.allowedTCPPorts = [5900 5901];
    networking.firewall.allowedUDPPorts = [5900 5901];
  };
}
