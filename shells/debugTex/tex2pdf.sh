#!/bin/bash
# emacs --batch --eval "(progn (require 'azos-emacs-editor) (require 'ox-latex ))"
latexmk -xelatex -shell-escape -interaction=nonstopmode -output-directory=. test.tex;
latexmk -c test.tex;
