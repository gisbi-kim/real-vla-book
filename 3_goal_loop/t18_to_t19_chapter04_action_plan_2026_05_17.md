# t18 -> t19 Action Plan: Chapter 4 Contact, Force, and Manipulation

## Goal

Write Chapter 4 of the Korean LaTeX book and rebuild the integrated `main.pdf`.

## Chapter scope

Chapter 4 must explain contact as the central physical difficulty of manipulation VLA systems. The chapter should avoid a literary treatment and instead use robotics notation for contact mode, force, friction, compliance, grasp stability, tactile sensing, and safety limits.

## Required content

- Define contact-rich manipulation in the Real VLA stack.
- Distinguish geometric action success from contact success.
- Formalize contact mode, contact force, normal/tangential decomposition, and friction cone constraints.
- Explain hybrid position/force control and its relation to VLA-generated targets.
- Explain impedance/admittance at the chapter level without duplicating Chapter 3.
- Cover grasp closure, slip, tactile/force feedback, insertion/pushing/opening examples.
- Specify failure modes and minimum evaluation metadata for contact-rich VLA experiments.

## Output artifacts

- `4_latex_book/chapters/chapter04.tex`
- Update `4_latex_book/main.tex` to include Chapter 4.
- Rebuild `4_latex_book/build/main.pdf` with Docker XeLaTeX.
- Send Slack update to `#진행상황-ping` after successful build.

## Acceptance check

- Docker build exits successfully.
- `main.pdf` exists and page count is verified.
- The chapter contains equations and tables suitable for a KAIST-level robotics course.
