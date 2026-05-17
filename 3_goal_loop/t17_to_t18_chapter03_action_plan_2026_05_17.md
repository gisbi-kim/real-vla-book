# t17 -> t18 Action Plan: Chapter 3 LaTeX Draft

Date: 2026-05-17

## Input

- `4_latex_book/chapters/chapter01.tex`
- `4_latex_book/chapters/chapter02.tex`
- Book Bible Chapter 3 role: Control Interfaces

## Goal

Create Chapter 3 as a real LaTeX chapter and rebuild the main PDF.

## Chapter

- File: `4_latex_book/chapters/chapter03.tex`
- Title: `Control Interfaces`

## Requirements

1. Explain why VLA output is not directly actuator command.
2. Compare common control interfaces:
   - joint position / velocity / torque
   - end-effector pose / delta pose
   - waypoint / trajectory
   - impedance and operational-space targets
   - MPC reference
3. Include formal mappings from `a_t` to `u_t`.
4. Add Chapter 3 to `main.tex`.
5. Build `main.pdf` again through Docker.
6. Send Slack update after build.

## Acceptance Gate

- PDF builds successfully.
- Chapter 3 is a substantive engineering chapter, not an outline.
