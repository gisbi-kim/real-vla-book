# Real VLA Goal Loop: t1 -> t2 Action Plan

**Date:** 2026-05-17 KST  
**Goal loop state:** t1 input -> t2 output  
**Current input artifact:** `2_main/ch1/5_Real_VLA_Ch1_Section_1_1_Draft_v0_2_2026_05_17.md`  
**Planning basis:** `2_main/ch1/2_Real_VLA_Ch1_Detailed_Outline_v0_1_2026_05.md` Section 1.2  
**Interface basis:** `1_Book Bible v0.1/4_Real_VLA_Interface_Spec_and_Global_Glossary_v0_1_2026_05.md`  
**Planned output artifact:** `2_main/ch1/6_Real_VLA_Ch1_Section_1_2_Draft_v0_1_2026_05_17.md`

## t1 State

Section 1.1 v0.2 separates Real VLA from model-only VLA framing and introduces the core boundary:

- ER layer structures intent, constraints, and success conditions.
- VLA policy layer proposes policy-level action `a_t`.
- Motion/control layer converts the proposal into physically trackable command `u_t`.
- Safety and data/evaluation are part of the execution path, not appendices.

## t2 Action

Draft Section 1.2, **"From Language Goal to Motor Command."**

The section should convert the conceptual distinction from Section 1.1 into a concrete execution path using the mug example:

```text
instruction -> subgoal/constraint -> action proposal -> safety check -> controller command -> execution feedback
```

## Required Moves

1. Start from the same mug/drying-rack/glass example.
2. Show that language instruction is task semantics, not action.
3. Separate subgoal from action.
4. Separate policy-level action `a_t` from controller command `u_t`.
5. Introduce safety and feedback as part of the path.
6. Include **Box 1.2. ER layer vs VLA policy layer**.
7. Keep Figure 1.1 as a described figure placeholder rather than drawing it.
8. End by bridging to Section 1.3, where the five-layer Real VLA stack will be formally named.

## Scope Control

Do not turn Section 1.2 into a full Ch13 action taxonomy.

Do not deeply explain planning/TAMP algorithms. Use planning only to show that language goals require structure, constraints, and recovery.

Do not deeply explain safety taxonomy. State that safety can attach to instruction, plan, action, command, execution, and data logs, then defer details to Ch19.

## Acceptance Criteria

- The new Section 1.2 draft exists as Markdown.
- The section reads as a continuation of Section 1.1 v0.2.
- It contains the execution path and Box 1.2.
- Citation placeholders are collected at the end.
- It ends with a clear bridge to Section 1.3.
