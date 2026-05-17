# Real VLA Chapter 1 - Assembled Quality Gate v0.1

Date: 2026-05-17

## Reviewed File

- `2_main/ch1/14_Real_VLA_Ch1_Assembled_Draft_v0_1_2026_05_17.md`

## Gate Verdict

Usable as an assembled v0.1.

The draft now reads as a chapter rather than a planning memo. It has all eight planned sections, stable table numbering, stable box numbering, a working running example, and a final reading protocol.

However, it should not yet be treated as citation-ready. The next loop should add a source anchor map and a targeted citation pass rather than rewriting the prose.

## Checks

### 1. Process notes

Pass.

The assembled file no longer contains:

- `Citation Placeholders for Later Integration`
- draft acceptance-gate notes
- section-level process summaries
- "official sources were checked" notes

The only remaining planning-like element is the final `Reference Plan for Later Citation Pass`, which is acceptable for v0.1 because citation work is the next planned stage.

### 2. Structure

Pass.

The chapter contains:

- 1.1 framing problem
- 1.2 running example and execution path
- 1.3 five-layer stack
- 1.4 interface contracts
- 1.5 historical convergence
- 1.6 modern system patterns
- 1.7 data/evaluation/safety layers
- 1.8 reading protocol

The chapter closes with a clear handoff to Ch13, Ch14, Ch16, and Ch19.

### 3. Numbering

Pass with minor cleanup deferred.

Current numbering is coherent:

- Box 1.1 through Box 1.4
- Figure 1.1 through Figure 1.5
- Table 1.1 through Table 1.5
- Checklist 1.1

Minor cleanup for later: Figure captions inside code blocks may need conversion into the final book's figure style once the target format is decided.

### 4. Thesis coherence

Pass.

The chapter consistently distinguishes:

- VLM versus VLA policy
- VLA policy versus Real VLA system
- `a_t` versus `u_t`
- model architecture versus data/evaluation/safety evidence
- benchmark success versus robot capability

The chapter avoids claiming that current VLA systems solve deployment safety or general robot capability.

### 5. Evidence risk

Needs next pass.

The prose names many source families:

- RT-1, RT-2, OpenVLA
- Diffusion Policy, ACT/ALOHA, pi0, FAST, OpenVLA-OFT
- SayCan, Code as Policies, PaLM-E, VoxPoser
- Gemini Robotics-ER and Gemini Robotics
- GR00T, Figure Helix
- Open X-Embodiment, DROID, BridgeData V2
- VLA Foundry, vla-eval, BeTTER, safety/failure-detection work

Because some of these are current systems, the next step should not invent exact claims from memory. It should create a citation/source anchor file that separates:

- stable classical robotics references,
- established VLA/robot-learning papers,
- current official system pages,
- recent safety/evaluation papers that require date-sensitive handling.

## Required t11 -> t12 Output

Create:

- `3_goal_loop/t11_to_t12_action_plan_2026_05_17.md`
- `2_main/ch1/16_Real_VLA_Ch1_Source_Anchor_Map_v0_1_2026_05_17.md`

The source anchor map should not rewrite the chapter. It should map each major chapter claim to a source cluster and mark which sources still need exact bibliographic verification.

## Next Action

Proceed to `t11 -> t12`: build the source anchor map and identify the claims that require exact citation verification before publication.
