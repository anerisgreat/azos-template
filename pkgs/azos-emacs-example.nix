{
  orgTrivialBuild,
  epkgs,
  pkgs,
}:
orgTrivialBuild {
  pname = "azos-emacs-lauretta";
  version = "0.1.6";
  src = ./elisp/azos-emacs-example.org;
  packageRequires = with epkgs; [
    pkgs.azos-emacs-base
    #More macs packages here
  ];
}
