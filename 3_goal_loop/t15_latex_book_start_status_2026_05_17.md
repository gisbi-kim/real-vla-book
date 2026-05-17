# Real VLA /goal LaTeX Book Start Status

Date: 2026-05-17

## Completed

- Created LaTeX book workspace: `4_latex_book/`
- Created main book entrypoint: `4_latex_book/main.tex`
- Created first chapter file: `4_latex_book/chapters/chapter01.tex`
- Added Docker build helper: `4_latex_book/build.ps1`
- Built PDF through Docker using `texlive/texlive:latest` and XeLaTeX.

## Current PDF

- `4_latex_book/build/main.pdf`
- Page count: 17 pages
- Scope: cover, table of contents, Chapter 1, build note

## Design Decision

- Korean book template based on `oblivoir`.
- Physical book-like page size: 170 mm x 240 mm.
- Chapter files are separated under `chapters/`.
- Math notation is introduced directly in Chapter 1:
  - VLA policy: `a_t = pi_theta(o_t, q_t, ell, b_t)`
  - Controller interface: `u_t = kappa(a_t, s_hat_t, C_t)`
  - Safety decision: `r_t = sigma(...)`
  - Data record and evaluation vector.

## Build Command

From `4_latex_book/`:

```powershell
.\build.ps1
```

Or from repo root:

```powershell
docker run --rm -v "${PWD}:/work" -w /work/4_latex_book texlive/texlive:latest latexmk -xelatex -interaction=nonstopmode -file-line-error -outdir=build main.tex
```

## Next Action

For the next chapter:

1. Create `4_latex_book/chapters/chapter02.tex`.
2. Add `\input{chapters/chapter02}` to `main.tex`.
3. Build `build/main.pdf` again.
4. Send Slack update to `#진행상황-ping`.
