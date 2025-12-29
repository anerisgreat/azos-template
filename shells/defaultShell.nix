{pkgs} @ args:
  pkgs.mkShell {
    buildInputs = with pkgs; [
        ( pkgs.writeShellScriptBin
                "azos-update-azos-core"
                "nix flake update azos-core" )
        ( pkgs.writeShellScriptBin
                "azos-update"
                "nix flake update" )
    ];
  }
