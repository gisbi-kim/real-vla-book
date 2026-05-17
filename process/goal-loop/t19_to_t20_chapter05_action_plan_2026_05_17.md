# t19 -> t20 Action Plan: Chapter 5 Planning, Motion Planning, and TAMP

## Goal

Write Chapter 5 of the Korean LaTeX book and rebuild the integrated `main.pdf`.

## Chapter scope

Chapter 5 connects classical planning, motion planning, and task-and-motion planning to Real VLA systems. The chapter should treat planning as a current engineering layer, not historical background.

## Required content

- Define task planning, motion planning, and TAMP as distinct but coupled problems.
- Formalize a symbolic planning problem with states, actions, preconditions, effects, initial state, and goal.
- Explain search and heuristic cost at a useful engineering level.
- Formalize motion planning in configuration space with collision-free constraints.
- Cover sampling-based planning and trajectory optimization at the level needed for VLA integration.
- Explain TAMP as coupling symbolic decisions with continuous parameters such as grasp, pose, path, and timing.
- Connect LLM/VLM/VLA planners to feasibility checking, affordance scoring, recovery, and data logging.

## Output artifacts

- `4_latex_book/chapters/chapter05.tex`
- Update `4_latex_book/main.tex` to include Chapter 5.
- Rebuild `4_latex_book/build/main.pdf` with Docker XeLaTeX.
- Send Slack update to `#진행상황-ping` after successful build.

## Acceptance check

- Docker build exits successfully.
- `main.pdf` exists and page count is verified.
- The chapter contains equations and tables suitable for a KAIST-level robotics course.
