{
  inputs,
  outputs,
  suiteModules,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    suiteModules.nixos.base
    suiteModules.nixos.desktop
    suiteModules.nixos.exwm
    suiteModules.nixos.dev
    # suiteModules.nixos.example
  ];

  # Placeholders so the config evaluates before a real machine exists;
  # ./hardware-configuration.nix (nixos-generate-config) overrides both.
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  fileSystems."/" = lib.mkDefault {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs = {
    overlays = [
      outputs.overlays.addpkgs
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };

  # Must match home-manager's azos.suites.exwm.enable (udisks2 for udiskie).
  azos.suites.exwm.enable = true;

  networking.hostName = "example";
  networking.networkmanager.enable = true;

  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.user = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs suiteModules pkgs;};
    users = {
      user = import ../home-manager/home.nix;
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  system.stateVersion = "25.11";
}
