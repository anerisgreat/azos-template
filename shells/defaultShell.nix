{pkgs} @ args:
  pkgs.mkShell {
    buildInputs = with pkgs; [
      alejandra
      (pkgs.writeShellScriptBin
        "azos-update-azos-core"
        "nix flake update --flake '.?submodules=1' azos-core")
      (pkgs.writeShellScriptBin
        "azos-update"
        "nix flake update --flake '.?submodules=1'")
    ];
  }
