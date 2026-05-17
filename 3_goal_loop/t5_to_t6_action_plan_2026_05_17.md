# Real VLA Goal Loop: t5 -> t6 Action Plan

**Date:** 2026-05-17 KST  
**Goal loop state:** t5 input -> t6 output  
**Current input artifact:** `2_main/ch1/9_Real_VLA_Ch1_Section_1_5_Draft_v0_1_2026_05_17.md`  
**Planning basis:** `2_main/ch1/2_Real_VLA_Ch1_Detailed_Outline_v0_1_2026_05.md` Section 1.6  
**Freshness check:** Official pages checked on 2026-05-17 KST for Gemini Robotics-ER 1.6, Gemini Robotics, NVIDIA Isaac GR00T N1.7, and Figure Helix 02.  
**Planned output artifact:** `2_main/ch1/10_Real_VLA_Ch1_Section_1_6_Draft_v0_1_2026_05_17.md`

## t5 State

Section 1.5 explains VLA as historical convergence rather than a sudden model family. The next step is to use that lens to read modern systems as responsibility patterns.

## t6 Action

Draft Section 1.6, **"Modern System Patterns: Model-only VLA, ER + VLA, and Humanoid Deployment."**

The section should compare modern systems by stack pattern, not leaderboard rank.

## Required Moves

1. Discuss Robotics Transformer / OpenVLA-style VLA policy pattern.
2. Discuss action-distribution pattern: diffusion, flow, tokenization, fine-tuning.
3. Discuss ER + VLA orchestration pattern using Gemini Robotics-ER and Gemini Robotics as disciplined examples.
4. Discuss humanoid / whole-body deployment pattern using GR00T N1.7 and Figure Helix 02 as case studies.
5. Explicitly state what these systems show and what they do not prove.
6. End by bridging to Section 1.7, where data, evaluation, and safety become core system layers.

## Freshness Notes

- Gemini Robotics-ER 1.6 is treated as embodied reasoning / high-level reasoning, not as the default lower-level action-producing VLA policy.
- Gemini Robotics 1.5 is treated as the Google DeepMind VLA case.
- GR00T N1.7 is treated as open humanoid/generalist VLA stack case, with release/benchmark maturity caveats.
- Figure Helix 02 is treated as a company case study for whole-body autonomy, not as peer-reviewed proof of general robotics.

## Acceptance Criteria

- The new Section 1.6 draft exists as Markdown.
- It includes a modern system pattern matrix.
- It avoids treating latest demos as settled science.
- It preserves Ch1 scope and defers technical details to Ch13, Ch15, Ch17, Ch19, and Ch20.
