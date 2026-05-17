# Real VLA Book

**Real VLA: 로봇공학자의 관점에서 본 Vision-Language-Action**

This repository contains a Korean technical book manuscript on Vision-Language-Action systems from a roboticist's perspective. The book frames Real VLA not as a larger VLM, but as a system contract connecting language-conditioned perception, learned action, state estimation, control, data engines, evaluation, real-time execution, and safety assurance.

## Current Artifact

- Final PDF: [`4_latex_book/build/main.pdf`](4_latex_book/build/main.pdf)
- LaTeX entry point: [`4_latex_book/main.tex`](4_latex_book/main.tex)
- Chapter sources: [`4_latex_book/chapters/`](4_latex_book/chapters/)
- Goal-loop revision logs: [`3_goal_loop/`](3_goal_loop/)

## Build

The manuscript is built with XeLaTeX in Docker:

```powershell
docker run --rm -v "${PWD}:/work" -w /work/4_latex_book texlive/texlive:latest latexmk -xelatex -interaction=nonstopmode -file-line-error -outdir=build main.tex
```

The expected page size is `170mm x 240mm`.

## Manuscript Structure

- Chapter 0: book intent, system contract, evidence tier
- Part I: Real VLA stack
- Part II: learning foundations
- Part III: from planner to VLA
- Part IV: deployment evidence
- Part V: beyond manipulation
- Chapter 21: synthesis, review questions, core propositions
- Chapter 22: future directions

## Status

The latest local build was verified with:

- Docker XeLaTeX rebuild
- no undefined citations
- no Overfull hbox reports
- all pages at `170mm x 240mm`

