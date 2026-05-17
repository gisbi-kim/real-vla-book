# t6 -> t7 Action Plan

Date: 2026-05-17

## Input at t6

- `2_main/ch1/10_Real_VLA_Ch1_Section_1_6_Draft_v0_1_2026_05_17.md`
- Chapter 1 evidence map
- Chapter 1 detailed outline
- API/interface spec and glossary
- Recent public references on VLA safety, failure detection, and open challenges

## Goal at t7

Create Section 1.7 draft:

- File: `2_main/ch1/11_Real_VLA_Ch1_Section_1_7_Draft_v0_1_2026_05_17.md`
- Section title: `Data, Evaluation, and Safety as System Layers`

## Required Claims

1. A Real VLA claim cannot be established from model architecture alone.
2. Robot data does not scale like web text or image data because embodiment, action representation, controller wrappers, safety filters, reset policy, and interventions all affect the meaning of a trajectory.
3. Benchmark success is not equivalent to robot capability unless the evaluation protocol names the task distribution, perturbations, safety events, interventions, and failure taxonomy.
4. Safety is a stack property, spanning semantic intent, geometric feasibility, dynamic limits, runtime monitoring, data governance, and human intervention.

## Planned Structure

1. Why data/evaluation/safety belong in Chapter 1, not as appendices.
2. Data engine as a system layer.
3. Benchmark VLA versus Real VLA System.
4. Safety as a layered responsibility.
5. Why Ch14, Ch16, and Ch19 are core chapters.
6. Bridge to Section 1.8 reading protocol.

## Required Insertions

- Table 1.6: Model-only VLA versus Real VLA System.
- Box 1.4: Benchmark success is not robot capability.
- Figure 1.4 placeholder: failure modes by layer.
- Mug/drying-rack running example decomposed by success, safety, intervention, recovery, and distribution shift.

## Acceptance Gate

- Uses the same `a_t` / `u_t` boundary from Section 1.4.
- Does not overclaim current benchmarks as full real-world capability tests.
- Treats recent safety/failure-detection work as evidence for the need for runtime and evaluation layers, not as solved deployment safety.
- Ends with a clean transition to Section 1.8.
