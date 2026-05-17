# Real VLA Goal Loop: t4 -> t5 Action Plan

**Date:** 2026-05-17 KST  
**Goal loop state:** t4 input -> t5 output  
**Current input artifact:** `2_main/ch1/8_Real_VLA_Ch1_Section_1_4_Draft_v0_1_2026_05_17.md`  
**Planning basis:** `2_main/ch1/2_Real_VLA_Ch1_Detailed_Outline_v0_1_2026_05.md` Section 1.5  
**Historical basis:** `0_기획/step0_1_vla_history_curriculum_2026_05.md`  
**Planned output artifact:** `2_main/ch1/9_Real_VLA_Ch1_Section_1_5_Draft_v0_1_2026_05_17.md`

## t4 State

Section 1.4 defines the interface contracts around observation/state, `a_t`/`u_t`, frame, rate, horizon, and controller metadata. The next step is to explain why these interface problems are not new accidents of VLA, but the result of historical convergence.

## t5 Action

Draft Section 1.5, **"Historical Convergence: Control, Planning, Robot Learning, and VLM/LLM."**

The section should convert history into concept lineage, not paper chronology.

## Required Moves

1. Explain that VLA is not a sudden model family but a convergence of older robotics and newer foundation-model streams.
2. Map control/estimation to stable execution and feedback.
3. Map planning/TAMP to goal structure, constraints, feasibility, and recovery.
4. Map robot learning to perception-to-action before language grounding.
5. Map VLM/LLM to semantics, language, common sense, and partial grounding.
6. Explain that VLA adds action representation, data scaling, and foundation-model semantics, but does not erase the old problems.
7. End by bridging to Section 1.6, where modern systems are read as system patterns rather than leaderboards.

## Scope Control

Do not create a full chronological survey.

Do not over-explain each classic paper.

Do not imply that classical methods are merely background.

Do not imply that LLM/VLM bridge systems are obsolete; they are ancestors and still active components in hierarchical VLA.

## Acceptance Criteria

- The new Section 1.5 draft exists as Markdown.
- It contains Figure 1.3 as a text placeholder or described figure.
- It includes a compact historical-ingredient table.
- It uses the mug example as an anchor without repeating earlier sections.
- It ends with a bridge to Section 1.6.
