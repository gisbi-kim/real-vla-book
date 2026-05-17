# Real VLA Goal Loop: t2 -> t3 Action Plan

**Date:** 2026-05-17 KST  
**Goal loop state:** t2 input -> t3 output  
**Current input artifact:** `2_main/ch1/6_Real_VLA_Ch1_Section_1_2_Draft_v0_1_2026_05_17.md`  
**Planning basis:** `2_main/ch1/2_Real_VLA_Ch1_Detailed_Outline_v0_1_2026_05.md` Section 1.3  
**Interface basis:** `1_Book Bible v0.1/4_Real_VLA_Interface_Spec_and_Global_Glossary_v0_1_2026_05.md`  
**Planned output artifact:** `2_main/ch1/7_Real_VLA_Ch1_Section_1_3_Draft_v0_1_2026_05_17.md`

## t2 State

Section 1.2 defines the execution path from language goal to motor command. It shows that instruction becomes task semantics, subgoal/constraint bundle, policy-level action `a_t`, safety decision, controller command `u_t`, and execution feedback.

## t3 Action

Draft Section 1.3, **"The Five-Layer Real VLA Stack."**

The section should formalize the execution path from Section 1.2 into five responsibility layers:

1. Embodied Reasoning Layer
2. VLA Policy Layer
3. Motion/Control Layer
4. Safety/Assurance Layer
5. Data/Evaluation Layer

## Required Moves

1. Define the stack as a conceptual accountability stack, not a mandatory modular implementation.
2. Reuse the mug/drying-rack/glass example and assign each responsibility to the proper layer.
3. Include a text version of Table 1.1 or Table 1.2 with input, output, responsibility, and common failure.
4. Clarify the layer-merging rule: one model may implement multiple responsibilities, but success in one layer does not guarantee success in another.
5. Keep action taxonomy shallow and defer detailed action representation trade-offs to Ch13.
6. End by bridging to Section 1.4, where observation/state and `a_t`/`u_t` interface contracts become more formal.

## Scope Control

Do not expand into full Ch2 state-estimation theory.

Do not expand into full Ch13 action representation taxonomy.

Do not expand into full Ch14/Ch16/Ch19 treatment of data, evaluation, and safety. Introduce them only as stack layers.

## Acceptance Criteria

- The new Section 1.3 draft exists as Markdown.
- It contains the five-layer stack definition.
- It includes a compact table-like block.
- It explicitly states that layers are responsibility boundaries, not necessarily code modules.
- It ends with a clean bridge to Section 1.4.
