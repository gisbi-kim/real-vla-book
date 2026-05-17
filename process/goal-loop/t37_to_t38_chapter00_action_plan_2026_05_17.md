# t37 -> t38 Action Plan: Chapter 0

## Goal

Add a Chapter 0 that states the planning intent of the book before Chapter 1 begins.

## Rationale

The current Chapter 1 starts immediately with the definition of Real VLA. A technical book needs a preceding contract that tells the reader why this book is organized around robotics responsibilities rather than around model names, benchmark tables, or a chronological survey.

## Planned Output

- New LaTeX chapter: `4_latex_book/chapters/chapter00.tex`
- Main book update: insert Chapter 0 before Chapter 1 while preserving Chapter 1 numbering.
- Rebuild artifact: `4_latex_book/build/main.pdf`

## Chapter 0 Contract

Chapter 0 should:

1. State the thesis of the book.
2. Define the target reader and required background.
3. Explain what this book is not: not a VLM catalog, not a hype survey, not a replacement for control/planning.
4. Introduce the engineering criterion used throughout the book.
5. Explain how later chapters should be read as coupled responsibility layers.
6. Keep the tone technical and suitable for a KAIST-level engineering course.

## Verification

- Build with Docker XeLaTeX.
- Check the table of contents and first Chapter 0 pages.
- Post progress to Slack `#진행상황-ping`.
