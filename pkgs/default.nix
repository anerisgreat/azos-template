{pkgs} @ args: let
  inherit args;
  localEmacsPkg = pkgs.localEmacsPkg;
in {
  azos-emacs-example = localEmacsPkg ./azos-emacs-example.nix;
}
