# Real VLA Chapter 1 - Section 1.8 Draft v0.1

Date: 2026-05-17

## 1.8 Failure Modes and the Roboticist's Reading Protocol

Chapter 1 began with a simple warning: a VLA model is not automatically a Real VLA system. The difference is not philosophical. It shows up when the robot fails.

Return one last time to the running task:

> "Put the mug on the drying rack without touching the glass."

If the robot fails, the failure may not be caused by a single bad token, a single wrong visual feature, or a single poor controller gain. The instruction may have been underspecified. The scene state may have been estimated incorrectly. The policy may have produced an action at the wrong granularity. The controller may not have been able to track the policy-level action. The safety monitor may have reacted too late. The evaluation protocol may have hidden the failure by counting only final mug placement.

This is why failure-mode analysis is not pessimism. In robotics, failure analysis is how competence is defined. A robot system is not mature because it never fails in a benchmark video. It is mature when its failures can be localized, measured, mitigated, and used to improve the next system.

### 1.8.1 Layer-by-Layer Failure Modes

The five-layer Real VLA stack gives us a practical failure map. Each layer has a different responsibility, and each interface can break in a different way.

#### Table 1.7. Failure Mode by Layer

| Layer | Typical responsibility | Example failure in the mug task | What to inspect |
| --- | --- | --- | --- |
| Embodied reasoning | Interpret instruction, scene, task constraints, memory, and subgoals | The system treats "without touching the glass" as a preference rather than a hard constraint | Object grounding, constraint representation, plan or subgoal trace |
| VLA policy | Map observation, language/subgoal, and proprioception to policy-level action `a_t` | The policy generates a grasp or placement action that moves too close to the glass | Action representation, temporal horizon, policy confidence, action distribution |
| Motion/control | Convert `a_t` into executable controller command `u_t` | The commanded motion is feasible in abstraction but produces overshoot or contact in execution | Controller type, frequency, tracking error, force/torque limits |
| Safety/assurance | Allow, modify, stop, recover, or request human help | The monitor detects the glass contact only after the unsafe motion is already committed | Runtime latency, stop threshold, shield placement, human override path |
| Data/evaluation | Record evidence, label failures, and define test protocol | The trial is counted as success because the mug ends on the rack, even though the glass was touched | Success criteria, intervention logs, safety event labels, randomized conditions |

The important point is that VLA failure is often an interface failure. A policy can output an action that looks reasonable in its own action space but is unsafe once passed to the controller. A controller can track a command accurately while still executing the wrong semantic intention. A benchmark can report a high success rate while hiding an unsafe contact pattern.

So when reading a VLA paper, the first question should not be "how large is the model?" The first question should be "which interface does this paper change?"

### 1.8.2 Six Questions for Reading a VLA Paper

The rest of this book will repeatedly use the following reading protocol. It is designed for roboticists who need to decide what a VLA paper actually demonstrates.

#### Checklist 1.1. Six Questions for Reading a VLA Paper

1. **What is the backbone?**  
   Is the system built from a VLM, LLM, diffusion model, transformer policy, flow model, hierarchical planner, or a hybrid architecture? Is the backbone used for semantic reasoning, policy generation, action decoding, or orchestration?

2. **What is the action representation?**  
   Does the model output discrete action tokens, Cartesian deltas, end-effector poses, waypoints, action chunks, joint targets, torque-level commands, or latent actions? At what rate are actions produced? What part is `a_t`, and what part is delegated to the controller as `u_t`?

3. **What data created the behavior?**  
   Are the data real robot trajectories, simulation rollouts, teleoperation, scripted demonstrations, human videos, synthetic data, web-scale pretraining, or mixtures of these? Are embodiment, controller, reset policy, intervention, and failure labels recorded?

4. **What control interface makes the action physical?**  
   What controller receives the policy output? Is there an impedance controller, operational-space controller, motion planner, MPC, whole-body controller, or vendor API underneath? Does the paper specify the control frequency and tracking assumptions?

5. **What evaluation protocol supports the claim?**  
   Is the result measured in simulation, real robot trials, offline prediction, benchmark tasks, long-horizon rollouts, perturbation tests, or deployment-like scenarios? Are trial counts, randomization ranges, failure categories, and statistical uncertainty visible?

6. **What safety and deployment evidence is provided?**  
   Does the system include instruction filtering, geometric checks, runtime monitors, stop/recovery behavior, human override, force limits, failure detection, audit logs, or safety-event reporting? Or is safety only discussed as future work?

These questions are deliberately concrete. They prevent a paper from being summarized as "a bigger VLA model" when the real contribution may be a new action tokenizer, a better data mixture, a stronger evaluation protocol, a hierarchical reasoning layer, or a deployment wrapper.

### 1.8.3 What Chapter 1 Locks for the Rest of the Book

Chapter 1 has fixed the vocabulary that the later chapters will rely on:

- **Real VLA system:** the full embodied stack that turns language-conditioned perception into monitored robot behavior.
- **Embodied reasoning layer:** the layer that interprets task context, constraints, memory, and subgoals.
- **VLA policy layer:** the layer that maps observations, language/subgoals, and robot state into policy-level action.
- **Action/control boundary:** the distinction between policy-level action `a_t` and low-level controller command `u_t`.
- **Safety/assurance layer:** the layer that can allow, modify, stop, recover, or ask for human help.
- **Data/evaluation layer:** the layer that records evidence and defines what a result means.

This vocabulary is not decorative. It is the contract that keeps later chapters from mixing together model architecture, action representation, controller design, data quality, benchmark design, and deployment safety.

#### Figure 1.5. Chapter 1 Dependency Map

```text
Chapter 1: Real VLA as an embodied system stack
        |
        +-- Chapter 13: Action Representations and Control Interfaces
        |       - What exactly is a_t?
        |       - How does a_t become u_t?
        |
        +-- Chapter 14: Data Engines for Real VLA
        |       - What does a robot trajectory record?
        |       - What metadata makes data reusable?
        |
        +-- Chapter 16: Evaluation Protocols
        |       - What does benchmark success mean?
        |       - What failures, shifts, and interventions are visible?
        |
        +-- Chapter 19: Safety, Assurance, and Deployment
                - Where are the safety gates?
                - How does the system stop, recover, or ask for help?
```

The dependency map also clarifies what Chapter 1 does not do. It does not give a full taxonomy of action representations; that belongs in Chapter 13. It does not solve robot data scaling; that belongs in Chapter 14. It does not define every benchmark protocol; that belongs in Chapter 16. It does not certify deployment safety; that belongs in Chapter 19.

Chapter 1 only establishes the frame:

> In this book, Real VLA is not the name of a model family. It is the name of the responsibility structure that turns language, vision, and learned action into physically executed, evaluated, and safety-monitored robot behavior.

With that frame in place, the rest of the book can study each layer without losing sight of the full robot system.
