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
    # NixOS: nixos-rebuild. Anywhere else: standalone home-manager, using
    # `nix run` for the very first switch before home-manager is installed.
    # Existing dotfiles home-manager would overwrite (~/.bashrc, ~/.profile,
    # ...) are moved aside with a .hm-backup suffix instead of aborting.
    (pkgs.writeShellScriptBin "azos-switch" ''
      set -e
      if [ -e /etc/NIXOS ]; then
        exec sudo nixos-rebuild switch --flake ".?submodules=1#$(hostname)" "$@"
      fi
      if command -v home-manager >/dev/null; then
        exec home-manager switch -b hm-backup --flake '.?submodules=1' "$@"
      fi
      exec nix run --inputs-from '.?submodules=1' home-manager -- \
        switch -b hm-backup --flake '.?submodules=1' "$@"
    '')
  ];
}
