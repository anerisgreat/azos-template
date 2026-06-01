{inputs, ...}: {
  config.flake.overlays.modifications = _final: _prev: {
  };

  config.flake.overlays.unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
