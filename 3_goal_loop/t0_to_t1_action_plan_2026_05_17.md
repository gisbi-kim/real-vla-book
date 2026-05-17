# Real VLA Goal Loop: t0 -> t1 Action Plan

**Date:** 2026-05-17 KST  
**Goal loop state:** t0 input -> t1 output  
**Current input artifact:** `2_main/ch1/3_Real_VLA_Ch1_Section_1_1_Draft_v0_1_2026_05.md`  
**Review artifact:** `2_main/ch1/4_1.1_gate_review.txt`  
**Planned output artifact:** `2_main/ch1/5_Real_VLA_Ch1_Section_1_1_Draft_v0_2_2026_05_17.md`

## t0 State

Section 1.1 v0.1 is conceptually strong and passes the gate review, but the gate review recommends a lightweight v0.2 patch before moving to Section 1.2.

The draft already establishes the book's central framing:

> Real VLA is not a bigger VLM or a controller replacement. It is an embodied system interface connecting task semantics, VLA policy, physical control, safety, data, and evaluation.

## t1 Action

Create `Section 1.1 v0.2` without rewriting the section from scratch.

The patch must:

1. Preserve the opening mug example and the core thesis.
2. Add citation placeholders where the draft makes strong claims.
3. Clarify that Real VLA layers are functional responsibilities, not necessarily separate modules.
4. Clarify the ER layer vs VLA policy layer boundary.
5. Clarify policy-level action `a_t` vs low-level control command `u_t`.
6. Strengthen the benchmark/evaluation/safety claim with citation placeholders.
7. Strengthen the bridge into Section 1.2 by previewing Figure 1.1 and Table 1.1.

## Scope Control

Do not expand into Chapter 13's detailed action taxonomy. Mention action token, waypoint, delta pose, action chunk, diffusion, and flow only as examples of the policy/control boundary.

Do not expand into Chapter 16 or Chapter 19. Evaluation and safety are introduced only as Real VLA stack responsibilities.

Do not convert this interim draft to DOCX yet. The DOCX pass should happen after a full Chapter 1 section group is stable.

## Acceptance Criteria

- The new v0.2 file exists.
- v0.1 remains untouched.
- The section still reads as a coherent opening section, not as a patch log.
- Citation placeholders are collected in a dedicated section at the end.
- The next action plan can be derived directly from the t1 output.
