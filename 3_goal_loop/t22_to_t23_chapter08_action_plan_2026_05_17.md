# t22 -> t23 Action Plan: Chapter 8 Visuomotor Policies

## Goal

Write Chapter 8 of the Korean LaTeX book and rebuild the integrated `main.pdf`.

## Planning basis

Use the full chapter plan from:

- `0_기획/step0_2_comments.md`
- `1_Book Bible v0.1/1_Real_VLA_Book_Bible_v0_1_2026_05.md`

## Chapter scope

Chapter 8 explains visuomotor policies as the direct image-to-action lineage before language-conditioned VLA. The chapter should avoid a high-level survey style and focus on what changes when a robot policy is conditioned on visual observation, proprioception, history, and task signal.

## Required content

- Define visuomotor policy and observation-action mapping.
- Explain why visual state is partial and temporally delayed.
- Formalize image/proprioception/history-conditioned policy.
- Discuss closed-loop servoing, temporal memory, recurrent policies, attention, and transformer policy.
- Cover real-robot grasping, pushing, reaching, insertion, and bimanual action chunks as examples.
- Connect visuomotor policies to VLA: language adds task conditioning, but image-to-action deployment problems remain.
- Include failure modes and evaluation metadata.

## Output artifacts

- `4_latex_book/chapters/chapter08.tex`
- Update `4_latex_book/main.tex` to include Chapter 8.
- Rebuild `4_latex_book/build/main.pdf` with Docker XeLaTeX.
- Send Slack update to `#진행상황-ping` after successful build.

## Acceptance check

- Docker build exits successfully.
- `main.pdf` exists and page count is verified.
- The chapter contains equations and tables suitable for a KAIST-level robotics course.
