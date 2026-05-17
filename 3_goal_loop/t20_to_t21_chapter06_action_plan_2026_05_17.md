# t20 -> t21 Action Plan: Chapter 6 Imitation Learning and Covariate Shift

## Goal

Write Chapter 6 of the Korean LaTeX book and rebuild the integrated `main.pdf`.

## Chapter scope

Chapter 6 explains imitation learning as the direct learning foundation before modern VLA. It should connect behavior cloning, closed-loop distribution shift, DAgger, correction data, failure data, and VLA fine-tuning.

## Required content

- Define demonstration data and behavior cloning objective.
- Explain why open-loop imitation is not closed-loop deployment.
- Formalize covariate shift as mismatch between expert and learned policy state distributions.
- Explain compounding errors and recovery behavior.
- Introduce DAgger-style dataset aggregation.
- Discuss success-only demonstrations, failure data, human correction, intervention labels, and recovery trajectories.
- Connect these ideas to VLA action representation and data-engine design.

## Output artifacts

- `4_latex_book/chapters/chapter06.tex`
- Update `4_latex_book/main.tex` to include Chapter 6.
- Rebuild `4_latex_book/build/main.pdf` with Docker XeLaTeX.
- Send Slack update to `#진행상황-ping` after successful build.

## Acceptance check

- Docker build exits successfully.
- `main.pdf` exists and page count is verified.
- The chapter contains equations and tables suitable for a KAIST-level robotics course.
