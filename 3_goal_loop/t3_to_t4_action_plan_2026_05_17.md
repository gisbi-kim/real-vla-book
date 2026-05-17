# Real VLA Goal Loop: t3 -> t4 Action Plan

**Date:** 2026-05-17 KST  
**Goal loop state:** t3 input -> t4 output  
**Current input artifact:** `2_main/ch1/7_Real_VLA_Ch1_Section_1_3_Draft_v0_1_2026_05_17.md`  
**Planning basis:** `2_main/ch1/2_Real_VLA_Ch1_Detailed_Outline_v0_1_2026_05.md` Section 1.4  
**Interface basis:** `1_Book Bible v0.1/4_Real_VLA_Interface_Spec_and_Global_Glossary_v0_1_2026_05.md` notation table and canonical equations  
**Planned output artifact:** `2_main/ch1/8_Real_VLA_Ch1_Section_1_4_Draft_v0_1_2026_05_17.md`

## t3 State

Section 1.3 formalizes the five-layer Real VLA stack as a conceptual accountability stack. The next gap is interface precision: the reader needs stable notation for observation, state, policy-level action, controller reference, low-level command, and safety decision.

## t4 Action

Draft Section 1.4, **"Interface Contracts: Observation, State, Action, and Control."**

The section should turn the stack into a usable API:

- `o_t`: sensor observation.
- `s_t`: latent/true state.
- `q_t` / `x_t`: robot proprioception or robot state.
- `a_t`: policy-level action proposal.
- `r_t`: controller reference.
- `u_t`: low-level command.
- `A_t^{(H)}`: action chunk.

## Required Moves

1. Explain why observation is not state.
2. Explain why `a_t` is not `u_t`.
3. Introduce frame, rate, horizon, scaling, and downstream controller metadata.
4. Preview action token, continuous vector, waypoint, action chunk, diffusion/flow, and action expert only as Ch13 handoff.
5. Include Box 1.3: why action representation is a control boundary.
6. End by bridging to Section 1.5, where these interface issues become a historical convergence story.

## Scope Control

Do not derive Kalman filtering or full state-estimation theory.

Do not compare action representation algorithms in depth.

Do not make continuous actions, action tokens, diffusion, or flow sound universally superior.

## Acceptance Criteria

- The new Section 1.4 draft exists as Markdown.
- It introduces the notation without over-mathematizing Chapter 1.
- It includes Figure 1.2 as a text placeholder and Box 1.3.
- It clearly hands off action representation details to Chapter 13.
- It ends with a bridge to Section 1.5.
