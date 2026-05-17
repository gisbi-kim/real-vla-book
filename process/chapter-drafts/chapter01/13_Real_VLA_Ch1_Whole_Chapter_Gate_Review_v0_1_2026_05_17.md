# Real VLA Chapter 1 - Whole Chapter Gate Review v0.1

Date: 2026-05-17

## Scope

This review covers the current Chapter 1 section drafts:

- 1.1 Why Real VLA Is Not Just a Bigger VLM
- 1.2 From Language Goal to Motor Command
- 1.3 The Five-Layer Real VLA Stack
- 1.4 Interface Contracts: Observation, State, Action, and Control
- 1.5 Historical Convergence
- 1.6 Modern System Patterns
- 1.7 Data, Evaluation, and Safety as System Layers
- 1.8 Failure Modes and the Roboticist's Reading Protocol

## Gate Verdict

Chapter 1 is ready for first assembly, with cleanup rules applied during assembly.

The conceptual spine is stable:

> Real VLA is not a bigger VLM or a controller replacement. It is an embodied responsibility stack that turns language-conditioned perception into physically executed, monitored, evaluated robot behavior.

The chapter now has enough material for an integrated v0.1. The next loop should assemble the chapter rather than patch individual section files.

## What Works

1. **Thesis continuity is strong.**  
   Sections 1.1 through 1.8 repeatedly return to the same claim: VLA policy output is only one layer in a robot system. This prevents the chapter from becoming a survey of model names.

2. **The running mug/drying-rack example works.**  
   It appears in 1.1, becomes an execution path in 1.2, becomes layered responsibility in 1.3, becomes interface notation in 1.4, and becomes evaluation/failure protocol in 1.7 and 1.8.

3. **The `a_t` / `u_t` boundary is now visible.**  
   This gives Chapter 13 a clean handoff and prevents action representation from being treated as a superficial output-format issue.

4. **Data/evaluation/safety are no longer appendices.**  
   Sections 1.7 and 1.8 correctly make them system layers and reading-protocol components.

5. **The chapter has a practical payoff.**  
   Checklist 1.1 gives readers a concrete way to read VLA papers: backbone, action representation, data source, control interface, evaluation protocol, safety/deployment evidence.

## Required Assembly Cleanup

### 1. Remove process blocks

The assembled chapter should not include:

- `## Citation Placeholders for Later Integration`
- draft notes such as `It includes...`
- gate-review history
- acceptance-gate commentary
- "official sources were checked before drafting" process notes

Citation placeholders can be retained only as inline bracket markers or converted into a final reference plan at the end of the assembled file.

### 2. Harmonize figure/table/box numbering

Current useful elements:

- Box 1.1: VLA is not a controller replacement
- Box 1.2: ER layer vs VLA policy layer
- Box 1.3: Why action representation is a control boundary
- Box 1.4: Benchmark success is not robot capability
- Figure 1.1: Real VLA System Stack
- Figure 1.2: Observation/action/control interface path
- Figure 1.3: Historical convergence map
- Figure 1.4: Failure modes by layer
- Figure 1.5: Chapter 1 dependency map
- Table 1.1: Real VLA stack responsibilities
- Table 1.2: Historical ingredients and VLA contribution
- Table 1.3: Modern system pattern matrix
- Table 1.6: Model-only VLA versus Real VLA System
- Table 1.7: Failure mode by layer
- Checklist 1.1: Six questions for reading a VLA paper

Blocking issue: Table numbering jumps from 1.3 to 1.6. During assembly, either:

- keep the outline's numbering and add `Table 1.4` / `Table 1.5` placeholders if they are planned elsewhere, or
- renumber Section 1.7 and 1.8 tables sequentially as Table 1.4 and Table 1.5.

Recommended for v0.1 assembly: renumber sequentially inside Chapter 1 for readability.

### 3. Merge repeated failure-map material

Section 1.7 currently has Figure 1.4 failure modes by layer. Section 1.8 has Table 1.7 failure mode by layer.

Recommended integration:

- Keep Section 1.7's failure-mode figure as a conceptual map.
- Keep Section 1.8's table as the final reading rubric.
- In Section 1.8, avoid restating the entire safety gate chain; refer back to 1.7.

### 4. Smooth language transitions

The assembled chapter should add short bridge sentences:

- 1.2 to 1.3: from execution path to named stack.
- 1.3 to 1.4: from layer responsibility to interface contracts.
- 1.4 to 1.5: from notation to historical lineage.
- 1.5 to 1.6: from history to modern patterns.
- 1.6 to 1.7: from system landscape to evidence requirements.
- 1.7 to 1.8: from evidence requirements to reading protocol.

### 5. Control citation density

Several section drafts include many `[CITATION: ...]` markers. The assembled chapter should not read like a bibliography dump.

Recommended rule:

- Keep only citation markers attached to claims that need evidence.
- Move source clusters that are only planning notes to a `Reference Plan` section.
- Use Section 1.6 and 1.7 source markers cautiously because they involve current systems and may drift.

## Integration Rules for t9 -> t10

1. Create `14_Real_VLA_Ch1_Assembled_Draft_v0_1_2026_05_17.md`.
2. Preserve the section order 1.1 through 1.8.
3. Strip all process-only blocks.
4. Renumber tables sequentially unless a stronger existing book convention is found.
5. Keep the chapter in polished prose, not a planning document.
6. Keep citation markers lightweight and consolidate detailed source planning at the end.
7. End with the final Chapter 1 handoff to Chapter 13, Chapter 14, Chapter 16, and Chapter 19.

## Next Action

Proceed to `t9 -> t10`: assemble Chapter 1 v0.1 from the eight section drafts using the cleanup rules above.
