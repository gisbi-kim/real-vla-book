# t21 -> t22 Action Plan: Chapter 7 RL, Optimal Control, and Control as Inference

## Goal

Write Chapter 7 of the Korean LaTeX book and rebuild the integrated `main.pdf`.

## Chapter scope

Chapter 7 should explain reinforcement learning, optimal control, and control as inference as the mathematical language for reward, cost, constraint, uncertainty, and action distributions in VLA systems.

## Required content

- Define MDP/POMDP-style RL formulation for language-conditioned robot policies.
- Explain return, value, Q function, Bellman relation, and policy optimization.
- Formalize finite-horizon optimal control and connect it to MPC/controller layers.
- Explain constraints and safe optimization.
- Introduce maximum entropy RL and control as probabilistic inference.
- Connect these ideas to diffusion/flow/action-distribution VLA, offline robot data, reward models, success detectors, and real-robot safety.

## Output artifacts

- `4_latex_book/chapters/chapter07.tex`
- Update `4_latex_book/main.tex` to include Chapter 7.
- Rebuild `4_latex_book/build/main.pdf` with Docker XeLaTeX.
- Send Slack update to `#진행상황-ping` after successful build.

## Acceptance check

- Docker build exits successfully.
- `main.pdf` exists and page count is verified.
- The chapter contains equations and tables suitable for a KAIST-level robotics course.
