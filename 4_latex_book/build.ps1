docker run --rm `
  -v "${PWD}/..:/work" `
  -w /work/4_latex_book `
  texlive/texlive:latest `
  latexmk -xelatex -interaction=nonstopmode -file-line-error -outdir=build main.tex
