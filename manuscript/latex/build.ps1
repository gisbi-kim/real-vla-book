$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "../..")

docker run --rm `
  -v "${RepoRoot}:/work" `
  -w /work/manuscript/latex `
  texlive/texlive:latest `
  latexmk -xelatex -interaction=nonstopmode -file-line-error -outdir=build main.tex
