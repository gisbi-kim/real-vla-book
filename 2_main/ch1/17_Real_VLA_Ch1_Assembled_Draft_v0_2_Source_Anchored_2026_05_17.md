# Chapter 1. What Is Real VLA?

Assembled draft v0.2 source-anchored  
Date: 2026-05-17

## 1.1 Why Real VLA Is Not Just a Bigger VLM

A vision-language model can look at an image and answer a question about it. A robot VLA system must do something harder: it must turn what it sees and what it is told into physical action under dynamics, contact, latency, uncertainty, and safety constraints.

This is the first boundary of the chapter. A VLM mainly learns semantic correspondence between images and text. A VLA connects vision, language, and action in a closed embodied loop. In that loop, an action is not a sentence that can simply be emitted and forgotten. It is an object that must pass through a controller, a robot body, sensors, a workspace, contact events, and safety monitors.

So it is misleading to define VLA as "a VLM with an action head." The action head matters, but the system around it matters just as much. What action format does the policy emit? Which controller receives it? What safety layer can block or modify it? Who replans when execution fails? What data record proves that the behavior happened as claimed? These questions are part of Real VLA. [Anchors: A, B, D, F, G]

The core claim of this book is:

> Real VLA is not the replacement of robotics by one large model. It is the design of interfaces that turn task semantics and embodied perception into physically executable, monitored, and evaluated robot behavior.

This viewpoint does not make classical robotics obsolete. It makes classical robotics newly relevant. Stability, constraint satisfaction, contact control, motion feasibility, state estimation, and recovery do not disappear when the VLM becomes larger. As VLA systems move closer to real robots, these issues become more visible.

### Box 1.1. VLA Is Not a Controller Replacement

A VLA policy may propose a grasp, waypoint, delta pose, action token, or action chunk. It does not automatically guarantee collision-free motion, stable contact, actuator-safe torques, or recovery from distribution shift.

For that reason, this chapter separates:

- policy-level action `a_t`, the action object proposed by a VLA policy;
- controller command `u_t`, the low-level command sent to a servo loop, robot driver, or whole-body controller.

Much of Real VLA engineering lives in this boundary.

Classical control and planning tools remain current in this boundary. Operational-space control, impedance control, MPC, trajectory optimization, TAMP, and whole-body control are not historical leftovers. They are ways of turning learned action proposals into physically interpretable motion.

Robot learning history also matters. Before modern VLA, behavior cloning, DAgger, guided policy search, visual RL, visuomotor policies, and large-scale grasping already studied image-to-action learning. VLA adds language grounding and foundation-model representation to this lineage, but it inherits data coverage, covariate shift, recovery, and embodiment mismatch problems. [Anchors: A, B, E]

This is why Real VLA is also a data, evaluation, and safety problem. Robot data is expensive, embodied, action-labeled, temporally structured, and safety-sensitive. Benchmark success is useful evidence, but it is not the same as deployment capability unless the action interface, controller, randomization, intervention policy, and failure taxonomy are visible.

## 1.2 From Language Goal to Motor Command

Consider a simple instruction:

> "Put the mug on the drying rack without touching the glass."

This sentence looks simple because humans compress many assumptions into ordinary language. A robot system must unfold it into a chain of embodied decisions.

The first transformation is from language to task semantics. "Mug" names the manipulated object. "Drying rack" defines a target relation. "Without touching the glass" is a constraint. "Put" implies a structure such as grasp, lift, transport, place, release, and verify. The instruction is not yet an action. It is a semantic description of what kinds of actions may be needed. [Anchors: C, D]

The second transformation is from task semantics to embodied reasoning. The system must identify the mug and glass, estimate their poses or affordances, reason about the drying rack, decide whether the task is feasible, and create a subgoal or plan. This may involve an LLM, VLM, embodied reasoning model, scene graph, memory, planner, or tool call. But the output of this layer is still not a motor command.

### Box 1.2. ER Layer versus VLA Policy Layer

The embodied reasoning layer asks, "What should be done, under what constraints?"  
The VLA policy layer asks, "Given the current observation and robot state, what policy-level action should be proposed next?"

These are related but not identical. A strong reasoning model may produce a good plan and still fail to produce executable robot actions. A strong VLA policy may produce local actions and still fail to understand a long-horizon constraint. Real VLA requires both roles to be placed in a system.

The third transformation is from embodied reasoning to policy-level action. The VLA policy receives observations, language or subgoal information, and robot state such as proprioception. It may output an end-effector delta, a waypoint, an action token, a short action chunk, a continuous action distribution, or another action object. This output is `a_t`.

The fourth transformation is from `a_t` to controller target and low-level command. If the VLA outputs an end-effector delta, the motion/control layer must interpret that delta with respect to robot state, coordinate frame, kinematic limits, obstacles, and control rate. The downstream controller then produces `u_t`: velocity, torque, joint position, impedance target, or whole-body command.

Safety is not a final wrapper after all of this. The glass constraint can appear at the instruction stage, plan stage, action stage, command stage, and runtime monitoring stage. The system may reject the instruction, mark a forbidden region, block an unsafe `a_t`, clamp a dangerous `u_t`, stop on unexpected contact, or ask a human for help.

Figure 1.1 summarizes the responsibility path.

```text
Figure 1.1. Real VLA System Stack

Human instruction / task context
        -> Embodied reasoning layer
        -> VLA policy layer
        -> Motion/control layer
        -> Robot hardware and environment
        -> Sensor feedback, logs, failures, interventions

Safety/assurance crosses instruction, plan, action, command, and execution.
Data/evaluation closes the loop by recording success, failure, latency,
interventions, safety events, and protocol details.
```

The point of the figure is not that every system must implement exactly this pipeline. The point is that these responsibilities do not vanish when language goals become physical motion.

## 1.3 The Five-Layer Real VLA Stack

Section 1.2 followed one instruction through the system. We can now name the stack.

### Table 1.1. Real VLA Stack Responsibilities

| Layer | Main question | Typical input | Typical output | Cannot guarantee alone |
| --- | --- | --- | --- | --- |
| Embodied reasoning | What should be done? | Instruction, scene, memory, task context | Subgoal, plan, constraint, tool or policy call | Low-level physical execution |
| VLA policy | What action should be proposed now? | Observation, language/subgoal, proprioception | Policy-level action `a_t` | Safety, feasibility, full task success |
| Motion/control | How does the action become motion? | `a_t`, robot state, constraints | Controller command `u_t` | Semantic correctness |
| Safety/assurance | Should the system allow, modify, stop, recover, or ask? | Instruction, plan, action, command, runtime signals | Permit, block, modify, stop, recover, handoff | Learning or task competence |
| Data/evaluation | What evidence was produced? | Logs, actions, states, failures, interventions | Dataset record, metrics, regression tests | Physical safety by itself |

The embodied reasoning layer structures intent. It may use a VLM/LLM, scene graph, memory, planner, or skill library, but its output is not a motor command. A plan can be necessary without being sufficient. [Anchors: C, D]

The VLA policy layer is where this book uses "VLA" in the narrowest sense. It maps observation, language or subgoal, and robot state into a policy-level action. This action may be a token, waypoint, delta pose, action chunk, or continuous distribution. The taxonomy is deferred to Chapter 13; Chapter 1 only fixes the fact that the output is an interface object. [Anchors: A, B]

The motion/control layer is not a passive executor. It interprets the policy action physically. A phrase such as "move right" means different things depending on coordinate frame, scale, robot state, controller type, and control rate.

The safety/assurance layer crosses the stack. It may include semantic filtering, geometric checking, dynamic limits, runtime monitors, human override, and recovery policies. A safety shield that cannot interpret the policy action type cannot provide strong runtime assurance.

The data/evaluation layer records the evidence behind any capability claim. A success rate has different meaning depending on embodiment, action representation, controller, randomization, intervention policy, and failure labeling.

This stack is best read as a conceptual accountability stack. It is not a required software architecture. A single neural model may absorb multiple roles, and a deployed robot may split one role across several services. What matters is that the responsibilities remain visible.

## 1.4 Interface Contracts: Observation, State, Action, and Control

The stack becomes useful only if its interfaces are precise. The first distinction is observation versus state.

`o_t` is what the system observes: camera images, depth, tactile signals, audio, proprioceptive readings, and other sensor streams. `s_t` is the physical state of the world and robot. The true state is usually not directly known. The robot may see an image without knowing object pose, contact force, slip, hidden obstacles, actuator delay, or human intention.

Therefore Real VLA often operates through state estimates or beliefs. We may write `\hat{s}_t` or `b_t` for estimated state or belief, `q_t` for configuration, and `x_t` for robot-centric state used by the controller and safety layer.

The second distinction is policy action versus controller command.

```text
Figure 1.2. Observation, Action, and Control Interface

o_t, q_t, x_t, instruction
        -> VLA policy
        -> a_t
        -> motion/control interpretation
        -> u_t
        -> robot and environment
        -> new observations and logs
```

`a_t` is the policy-level action. It is the action object proposed by the VLA policy. It may be discrete, continuous, metric, normalized, single-step, chunked, or distributional.

`u_t` is the low-level command. It is what the servo loop, robot driver, or whole-body controller receives. It may be velocity, torque, joint target, impedance target, or another controller-specific command.

### Box 1.3. Why Action Representation Is a Control Boundary

Action representation is not a formatting detail. It decides what the policy learns, what the controller must infer, what the safety layer can inspect, and what the evaluator can measure.

If a VLA outputs action tokens, the controller must recover physical meaning from symbolic or discretized choices. If it outputs continuous deltas, scaling and normalization become central. If it outputs waypoints, downstream control must fill in motion. If it outputs action chunks, recovery granularity changes. If it outputs diffusion or flow samples, latency and safety projection become part of the deployment problem.

This is why Chapter 13 is a core chapter rather than a technical appendix.

Chapter 1 does not compare every action taxonomy. It only establishes the interface question: [Anchor: B]

> What exactly leaves the VLA policy, and what must the rest of the robot stack do before that object becomes safe physical motion?

## 1.5 Historical Convergence: Control, Planning, Robot Learning, and VLM/LLM

Real VLA did not appear from nowhere. It is a convergence of older robotics problems with newer foundation-model machinery. [Anchors: A, C, D, E]

```text
Figure 1.3. Historical Convergence Map

Control and estimation
        -> state, feedback, stability, contact, constraints

Planning and TAMP
        -> task structure, feasibility, long-horizon composition

Robot learning
        -> image-to-action, imitation, RL, distribution shift

VLM / LLM / foundation models
        -> semantic grounding, language-conditioned reasoning, tool use

Data, evaluation, and safety
        -> evidence, robustness, deployment responsibility

These streams converge into Real VLA.
```

### Table 1.2. Historical Ingredients and Their VLA Contribution

| Lineage | What it contributes to Real VLA | What it does not solve alone |
| --- | --- | --- |
| Estimation and control | State, feedback, stability, contact, latency, constraints | Language-conditioned task semantics |
| Planning and TAMP | Task structure, symbolic constraints, feasibility, recovery | Continuous perception and learned action distributions |
| Robot learning | Visuomotor policies, imitation, RL, dataset coverage, rollout failure | Open-ended semantic grounding |
| VLM/LLM systems | Scene-language representation, reasoning, code/tool/skill calls | Physical feasibility and safe control |
| Robot data and evaluation | Evidence, reproducibility, benchmark protocols, failure taxonomy | Universal deployment guarantees |

Control and estimation give Real VLA its physical vocabulary. The robot still moves under kinematics, dynamics, contact, latency, and actuator limits. A language-conditioned policy does not remove the need for state estimation, controller design, or constraint handling.

Planning and TAMP remain current because language instructions often contain long-horizon structure. The point is not that every system must use PDDL. The point is that task structure, feasibility, constraints, and recovery must exist somewhere in the system.

Robot learning is the direct ancestor of VLA policy learning. Behavior cloning, DAgger, guided policy search, visual RL, and visuomotor policies already studied perception-to-action. VLA adds language and foundation-model representation, but it does not erase distribution shift, data coverage, or rollout failure.

VLMs and LLMs add semantic range. They help connect objects, relations, language, common sense, tool use, and task decomposition. But plausible reasoning is not the same as executable motion.

Data, evaluation, and safety are the conditions that make the convergence testable. Open robot datasets, benchmark harnesses, failure detectors, and safety studies do not merely decorate the model story; they define what evidence the field can trust.

## 1.6 Modern System Patterns

Modern VLA systems can be read through a small number of system patterns. These patterns should not be treated as a final taxonomy. They are a way to orient the reader before the later chapters dive deeper. [Anchors: A, B, C, H]

### Table 1.3. Modern System Pattern Matrix

| Pattern | Typical form | Main contribution | Main risk if overread |
| --- | --- | --- | --- |
| VLA policy | Vision/language/proprioception to action | Shows learned language-conditioned robot action | Mistaken for full robot system |
| Action-distribution model | Token, chunk, diffusion, flow, action expert | Makes action representation a central design axis | Hides controller and safety assumptions |
| ER + VLA orchestration | Reasoning model plans or calls VLA/skills | Separates task reasoning from fast action policy | Overstates reasoning as motor competence |
| Humanoid / whole-body stack | VLA plus WBC, loco-manipulation, embodiment-specific control | Expands VLA beyond tabletop arms | Treats impressive demos as broad deployment proof |
| Open-source training stack | Data/model/action-expert/fine-tuning workflow | Makes engineering surface more reproducible | Implies local deployment is solved |

Robotics Transformer and OpenVLA-style systems represent the VLA policy pattern. The key transition is that vision-language representation is connected to robot action prediction. The important question is not only which backbone is used, but what policy-level action leaves the model and how it is executed.

Action-distribution patterns show that modern VLA progress is not only about backbone scale. Tokens, continuous vectors, action chunks, diffusion policies, flow matching, and action experts create different timing, sampling, latency, recovery, and controller-compatibility problems.

ER + VLA orchestration patterns make the layer boundary especially visible. A strong embodied reasoning model may handle physical-world reasoning, spatial reasoning, task planning, success detection, or policy/tool calls, while another VLA policy or controller handles fast action. The reasoning layer can structure what should be done, but it is not automatically a motor-action policy.

Humanoid and whole-body patterns expose the hardest version of Real VLA. Whole-body systems must handle locomotion, balance, manipulation, contact, tactile feedback, latency, safety envelopes, and embodiment-specific data. They make clear why VLA cannot be judged only by arm-tabletop manipulation tasks.

Open-source training and evaluation stacks are also modern system patterns. Fine-tuning recipes, action-tokenizers, benchmark harnesses, pretrained weights, and reproducible code matter. But they are not deployment guarantees. Real robot deployment still requires calibration, controller integration, safety envelopes, latency measurement, and failure logging.

## 1.7 Data, Evaluation, and Safety as System Layers

We can now ask a practical question: how do we know that a VLA system can actually be trusted on a robot?

The answer is not contained in the network architecture alone. A policy may accept images and language and emit actions, but its real capability depends on the data regime that shaped it, the evaluation protocol that measured it, and the safety layer that constrains it during execution.

Robot data does not scale like web text or image data. A robot trajectory is tied to a body, controller, workspace, reset procedure, action representation, and safety policy. For a Real VLA system, a trajectory should be read as a structured record: [Anchor: E]

```text
instruction
observation stream o_t
robot state s_t
policy action a_t
controller command u_t
controller type and rate
safety events
interventions
success and failure labels
reset conditions
normalization and calibration metadata
```

Without these details, the same-looking demonstration can mean different things. A small Cartesian delta action tracked at 5 Hz by a compliant controller is not the same training signal as a joint-position target streamed at 50 Hz. A successful placement after hidden human resets is not the same evidence as a single uninterrupted rollout.

Benchmarks are necessary. They provide shared tasks, comparable numbers, and regression tests. But benchmark success is not identical to robot capability. A benchmark freezes part of the world so that one dimension can be measured. A deployment exposes many dimensions at once. [Anchors: F, G]

For the mug task, a Real VLA evaluation should ask:

- Was the mug placed in the intended region?
- Was the glass untouched?
- Were contact forces within limits?
- Did the robot avoid collision with the rack and table?
- Was human intervention required?
- Did the system detect and recover from slip?
- Was behavior reproducible under pose, lighting, and distractor changes?
- Did `a_t` remain compatible with `u_t`?

### Table 1.4. Model-only VLA versus Real VLA System

| Dimension | Model-only VLA claim | Real VLA system claim |
| --- | --- | --- |
| Main unit | Policy network | Policy plus embodied stack |
| Input/output | Observation, language, action | Observation, state, action, controller, monitor, data record |
| Data evidence | Demonstrations or benchmark dataset | Demonstrations plus embodiment, action type, controller, reset, intervention, and safety metadata |
| Evaluation | Success rate on named tasks | Success, robustness, timing, recovery, intervention, and safety events |
| Failure meaning | Incorrect action or task failure | Layer-localized failure across semantics, policy, control, safety, or data |
| Deployment question | Can the model imitate or generalize? | Can the system act, stop, recover, and produce auditable evidence? |

### Box 1.4. Benchmark Success Is Not Robot Capability

A benchmark result says that a system satisfied a specified protocol. Robot capability is a broader claim about what the system can do under realistic variation. The gap between the two is not a weakness of benchmarks. It is a reminder that the protocol must be named before the number can be interpreted.

For Real VLA, every reported result should state at least robot embodiment, action representation, VLA inference frequency, downstream controller, randomization range, trial count, intervention policy, failure taxonomy, safety shield, and calibration assumptions.

Safety is also a stack property. It cannot be reduced to a polite language model, refusal classifier, or low-level collision checker. A Real VLA system may need semantic safety, geometric safety, dynamic safety, runtime safety, data safety, and human safety at the same time. [Anchor: G]

```text
Figure 1.4. Failure Modes by Layer

Embodied reasoning:
  wrong object reference, ignored constraint, impossible subgoal

VLA policy:
  unstable a_t, poor layout generalization, action representation mismatch

Motion/control:
  tracking error between a_t and u_t, force overshoot, contact instability

Safety/assurance:
  late stop signal, missing contact monitor, unsafe recovery

Data/evaluation:
  hidden resets, narrow randomization, incomplete failure labels
```

This figure captures the main point: a Real VLA failure is rarely just "the model was wrong." A useful failure analysis asks where the system contract broke.

## 1.8 Failure Modes and the Roboticist's Reading Protocol

The final task of Chapter 1 is to turn the stack into a reading protocol.

When a VLA paper claims that a robot can perform a task, a roboticist should ask where the evidence enters the stack. Does the paper change the backbone, the action representation, the data source, the controller interface, the evaluation protocol, or the safety/deployment wrapper? [Anchors: A, B, E, F, G]

### Table 1.5. Failure Mode by Layer

| Layer | Example failure in the mug task | What to inspect |
| --- | --- | --- |
| Embodied reasoning | The system treats "without touching the glass" as a preference rather than a hard constraint | Object grounding, constraint representation, plan or subgoal trace |
| VLA policy | The policy generates a grasp or placement action too close to the glass | Action representation, temporal horizon, confidence, action distribution |
| Motion/control | The action is abstractly feasible but produces overshoot or contact | Controller type, frequency, tracking error, force/torque limits |
| Safety/assurance | The monitor detects glass contact too late | Runtime latency, stop threshold, shield placement, human override |
| Data/evaluation | The trial is counted as success because the mug ends on the rack | Success criteria, intervention logs, safety event labels, randomization |

Failure analysis is not pessimism. It is how robotics defines competence. A robot system is mature when its failures can be localized, measured, mitigated, and used to improve the next system.

### Checklist 1.1. Six Questions for Reading a VLA Paper

1. **What is the backbone?**  
   Is the system built from a VLM, LLM, diffusion model, transformer policy, flow model, hierarchical planner, or hybrid architecture? Is the backbone used for reasoning, policy generation, action decoding, or orchestration?

2. **What is the action representation?**  
   Does the model output action tokens, Cartesian deltas, poses, waypoints, chunks, joint targets, torque commands, or latent actions? What part is `a_t`, and what part is delegated to a controller as `u_t`?

3. **What data created the behavior?**  
   Are the data real robot trajectories, simulation rollouts, teleoperation, scripted demonstrations, human videos, synthetic data, web pretraining, or mixtures? Are embodiment, controller, reset, intervention, and failure labels recorded?

4. **What control interface makes the action physical?**  
   What controller receives the policy output? Is there an impedance controller, operational-space controller, motion planner, MPC, whole-body controller, or vendor API underneath? Are control frequency and tracking assumptions specified?

5. **What evaluation protocol supports the claim?**  
   Is the result measured in simulation, real robot trials, offline prediction, benchmark tasks, long-horizon rollouts, perturbation tests, or deployment-like scenarios? Are trial counts, randomization, failure categories, and uncertainty visible?

6. **What safety and deployment evidence is provided?**  
   Does the system include instruction filtering, geometric checks, runtime monitors, stop/recovery behavior, human override, force limits, failure detection, audit logs, or safety-event reporting?

These questions prevent a paper from being summarized as simply "a bigger VLA model" when its real contribution may be a new action tokenizer, data mixture, evaluation protocol, hierarchical reasoning layer, or deployment wrapper.

```text
Figure 1.5. Chapter 1 Dependency Map

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

Chapter 1 does not give the full taxonomy of action representations; Chapter 13 does that. It does not solve robot data scaling; Chapter 14 takes that up. It does not define every benchmark protocol; Chapter 16 develops that. It does not certify deployment safety; Chapter 19 studies that problem.

Chapter 1 establishes the frame:

> In this book, Real VLA is the responsibility structure that turns language, vision, and learned action into physically executed, evaluated, and safety-monitored robot behavior.

With this frame in place, the rest of the book can study each layer without losing sight of the full robot system.

## Selected Source Anchors

These anchors are source clusters for a later formal citation pass. Current system pages and recent safety/evaluation papers should be rechecked before publication.

### Anchor A. VLA Policy Lineage

- RT-1: https://arxiv.org/abs/2212.06817
- RT-2: https://arxiv.org/abs/2307.15818
- OpenVLA: https://arxiv.org/abs/2406.09246
- OpenVLA project page: https://openvla.github.io/

### Anchor B. Action Representation and Action Distribution

- Diffusion Policy: https://arxiv.org/abs/2303.04137
- ACT / ALOHA: https://arxiv.org/abs/2304.13705
- pi0 report: https://www.physicalintelligence.company/download/pi0.pdf
- FAST: https://arxiv.org/abs/2501.09747

### Anchor C. Embodied Reasoning and Orchestration

- SayCan: https://arxiv.org/abs/2204.01691
- Code as Policies: https://arxiv.org/abs/2209.07753
- PaLM-E: https://arxiv.org/abs/2303.03378
- VoxPoser: https://arxiv.org/abs/2307.05973
- Gemini Robotics: https://deepmind.google/models/gemini-robotics/
- Gemini Robotics-ER 1.6: https://deepmind.google/blog/gemini-robotics-er-1-6/

### Anchor D. Classical Control, Planning, and Estimation

- Khatib operational-space control.
- Hogan impedance control.
- MPC references such as Mayne et al.
- STRIPS/PDDL, LaValle, TAMP, and PDDLStream references.
- Robot modeling/control references such as Murray, Li, and Sastry; Siciliano; Corke.

### Anchor E. Robot Data and Embodiment Metadata

- Open X-Embodiment: https://arxiv.org/abs/2310.08864
- DROID: https://arxiv.org/abs/2403.12945
- BridgeData V2: exact source still needed.

### Anchor F. Evaluation and Diagnostic Benchmarks

- vla-eval: https://arxiv.org/abs/2603.13966
- BeTTER: https://arxiv.org/abs/2604.18000
- VLA-Arena: https://vla-arena.github.io/

### Anchor G. Safety and Failure Detection

- VLA safety survey: https://arxiv.org/abs/2604.23775
- HazardArena: https://arxiv.org/abs/2604.12447
- SAFE failure detection: https://vla-safe.github.io/
- Inference-time safety: https://arxiv.org/abs/2602.01834

### Anchor H. Humanoid and Whole-Body System Cases

- NVIDIA Isaac GR00T repository: https://github.com/NVIDIA/Isaac-GR00T
- NVIDIA Isaac GR00T developer page: https://developer.nvidia.com/isaac/gr00t
- Figure Helix 02: https://www.figure.ai/news/helix-02

## Reference Plan for Formal Citation Pass

- VLA policy lineage: RT-1, RT-2, OpenVLA.
- Action representation lineage: Diffusion Policy, ACT/ALOHA, pi0, FAST, OpenVLA-OFT, openpi.
- ER and orchestration lineage: SayCan, Code as Policies, PaLM-E, VoxPoser, Gemini Robotics-ER, Gemini Robotics.
- Control and planning background: operational-space control, impedance control, MPC, TAMP, PDDLStream, whole-body control.
- Robot data and evaluation: Open X-Embodiment, DROID, BridgeData V2, VLA Foundry, vla-eval, BeTTER.
- Safety and deployment: ASIMOV-style safety work, VLA safety surveys, failure detection and runtime assurance work.
