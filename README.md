# Real VLA Book

**Real VLA: 로봇공학자의 관점에서 본 Vision-Language-Action**

[![Download PDF](https://img.shields.io/badge/Download-real--vla--book.pdf-0B4F8A?style=for-the-badge&logo=adobeacrobatreader&logoColor=white)](https://github.com/gisbi-kim/real-vla-book/raw/main/dist/real-vla-book.pdf)

This repository contains a Korean technical book manuscript on Vision-Language-Action systems from a roboticist's perspective. The book frames Real VLA not as a larger VLM, but as a system contract connecting language-conditioned perception, learned action, state estimation, control, data engines, evaluation, real-time execution, and safety assurance.

## For Readers

- Landing page: [`index.html`](index.html)
- Final PDF: [`dist/real-vla-book.pdf`](dist/real-vla-book.pdf)
- Direct download: [`real-vla-book.pdf`](https://github.com/gisbi-kim/real-vla-book/raw/main/dist/real-vla-book.pdf)

## Repository Layout

```text
dist/
  real-vla-book.pdf          # reader-facing compiled book

assets/
  real-vla-cover.png         # cover image used by the landing page

manuscript/
  latex/                     # buildable LaTeX manuscript source
    main.tex
    chapters/
    build.ps1

process/
  planning/                  # early planning notes and curriculum sketches
  book-bible/                # book bible, interface specification, glossary drafts
  chapter-drafts/            # intermediate chapter drafting artifacts
  goal-loop/                 # iterative action plans and revision logs
```

The reader-facing artifact is in `dist/`. The `process/` directory is kept for provenance and revision history, not as the primary reading path.

## Manuscript Structure

- Chapter 0: book intent, system contract, evidence tier, VLA history timeline
- Part I: Real VLA stack, including state, perception, control, contact, and planning
- Part II: learning foundations
- Part III: from planner to VLA
- Part IV: deployment evidence
- Part V: beyond manipulation
- Chapter 22: synthesis, review questions, core propositions
- Chapter 23: future directions

## Build

The manuscript is built with XeLaTeX in Docker:

```powershell
powershell -ExecutionPolicy Bypass -File .\manuscript\latex\build.ps1
```

Equivalent command from the repository root:

```powershell
docker run --rm -v "${PWD}:/work" -w /work/manuscript/latex texlive/texlive:latest latexmk -xelatex -interaction=nonstopmode -file-line-error -outdir=build main.tex
```

The build output is `manuscript/latex/build/main.pdf`. The published reader-facing copy is `dist/real-vla-book.pdf`.

The expected page size is `170mm x 240mm`.

## Status

The latest local build was verified with:

- Docker XeLaTeX rebuild
- no undefined citations
- no Overfull hbox reports
- all pages at `170mm x 240mm`
