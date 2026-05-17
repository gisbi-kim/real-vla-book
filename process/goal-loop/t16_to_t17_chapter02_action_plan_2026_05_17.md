# t16 -> t17 Action Plan: Chapter 2 LaTeX Draft

Date: 2026-05-17

## Input

- `4_latex_book/main.tex`
- `4_latex_book/chapters/chapter01.tex`
- Book Bible 21-chapter map
- Global interface notation from Chapter 1

## Goal

Create Chapter 2 as a real LaTeX chapter and rebuild the main PDF.

## Chapter

- File: `4_latex_book/chapters/chapter02.tex`
- Title: `State, Dynamics, and Estimation`

## Requirements

1. Keep the chapter in Korean engineering textbook style.
2. Avoid metaphor-heavy prose.
3. Include formal notation:
   - state vs observation
   - dynamics
   - observation model
   - belief update
   - latency/time alignment
   - estimator-controller-policy interface
4. Add Chapter 2 to `main.tex`.
5. Rebuild `4_latex_book/build/main.pdf` through Docker.
6. Send Slack update after successful build.

## Acceptance Gate

- PDF builds successfully.
- Chapter 2 is not a placeholder.
- Main PDF page count increases and remains buildable.
