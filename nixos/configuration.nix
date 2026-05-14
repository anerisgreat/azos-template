{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./lauretta-hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    outputs.nixosModules
    outputs.azos-core.nixosModules
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs = {
    overlays = [
      inputs.azos-core.overlays.addpkgs
      outputs.overlays.addpkgs
      inputs.azos-core.overlays.qutebrowserdrm
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  nix.nixPath = ["/etc/nix/path"];

  networking.hostName = "lauretta"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jerusalem";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IL";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "he_IL.UTF-8";
    LC_IDENTIFICATION = "he_IL.UTF-8";
    LC_MEASUREMENT = "he_IL.UTF-8";
    LC_MONETARY = "he_IL.UTF-8";
    LC_NAME = "he_IL.UTF-8";
    LC_NUMERIC = "he_IL.UTF-8";
    LC_PAPER = "he_IL.UTF-8";
    LC_TELEPHONE = "he_IL.UTF-8";
    LC_TIME = "he_IL.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us,il";
      variant = "";
    };
    xkb.options = "grp:alt_shift_toggle";
  };

  # Configure console keymap
  console.keyMap = "il";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.aner = {
    isNormalUser = true;
    description = "Aner Zakobar";
    #Audio group for audio config, video group necessary for backlight.
    extraGroups = ["networkmanager" "wheel" "audio" "video"];
    packages = with pkgs; [];
  };

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs pkgs;};
    users = {
      aner = import ../home-manager/home.nix;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    git
    tmux
    killall
  ];

  fonts.enableDefaultPackages = true;

  services.upower.enable = true;
  programs.light.enable = true;

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  system.stateVersion = "25.11"; # Did you read the comment?
}
