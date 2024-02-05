{ pkgs } @ args :
let
  testfile = builtins.readfile ./test.org;
in
pkgs.mkShell {
    name = "tex-debug";
    buildInputs = [
      pkgs.azos.tex
      # ((pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages (
      #       pkgs.azos.emacs.editor))
    ];
}
