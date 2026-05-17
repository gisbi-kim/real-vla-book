# t7 -> t8 Action Plan

Date: 2026-05-17

## Input at t7

- `2_main/ch1/11_Real_VLA_Ch1_Section_1_7_Draft_v0_1_2026_05_17.md`
- Chapter 1 detailed outline section 1.8
- Chapter 1 evidence map
- Wave 1 chapter contracts
- Interface glossary and API spec

## Goal at t8

Create Section 1.8 draft:

- File: `2_main/ch1/12_Real_VLA_Ch1_Section_1_8_Draft_v0_1_2026_05_17.md`
- Section title: `Failure Modes and the Roboticist's Reading Protocol`

## Required Claims

1. Failure-mode analysis is not pessimism; it is how robotics defines competence.
2. VLA failures often occur at interfaces between layers, not only inside the model.
3. A VLA paper should be read through six questions: backbone, action representation, data source, control interface, evaluation protocol, and safety/deployment evidence.
4. Chapter 1 locks the vocabulary and contracts that later chapters will refine.

## Planned Structure

1. Re-open the mug/drying-rack example as a reading-protocol test.
2. Table 1.7: failure mode by layer.
3. Checklist 1.1: six questions for reading a VLA paper.
4. Figure 1.5: Ch1 dependency map to Ch13, Ch14, Ch16, and Ch19.
5. Final Chapter 1 handoff.

## Required Insertions

- Table 1.7: failure mode by layer.
- Checklist 1.1: six questions for reading a VLA paper.
- Figure 1.5 placeholder: Chapter 1 dependency map.
- Explicit handoff to Ch13 action representations, Ch14 data engine, Ch16 evaluation, and Ch19 safety/deployment.

## Acceptance Gate

- Does not read like hype or a broad conclusion.
- Produces a practical reading rubric usable on real VLA papers.
- Keeps Section 1.8 aligned with the `a_t` / `u_t` boundary and five-layer stack.
- Closes Chapter 1 without prematurely claiming deployment safety or universal robot generality.
