# Real VLA: Chapter 1 Evidence Map v0.1

**Chapter:** Chapter 1. *What Is a Real VLA System?*  
**Purpose:** 본문 원고 작성 전, Chapter 1에서 주장할 핵심 claim과 그 claim을 뒷받침할 textbook, 논문, 시스템 사례, 반례, figure/table 재료를 정리하는 논증 설계도.  
**Status:** Evidence map only. 본문 원고 아님. 단순 bibliography 아님.  
**Last updated:** 2026-05-12 KST  
**Working inputs:** Book Bible v0.1, Wave 1 Chapter Contracts v0.1, Interface Specification + Global Glossary v0.1.

---

## 0. Chapter 1 One-Sentence Thesis

**A real VLA system is not a larger VLM that directly replaces robotics; it is a layered embodied interface that connects task semantics, multimodal perception, robot state, action representation, control, data, evaluation, and safety into one executable physical system.**

한국어 집필용 핵심 문장:

> **Real VLA는 로봇 제어를 대체하는 하나의 거대 모델이 아니라, 언어와 시각으로 표현된 task semantics를 실제 로봇의 제약 있는 action generation으로 연결하는 embodied system interface이다.**

이 thesis는 Chapter 1의 모든 claim을 묶는 중심축이다. 이후 Chapter 13은 이 thesis 중 action/control boundary를 자세히 풀고, Chapter 14는 data engine을, Chapter 16은 evaluation protocol을, Chapter 19는 safety and assurance stack을 확장한다.

---

## 1. Proposed Chapter 1 Section Skeleton

Chapter 1 Evidence Map은 아래 section 구조를 전제로 한다. 상세 outline은 다음 단계에서 다시 만든다.

1. **1.1 Why "Real VLA" Is Not Just a Bigger VLM**  
   VLA hype를 정리하고, model이 아니라 system/interface 관점이 필요한 이유를 제시한다.
2. **1.2 The Real VLA Stack**  
   Embodied reasoning, VLA policy, motion/control, safety/assurance, data/evaluation layer를 정의한다.
3. **1.3 What the Robot Sees, Knows, and Commands**  
   observation, state, proprioception, memory, action representation, control boundary를 구분한다.
4. **1.4 Historical Ingredients: Control, Planning, Learning, VLM/LLM**  
   고전 제어/계획/모션플래닝/로봇러닝/VLM-LLM이 VLA stack 안에서 맡는 역할을 연결한다.
5. **1.5 Modern System Patterns: VLA, ER + VLA, Humanoid VLA**  
   RT-1/RT-2/OpenVLA/pi0 계열과 Gemini Robotics-ER, GR00T, Helix류를 system pattern으로 배치한다.
6. **1.6 What Can Go Wrong: Data, Evaluation, Safety**  
   benchmark overfitting, embodied reasoning illusion, unsafe command, latency, embodiment gap을 소개한다.
7. **1.7 What This Chapter Locks for the Rest of the Book**  
   Ch13/Ch14/Ch16/Ch19로 넘길 개념을 정리한다.

---

## 2. Citation Tier Policy for Chapter 1

Chapter 1은 독자의 첫 인상을 결정하므로, 출처의 신뢰도를 명확히 나눠야 한다.

| Tier | Meaning | How to use in Chapter 1 |
|---|---|---|
| **Tier A** | Textbook / established foundation | 정의, 기본 수식, 오랜 기간 검증된 제어/계획/학습 개념의 근거로 사용한다. |
| **Tier B** | Peer-reviewed or widely cited paper | 역사적 전환점, 검증된 연구 흐름, VLA의 핵심 개념을 뒷받침하는 주된 근거로 사용한다. |
| **Tier C** | arXiv / preprint / project page / open-source paper | 최신 방향성, emerging architecture, evaluation/safety frontier를 설명하되 과장하지 않는다. |
| **Tier D** | Company technical report / official docs / product page / official blog | 최신 시스템 case study로만 사용한다. 일반 법칙처럼 쓰지 않는다. |

**Chapter 1 citation rule:** Tier D source는 "대표 사례"로만 쓴다. "증명된 일반 원리"처럼 쓰지 않는다. 최신 회사 시스템은 Ch1에서 독자에게 landscape를 보여주는 역할만 하고, 자세한 기술 판단은 Ch17/Ch18/Ch20으로 넘긴다.

---

## 3. Source Registry for Chapter 1

아래 registry는 Chapter 1에서 자주 호출할 source ID다. Evidence Map에서는 source ID로 참조한다. 자세한 citation format은 최종 원고 단계에서 정리한다.

### Tier A. Textbooks and Established Foundations

- **A1.** Murray, Li, and Sastry, *A Mathematical Introduction to Robotic Manipulation* - kinematics, dynamics, manipulation, control의 기본 언어.
- **A2.** Lynch and Park, *Modern Robotics* - configuration space, screw theory, motion planning, control의 현대적 정리.
- **A3.** Siciliano, Sciavicco, Villani, and Oriolo, *Robotics: Modelling, Planning and Control* - 로봇 모델링/계획/제어 통합 교재.
- **A4.** Siciliano and Khatib, *Springer Handbook of Robotics* - manipulation, planning, safety, HRI, robot learning을 포괄하는 reference.
- **A5.** LaValle, *Planning Algorithms* - search, motion planning, sampling-based planning, kinodynamic planning의 기초.
- **A6.** Ghallab, Nau, and Traverso, *Automated Planning* - symbolic planning, action model, goal decomposition의 기초.
- **A7.** Sutton and Barto, *Reinforcement Learning: An Introduction* - policy, value, MDP, exploration, temporal decision making의 기본 언어.
- **A8.** Levine, *Reinforcement Learning and Control as Probabilistic Inference* - control as inference 관점.

### Tier B. Core Papers and Widely Used Research Anchors

- **B1.** Kalman, "A New Approach to Linear Filtering and Prediction Problems" - observation과 state의 차이.
- **B2.** Bellman, *Dynamic Programming* - optimal control, dynamic programming, MDP/RL의 원류.
- **B3.** Mayne et al., "Constrained Model Predictive Control" - receding-horizon control과 constraint handling.
- **B4.** Raibert and Craig, "Hybrid Position/Force Control" - contact task에서 position/force 분리.
- **B5.** Hogan, "Impedance Control" - safe physical interaction의 핵심 개념.
- **B6.** Khatib, "Operational Space Control" - task-space control and end-effector interface.
- **B7.** Hart, Nilsson, and Raphael, "A*" - heuristic search.
- **B8.** Fikes and Nilsson, "STRIPS" - symbolic action model.
- **B9.** McDermott et al., "PDDL" - planning domain description.
- **B10.** Garrett et al., "PDDLStream" - task and motion planning bridge.
- **B11.** Ross et al., "DAgger" - imitation learning의 covariate shift.
- **B12.** Levine et al., "End-to-End Training of Deep Visuomotor Policies" - image-to-action policy.
- **B13.** Kalashnikov et al., "QT-Opt" - large-scale robotic grasping and self-supervised RL.
- **B14.** Chi et al., "Diffusion Policy" - multimodal continuous action distribution.
- **B15.** Vaswani et al., "Attention Is All You Need" - transformer sequence modeling.
- **B16.** Radford et al., "CLIP" - language-grounded visual representation.
- **B17.** Alayrac et al., "Flamingo" - interleaved image/video/text VLM.
- **B18.** Ahn et al., "Do As I Can, Not As I Say / SayCan" - LLM + robot affordance grounding.
- **B19.** Liang et al., "Code as Policies" - LLM-generated robot policies and controller API calls.
- **B20.** Driess et al., "PaLM-E" - embodied multimodal language model.
- **B21.** Brohan et al., "RT-1" - Robotics Transformer and scalable robot data.
- **B22.** Zitkovich/Brohan et al., "RT-2" - VLA term and action-as-token recipe.
- **B23.** Open X-Embodiment Collaboration, "Open X-Embodiment / RT-X" - cross-embodiment dataset/model.
- **B24.** Kim et al., "OpenVLA" - open-source 7B VLA trained on 970k robot demonstrations.
- **B25.** Octo Model Team, "Octo" - open-source generalist robot policy.
- **B26.** DROID Team, "DROID" - in-the-wild robot manipulation dataset.

### Tier C. Recent / Emerging Research and Open-Source Stacks

- **C1.** Black et al., ["pi0: A Vision-Language-Action Flow Model for General Robot Control"](https://arxiv.org/abs/2410.24164) - flow matching + VLM backbone for continuous action.
- **C2.** Physical Intelligence, ["pi0.5: a Vision-Language-Action Model with Open-World Generalization"](https://arxiv.org/abs/2504.16054) - heterogeneous data, semantic prediction, real-home generalization claims.
- **C3.** Pertsch et al., ["FAST: Efficient Action Tokenization for Vision-Language-Action Models"](https://arxiv.org/abs/2501.09747) - action tokenization via compression.
- **C4.** OpenVLA-OFT, [project page](https://openvla-oft.github.io/) and [GitHub](https://github.com/moojink/openvla-oft) - optimized fine-tuning, continuous action, speed/success tradeoff.
- **C5.** Mercat et al., ["VLA Foundry"](https://arxiv.org/abs/2604.19728) - unified LLM/VLM/VLA training stack.
- **C6.** Choi et al., ["vla-eval"](https://arxiv.org/abs/2603.13966) - unified evaluation harness and reproducibility audit.
- **C7.** Xu et al., ["BeTTER / Unmasking the Illusion of Embodied Reasoning"](https://arxiv.org/abs/2604.18000) - stress tests for embodied reasoning under causal interventions.
- **C8.** ASIMOV Benchmark v2, [project page](https://asimov-benchmark.github.io/v2/) - continuous physical safety benchmarking for embodied AI.
- **C9.** ["Vision-Language-Action Safety: Threats, Challenges and Future Directions"](https://arxiv.org/html/2604.23775v1) - structured VLA safety analysis.
- **C10.** Physical Intelligence, [openpi GitHub](https://github.com/Physical-Intelligence/openpi) - pi0 / pi0-FAST / pi0.5 open implementation context.

### Tier D. Official Company / Product / Technical Case Studies

- **D1.** Google AI, [Gemini Robotics-ER 1.6 Preview docs](https://ai.google.dev/gemini-api/docs/models/gemini-robotics-er-1.6-preview) - ER model as VLM for spatial reasoning, task planning, action planning from natural language.
- **D2.** Google DeepMind, [Gemini Robotics 1.5 official page](https://deepmind.google/models/gemini-robotics/gemini-robotics/) - multi-embodiment VLA case study.
- **D3.** NVIDIA, [Isaac GR00T N1.7 GitHub](https://github.com/NVIDIA/Isaac-GR00T) - Early Access humanoid/generalist robot stack, pretrained weights, fine-tuning/inference reference code.
- **D4.** NVIDIA Developer Forum, [GR00T N1.7 Early Access announcement](https://forums.developer.nvidia.com/t/early-access-isaac-gr00t-n1-7-open-reasoning-vla-model-for-humanoid-robotics/366916) - commercial licensing and deployment framing.
- **D5.** Figure AI, [Helix official page](https://www.figure.ai/helix) and [Helix 02 news](https://www.figure.ai/news/helix-02) - humanoid VLA/whole-body autonomy case study.
- **D6.** OpenVLA, [GitHub](https://github.com/openvla/openvla) - open-source VLA training/fine-tuning codebase.

---

## 4. Evidence Categories

### 4.1 Classical Robotics / Control Evidence

**Role in Chapter 1:** VLA가 아무리 high-level semantics를 잘 다뤄도 실제 로봇은 state estimation, dynamics, constraints, contact, actuator limits, latency 안에서 움직인다는 점을 고정한다.

**Use sources:** A1-A4, B1-B6, B14.  
**Ch1 placement:** 1.2, 1.3, 1.4.  
**Core argument:** VLA output은 곧바로 physical motion이 아니다. VLA output은 controller, servo loop, planner, impedance/OSC/MPC layer와 만나는 interface이다.

### 4.2 Planning / TAMP Evidence

**Role in Chapter 1:** 자연어 명령은 long-horizon task, subgoal, precondition/effect, feasibility, retry/recovery를 요구한다. 이것은 LLM/VLM 이전부터 planning과 TAMP가 다뤄온 문제다.

**Use sources:** A5-A6, B7-B10, B18-B20.  
**Ch1 placement:** 1.2, 1.4, 1.5.  
**Core argument:** LLM/VLM/ER 모델은 symbolic planner를 완전히 폐기한 것이 아니라, 일부 planning function을 neural reasoning layer로 재배치했다.

### 4.3 Robot Learning Evidence

**Role in Chapter 1:** VLA의 직접 조상은 imitation learning, visuomotor policy, large-scale robot learning이다. VLA는 LLM만으로 생긴 것이 아니라 perception-to-action learning의 연장선이다.

**Use sources:** A7-A8, B11-B14, B21-B26.  
**Ch1 placement:** 1.4, 1.5, 1.6.  
**Core argument:** VLA는 language grounding이 붙은 robot policy이며, behavior cloning/covariate shift/offline data/action distribution 문제가 그대로 남아 있다.

### 4.4 VLM / LLM Robotics Bridge Evidence

**Role in Chapter 1:** VLM/LLM은 semantics, common sense, instruction following, tool use를 제공하지만, embodiment-specific feasibility와 low-level execution은 별도의 grounding이 필요하다.

**Use sources:** B15-B20.  
**Ch1 placement:** 1.1, 1.4, 1.5.  
**Core argument:** SayCan, Code as Policies, PaLM-E는 VLA 이전의 bridge다. 이들은 "language model as planner"와 "controller/skill as executor"의 구조를 보여준다.

### 4.5 VLA Core Evidence

**Role in Chapter 1:** RT-1/RT-2/OpenVLA/pi0/FAST/OpenVLA-OFT를 통해 VLA가 어떻게 action prediction model로 발전했는지 짧게 보여준다.

**Use sources:** B21-B24, C1-C4, C10, D6.  
**Ch1 placement:** 1.5.  
**Core argument:** VLA의 핵심은 vision-language backbone 여부만이 아니라 action representation, control frequency, temporal horizon, embodiment adaptation이다.

### 4.6 Data / Evaluation / Safety Evidence

**Role in Chapter 1:** Real VLA system의 신뢰성은 model architecture만으로 결정되지 않는다. 데이터 수집/정규화, evaluation protocol, safety assurance가 함께 붙어야 한다.

**Use sources:** B23-B26, C5-C9.  
**Ch1 placement:** 1.6, 1.7.  
**Core argument:** benchmark success와 physical capability는 다르다. 평가와 safety는 appendix가 아니라 system layer다.

### 4.7 Modern ER + VLA / Humanoid / Deployment Case Studies

**Role in Chapter 1:** 2025-2026년 최신 흐름은 single end-to-end VLA만이 아니라 ER + VLA + controller, humanoid whole-body autonomy, on-device/real-time deployment로 이동하고 있음을 보여준다.

**Use sources:** D1-D5, C5-C10.  
**Ch1 placement:** 1.5, 1.6.  
**Core argument:** 최신 회사 시스템은 "증명된 일반해"가 아니라 "산업계가 어떤 system pattern을 시도하는지"를 보여주는 case study로 써야 한다.

---

## 5. Claim-by-Claim Evidence Map

### Claim 1. A real VLA system is a layered embodied system, not a single monolithic model.

**Why this claim is needed in Ch1:**  
첫 장에서 "Real VLA"의 정의를 잘못 잡으면 책 전체가 최신 논문 survey나 hype 문서로 흘러간다. 이 claim은 책의 중심 thesis를 고정한다.

**Use textbook/reference:**  
A1-A4 for robotics stack; A5-A6 for planning stack; A7-A8 for decision-making/policy language.

**Use papers/reference:**  
B18 SayCan for LLM + skill/value grounding; B19 Code as Policies for LLM-generated code calling control primitives; B21 RT-1 and B22 RT-2 for scalable robot action generation; B24 OpenVLA for open VLA policy; C1 pi0 for VLA + flow action; C5 VLA Foundry for training stack.

**Use latest system cases:**  
D1 Gemini Robotics-ER 1.6 as an ER/VLM layer; D2 Gemini Robotics 1.5 as VLA case; D3-D4 GR00T N1.7 as humanoid stack; D5 Helix/Helix 02 as company case study.

**Counterexample / failure mode:**  
A VLM can correctly describe a scene and still produce no executable trajectory. A VLA can predict an action but violate contact force, workspace, or timing constraints. A humanoid demo may hide controller, safety monitor, teleoperation, or carefully selected task distribution.

**Section placement:**  
1.1 and 1.2.

**Avoid overclaim:**  
Do not say "VLA is always hierarchical." Some systems are more end-to-end. Say instead: "Real deployment usually exposes layered responsibilities even when the learned model is trained end-to-end."

---

### Claim 2. Observation is not state; real robot action requires state estimation, proprioception, memory, and latency-aware feedback.

**Why this claim is needed in Ch1:**  
많은 VLA 소개는 "image + language -> action"으로 단순화한다. Ch1은 observation, robot state, hidden environment state, proprioception, history를 구분해야 한다.

**Use textbook/reference:**  
A1-A4 for state, kinematics, dynamics; B1 Kalman for filtering; A7 for partially observed decision processes.

**Use papers/reference:**  
B12 deep visuomotor policies; B21 RT-1; B24 OpenVLA; C1 pi0; C2 pi0.5. These show observation-conditioned policies but do not remove partial observability.

**Use latest system cases:**  
D1 Gemini Robotics-ER 1.6 uses visual/spatial reasoning and task planning; D3 GR00T N1.7 includes inference and fine-tuning stack for real robot data; D5 Helix 02 claims full-body room-level autonomy but should be treated as case study.

**Counterexample / failure mode:**  
Object occlusion, slipping contact, delayed camera frame, unobserved gripper state, uncalibrated extrinsics, and hidden human motion can make the visual input insufficient. A model may appear semantically correct but act on stale or incomplete state.

**Section placement:**  
1.3.

**Avoid overclaim:**  
Do not imply that adding more cameras or a larger VLM solves state estimation. State estimation is a system problem involving sensing, filtering, calibration, timing, and control.

---

### Claim 3. Action representation is the control boundary of a VLA system.

**Why this claim is needed in Ch1:**  
Chapter 1 must introduce why Chapter 13 exists. The reader should understand from the beginning that action token, waypoint, delta pose, action chunk, diffusion/flow output, and torque command are not interchangeable.

**Use textbook/reference:**  
A1-A4 for joint space/task space/control interfaces; B4-B6 for force/impedance/operational-space control; B3 for MPC and constraints.

**Use papers/reference:**  
B22 RT-2 for action-as-text-token; B14 Diffusion Policy for action distribution; C1 pi0 for flow matching; C3 FAST for efficient action tokenization; C4 OpenVLA-OFT for continuous actions and optimized fine-tuning.

**Use latest system cases:**  
D2 Gemini Robotics 1.5 as a VLA case that maps visual/instruction input to motor commands; D3 GR00T N1.7 as humanoid policy stack; D5 Helix 02 as whole-body action case.

**Counterexample / failure mode:**  
A discrete action token scheme can be convenient for VLM training but brittle for high-frequency dexterous manipulation. Direct low-level torque can be expressive but unsafe or data-hungry. Waypoints can be stable but may push burden to motion planning and control.

**Section placement:**  
1.3 and bridge to Ch13.

**Avoid overclaim:**  
Do not say any one action representation is universally best. The right boundary depends on robot morphology, task contact profile, controller availability, latency budget, and data distribution.

---

### Claim 4. Classical planning and TAMP remain necessary because language instructions imply long-horizon structure, constraints, and recovery.

**Why this claim is needed in Ch1:**  
Ch1 must prevent the misconception that LLM/VLM reasoning eliminates classical planning. The book's roboticist perspective is that planning has been reconfigured, not erased.

**Use textbook/reference:**  
A5 LaValle; A6 Ghallab/Nau/Traverso; A1-A3 for motion planning/control interfaces.

**Use papers/reference:**  
B7 A*; B8 STRIPS; B9 PDDL; B10 PDDLStream; B18 SayCan; B19 Code as Policies; B20 PaLM-E; VoxPoser can be added as bridge evidence in final citation list.

**Use latest system cases:**  
D1 Gemini Robotics-ER 1.6 as task planning/spatial reasoning/success detection layer; D2 Gemini Robotics 1.5 as VLA; C7 BeTTER as caution against static benchmark success.

**Counterexample / failure mode:**  
A robot asked to "put the groceries away" must infer categories, object affordances, container states, navigation constraints, grasp feasibility, sequencing, and recovery from failed grasps. A one-step VLA policy is insufficient unless a larger system handles decomposition and feedback.

**Section placement:**  
1.2, 1.4, 1.5.

**Avoid overclaim:**  
Do not frame TAMP as always explicitly symbolic. The point is not "PDDL must be used," but "task-level structure, feasibility, and recovery must exist somewhere in the system."

---

### Claim 5. VLM/LLM robotics bridge systems solved semantic grounding only partially; embodiment-specific affordance remains the central bottleneck.

**Why this claim is needed in Ch1:**  
This claim explains why the field moved from LLM-as-planner to VLA/action-policy models and why ER + VLA is now a natural architecture.

**Use textbook/reference:**  
A6 for planning; A7 for policy/affordance-style decision making; A1-A4 for embodiment-specific constraints.

**Use papers/reference:**  
B16 CLIP and B17 Flamingo for VLM representation; B18 SayCan for affordance grounding; B19 Code as Policies for skill/controller API use; B20 PaLM-E for multimodal embodied inference; B22 RT-2 for VLM-to-action transfer.

**Use latest system cases:**  
D1 Gemini Robotics-ER 1.6 as high-level embodied reasoning layer; D2 Gemini Robotics 1.5 as VLA model; D5 Helix as humanoid VLA case.

**Counterexample / failure mode:**  
An LLM can propose a plausible plan that the robot cannot execute due to gripper limits, object pose, clutter, reachable workspace, missing tool, or unsafe human proximity.

**Section placement:**  
1.4 and 1.5.

**Avoid overclaim:**  
Do not say VLM/LLM bridge systems are obsolete. They are ancestors and still active components in hierarchical VLA systems.

---

### Claim 6. VLA scaling is data-engineering constrained, not only architecture constrained.

**Why this claim is needed in Ch1:**  
Chapter 1 must prepare the reader for Chapter 14. Robot foundation models do not scale exactly like web LLMs because robot data is expensive, embodiment-specific, action-labeled, temporally structured, and safety-sensitive.

**Use textbook/reference:**  
A7 for policy learning; A8 for control-as-inference; A1-A4 for robot embodiment differences.

**Use papers/reference:**  
B23 Open X-Embodiment / RT-X; B24 OpenVLA; B25 Octo; B26 DROID; B11 DAgger; B13 QT-Opt; C5 VLA Foundry.

**Use latest system cases:**  
D3 GR00T N1.7 for fine-tuning/inference with custom robot data; D6 OpenVLA GitHub for open-source training/fine-tuning codebase; C5 VLA Foundry for unified training stack.

**Counterexample / failure mode:**  
A model trained on many robot demonstrations may still fail on a new embodiment if action normalization, sensor placement, calibration, gripper morphology, or task success criteria shift.

**Section placement:**  
1.6 and bridge to Ch14.

**Avoid overclaim:**  
Do not say "more robot data always solves generalization." Data diversity, quality, labeling, failure coverage, embodiment normalization, and evaluation protocol matter.

---

### Claim 7. Modern VLA architecture is increasingly organized around temporal/action distribution choices: token, chunk, diffusion, flow, and action expert.

**Why this claim is needed in Ch1:**  
Chapter 1 should foreshadow that the most important technical axis is not merely backbone size, but how action is generated over time and passed to the robot.

**Use textbook/reference:**  
A1-A4 for action/control interfaces; A7-A8 for policy distributions and trajectory-level decision making.

**Use papers/reference:**  
B14 Diffusion Policy; B22 RT-2; B24 OpenVLA; C1 pi0; C3 FAST; C4 OpenVLA-OFT; C10 openpi. ACT/ALOHA and Mobile ALOHA should be added in Ch13 evidence map even if Ch1 mentions them only briefly.

**Use latest system cases:**  
D3 GR00T N1.7 and D5 Helix 02 for humanoid/whole-body action as case study; D2 Gemini Robotics 1.5 as VLA model; C4 OpenVLA-OFT as fine-tuning and continuous-action case.

**Counterexample / failure mode:**  
A model that reasons well semantically can still fail in contact-rich manipulation if its action representation cannot express smooth, multimodal, high-frequency motion.

**Section placement:**  
1.3, 1.5, and explicit handoff to Ch13.

**Avoid overclaim:**  
Do not turn Ch1 into an action representation chapter. Introduce the taxonomy and defer details to Ch13.

---

### Claim 8. Evaluation must test more than task success on familiar benchmarks; it must test protocol reproducibility, distribution shift, reasoning, timing, and failure recovery.

**Why this claim is needed in Ch1:**  
VLA readers often overinterpret benchmark success rates. Ch1 should warn that success rate is a useful but incomplete proxy.

**Use textbook/reference:**  
A7 for evaluation under policy learning and generalization; A4 for robotics system evaluation context.

**Use papers/reference:**  
C6 vla-eval; C7 BeTTER; B23 Open X-Embodiment; B24 OpenVLA; B25 Octo; B26 DROID; CALVIN, LIBERO, and ManiSkill can be added in Ch16 detailed evidence map.

**Use latest system cases:**  
C6 vla-eval as evaluation harness; C7 BeTTER as reasoning stress test; D1/D2 as examples where ER vs VLA must be evaluated separately.

**Counterexample / failure mode:**  
A policy may score highly on static benchmark tasks but fail under spatial layout shift, temporal extrapolation, unseen object configurations, ambiguous termination semantics, or latency-induced closed-loop instability.

**Section placement:**  
1.6 and bridge to Ch16.

**Avoid overclaim:**  
Do not imply new diagnostic benchmarks are final truth. Use them as evidence that evaluation protocols need stress tests and reproducibility audits.

---

### Claim 9. Safety is a stack property, not a property of the VLA model alone.

**Why this claim is needed in Ch1:**  
This claim prevents the book from treating safety as a final appendix. It introduces safety as part of the definition of a real VLA system.

**Use textbook/reference:**  
A4 for robotics safety/HRI context; A1-A3 for control-level constraints; B3 MPC for constraint-aware control; B5 impedance control for interaction safety.

**Use papers/reference:**  
C8 ASIMOV v2; C9 VLA safety survey; C6 vla-eval; C7 BeTTER. Existing robot safety standards may be introduced later in Ch19, not necessary in Ch1 unless the outline needs it.

**Use latest system cases:**  
D1 Gemini Robotics-ER 1.6 docs explicitly treat robotics generative model use as safety-sensitive; D2 Gemini Robotics 1.5 and D3 GR00T N1.7 as deployment case studies requiring system assurance.

**Counterexample / failure mode:**  
A semantically safe instruction can become physically unsafe due to collision, excessive force, unstable grasp, hot object handling, human proximity, or failure to stop after partial task completion.

**Section placement:**  
1.2, 1.6, and bridge to Ch19.

**Avoid overclaim:**  
Do not claim a semantic safety filter makes a robot safe. Safety requires semantic, geometric, dynamic, runtime, and human-override mechanisms.

---

### Claim 10. 2025-2026 systems show a practical trend toward ER + VLA + controller and humanoid/whole-body deployment, but these systems should be treated as case studies, not settled science.

**Why this claim is needed in Ch1:**  
Chapter 1 should be current enough to motivate the book, but it should not overfit to company demos or preprints. This claim gives a disciplined way to discuss latest systems.

**Use textbook/reference:**  
A1-A4 for whole-body control and manipulation context; A5-A6 for high-level planning; A7-A8 for policy learning.

**Use papers/reference:**  
C1 pi0; C2 pi0.5; C3 FAST; C5 VLA Foundry; C6 vla-eval; C7 BeTTER; C8 ASIMOV v2.

**Use latest system cases:**  
D1 Gemini Robotics-ER 1.6; D2 Gemini Robotics 1.5; D3-D4 GR00T N1.7; D5 Helix/Helix 02; D6 OpenVLA GitHub.

**Counterexample / failure mode:**  
A polished whole-body demo can be produced under constrained conditions. Without reproducible protocols, failure logs, controller details, safety mechanisms, and distribution-shift testing, it cannot be used as proof of general physical intelligence.

**Section placement:**  
1.5 and 1.6.

**Avoid overclaim:**  
Do not say humanoid VLA has solved general robotics. Say it is an important deployment frontier where action representation, whole-body control, safety, latency, and data collection become inseparable.

---

## 6. Figure and Table Candidates for Chapter 1

### Figure 1.1. Real VLA System Stack

**Placement:** after Section 1.2 opening.  
**Purpose:** Show that Real VLA is not a single model.  
**Structure:**

```text
Human instruction / task context / environment
        ↓
Embodied Reasoning Layer
(scene understanding, task decomposition, memory, tool/VLA calls)
        ↓
VLA Policy Layer
(observation + language + proprioception -> action representation)
        ↓
Motion / Control Layer
(trajectory, servo, impedance, OSC, MPC, WBC)
        ↓
Robot hardware + environment
        ↕
Safety / Assurance Layer and Data / Evaluation Layer wrap the stack
```

**Evidence support:** Claim 1, 3, 4, 9.  
**Warning:** Do not imply every system has exactly this modular implementation. Present it as a conceptual accountability stack.

### Figure 1.2. Control Boundary: a_t vs u_t

**Placement:** Section 1.3.  
**Purpose:** Distinguish learned policy action representation from actual low-level control command.  
**Structure:**

```text
o_t, q_t, language -> VLA policy -> a_t
                                   ↓
                         controller/planner/safety gate
                                   ↓
                                  u_t -> robot
```

**Notation:**  
- `o_t`: observation, e.g., RGB image, depth, tactile signal.  
- `q_t`: robot state/proprioception.  
- `a_t`: policy-level action representation, e.g., token, waypoint, delta pose, action chunk.  
- `u_t`: actuator/controller command, e.g., joint velocity, torque, impedance target.

**Evidence support:** Claim 2, 3, 7, 9.

### Figure 1.3. Historical Convergence Map

**Placement:** Section 1.4.  
**Purpose:** Convert history into concept lineage rather than paper chronology.  
**Structure:**

```text
Control/Estimation -> stable execution and feedback
Planning/TAMP -> goals, constraints, feasibility, recovery
Robot Learning -> perception-to-action and imitation/RL
VLM/LLM -> semantics, language, common sense, grounding
Data/Eval/Safety -> scaling, verification, deployment discipline
                         ↓
                    Real VLA System
```

**Evidence support:** all claims.

### Figure 1.4. Failure Modes by Layer

**Placement:** Section 1.6.  
**Purpose:** Foreshadow Ch14/Ch16/Ch19.  
**Structure:** Each layer has representative failure: semantic hallucination, state mismatch, invalid action representation, controller violation, unsafe contact, benchmark artifact, data shift.

### Table 1.1. VLM vs VLA Model vs Real VLA System vs ER Model

**Placement:** Section 1.1 or 1.2.  
**Purpose:** Prevent terminology confusion.  
**Suggested columns:** Entity, input, output, physical responsibility, examples, what it cannot guarantee.

### Table 1.2. Action Representation and Control Interface Preview

**Placement:** Section 1.3.  
**Purpose:** Hand off to Ch13.  
**Suggested rows:** action token, delta pose, waypoint, action chunk, diffusion/flow action, torque, whole-body action.  
**Suggested columns:** where it appears, controller burden, strengths, risks.

### Table 1.3. Claim-to-Chapter Handoff Matrix

**Placement:** Section 1.7.  
**Purpose:** Show how Ch1 locks the book's terminology.  
**Suggested columns:** Claim, concept locked in Ch1, detailed chapter, deferred question.

---

## 7. Opening Examples for Chapter 1

### Opening Example A. "Clean the table after breakfast"

**Why useful:**  
This example contains semantic categorization, object affordance, contact manipulation, order of operations, safety, and recovery.

**What it demonstrates:**  
A VLM can identify objects; an ER model can decompose the task; a VLA policy can issue pick/place actions; a controller must execute safe contact; evaluation must check partial completion and recovery.

**Use with claims:**  
Claim 1, 3, 4, 6, 8, 9.

### Opening Example B. "Put the mug on the drying rack, but do not knock over the glass"

**Why useful:**  
It directly exposes the difference between semantic instruction following and continuous collision/contact-aware control.

**What it demonstrates:**  
Language alone is insufficient. Feasible motion, end-effector pose, force/impedance, visual servoing, and safety monitor are needed.

**Use with claims:**  
Claim 2, 3, 4, 9.

### Opening Example C. "Sort household waste according to local rules"

**Why useful:**  
This illustrates the ER + VLA pattern: retrieve or reason about rules, classify objects, plan bins, and physically manipulate items.

**What it demonstrates:**  
High-level reasoning and low-level action are different responsibilities. The example can connect to Gemini Robotics style ER + VLA narratives without depending on one vendor.

**Use with claims:**  
Claim 1, 4, 5, 10.

### Opening Example D. Humanoid room-level cleanup demo

**Why useful:**  
It motivates why whole-body action, latency, safety, and data collection are now central.

**What it demonstrates:**  
Humanoid demos are visually compelling but require careful interpretation. They should be case studies, not proof of general intelligence.

**Use with claims:**  
Claim 7, 8, 9, 10.

---

## 8. Weak Claims and Hype Statements to Avoid in Chapter 1

1. **"VLA replaces classical robotics."**  
   Replace with: VLA reorganizes how control, planning, learning, perception, language, data, and safety interact.
2. **"A VLA is simply image + language -> action."**  
   Replace with: This is the policy-layer abstraction, not the full deployable system.
3. **"Internet-scale knowledge directly transfers to physical control."**  
   Replace with: Internet-scale pretraining can improve semantic generalization, but embodiment-specific grounding and control remain necessary.
4. **"Benchmark success implies embodied reasoning."**  
   Replace with: Benchmark success is one measurement; causal interventions, distribution shift, timing, and recovery must also be tested.
5. **"A larger VLM will solve manipulation."**  
   Replace with: Manipulation requires contact, dynamics, action distribution, and feedback-aware execution.
6. **"Humanoid demos prove general-purpose robotics is solved."**  
   Replace with: Humanoid demos are important case studies but require reproducible evaluation and safety evidence.
7. **"Gemini Robotics-ER is itself a VLA."**  
   Replace with: Gemini Robotics-ER 1.6 is best treated in this book as an embodied reasoning VLM/ER layer unless paired with a VLA/controller that outputs motor actions.
8. **"Open source equals easy deployment."**  
   Replace with: Open source improves reproducibility and adaptation, but deployment still requires robot-specific data, calibration, controllers, and safety validation.
9. **"One action representation is universally best."**  
   Replace with: Action representation is a control-boundary design choice.
10. **"Safety can be delegated to the model."**  
    Replace with: Safety is a stack property.

---

## 9. Concepts to Hand Off to Later Chapters

### Hand-off to Chapter 13. Action Representation

Chapter 1 should introduce but not deeply analyze:

- action token
- continuous action
- waypoint
- delta pose
- joint position/velocity command
- torque command
- action chunk
- diffusion/flow action distribution
- action expert
- whole-body action
- `a_t` vs `u_t` notation
- control boundary

**Chapter 1 role:** define the problem and taxonomy.  
**Chapter 13 role:** analyze trade-offs, algorithms, architectures, examples, and failure modes.

### Hand-off to Chapter 14. Data Engines

Chapter 1 should introduce:

- robot data is not web text
- embodiment gap
- action label mismatch
- teleoperation / human video / simulation / synthetic data
- data curation and failure data
- cross-embodiment normalization

**Chapter 1 role:** explain why data engine is part of the system.  
**Chapter 14 role:** detail collection, normalization, curation, scaling, relabeling, and fine-tuning datasets.

### Hand-off to Chapter 16. Evaluation and Benchmarking

Chapter 1 should introduce:

- task success vs real capability
- benchmark artifacts
- protocol reproducibility
- distribution shift
- timing/latency metrics
- failure recovery
- simulation vs real-robot evaluation

**Chapter 1 role:** warn that benchmark score is not capability.  
**Chapter 16 role:** build evaluation protocol and benchmark taxonomy.

### Hand-off to Chapter 19. Safety and Assurance

Chapter 1 should introduce:

- semantic safety
- geometric safety
- dynamic/contact safety
- runtime monitor
- safety shield
- human override
- unsafe data and unsafe generalization

**Chapter 1 role:** define safety as a stack property.  
**Chapter 19 role:** formalize safety layers, benchmarks, monitors, assurance methods, and deployment procedures.

---

## 10. Claim-to-Handoff Matrix

이 matrix는 Word 렌더링 안정성을 위해 넓은 표가 아니라 claim별 bullet 형식으로 둔다.

### Claim 1

- **Concept locked in Ch1:** Real VLA system vs VLA model.
- **Main handoff chapter:** Ch13, Ch17, Ch19.
- **Ch1 should not over-explain:** Detailed model architecture.

### Claim 2

- **Concept locked in Ch1:** Observation/state/proprioception distinction.
- **Main handoff chapter:** Ch2, Ch13.
- **Ch1 should not over-explain:** Full filtering/control derivation.

### Claim 3

- **Concept locked in Ch1:** Action/control boundary.
- **Main handoff chapter:** Ch13.
- **Ch1 should not over-explain:** Full action taxonomy and equations.

### Claim 4

- **Concept locked in Ch1:** Planning/TAMP still matters.
- **Main handoff chapter:** Ch5, Ch17.
- **Ch1 should not over-explain:** Full PDDL/TAMP algorithms.

### Claim 5

- **Concept locked in Ch1:** VLM/LLM bridge and affordance grounding.
- **Main handoff chapter:** Ch10, Ch11.
- **Ch1 should not over-explain:** Full VLM history.

### Claim 6

- **Concept locked in Ch1:** Data engine is a system layer.
- **Main handoff chapter:** Ch14, Ch15.
- **Ch1 should not over-explain:** Dataset-by-dataset survey.

### Claim 7

- **Concept locked in Ch1:** Action representation is central.
- **Main handoff chapter:** Ch13, Ch18, Ch20.
- **Ch1 should not over-explain:** Detailed diffusion/flow/action-chunk derivation.

### Claim 8

- **Concept locked in Ch1:** Evaluation must be stress-tested.
- **Main handoff chapter:** Ch16.
- **Ch1 should not over-explain:** Full benchmark catalog.

### Claim 9

- **Concept locked in Ch1:** Safety is a stack property.
- **Main handoff chapter:** Ch19.
- **Ch1 should not over-explain:** Formal safety/standards treatment.

### Claim 10

- **Concept locked in Ch1:** Latest ER/humanoid systems are case studies.
- **Main handoff chapter:** Ch17, Ch18, Ch20.
- **Ch1 should not over-explain:** Company-by-company technical analysis.

---

## 11. Chapter 1 Evidence Placement Plan

### Section 1.1 Evidence Placement

**Core claims:** Claim 1, Claim 5.  
**Evidence:** B18, B19, B20, B22, D1, D2.  
**Opening move:** Start with a realistic task, not a paper chronology. Then define why "image + language -> action" is an incomplete abstraction.

### Section 1.2 Evidence Placement

**Core claims:** Claim 1, Claim 4, Claim 9.  
**Evidence:** A1-A7, B3-B6, B10, B18, D1-D3.  
**Opening move:** Present the Real VLA stack figure.

### Section 1.3 Evidence Placement

**Core claims:** Claim 2, Claim 3, Claim 7.  
**Evidence:** B1, B3-B6, B14, B22, C1, C3, C4.  
**Opening move:** Introduce `o_t`, `q_t`, `a_t`, `u_t` without deriving all equations.

### Section 1.4 Evidence Placement

**Core claims:** Claim 4, Claim 5.  
**Evidence:** A5-A6, B7-B10, B15-B20, B21-B22.  
**Opening move:** Show historical convergence map.

### Section 1.5 Evidence Placement

**Core claims:** Claim 7, Claim 10.  
**Evidence:** B21-B24, C1-C5, D1-D6.  
**Opening move:** Compare system patterns, not model leaderboards.

### Section 1.6 Evidence Placement

**Core claims:** Claim 6, Claim 8, Claim 9.  
**Evidence:** B23-B26, C5-C9, D1-D5.  
**Opening move:** State that failure analysis is not pessimism; it is the robotics definition of competence.

### Section 1.7 Evidence Placement

**Core claims:** all.  
**Evidence:** Use no new sources unless necessary. Summarize locked concepts and handoffs.

---

## 12. Freshness Notes for Latest Systems

These notes are for Ch1 writing discipline. They should not be expanded into detailed company-system analysis in Chapter 1.

- **Gemini Robotics-ER 1.6:** Treat as an embodied reasoning VLM/ER model, not as the lower-level action policy by default. Official docs describe it as a VLM for advanced physical-world reasoning, spatial reasoning, and planning actions from natural-language commands.
- **Gemini Robotics 1.5:** Treat as a VLA case study. Official Google DeepMind page presents it as a VLA model that turns visual information and instructions into motor commands.
- **GR00T N1.7:** Treat as Early Access humanoid/generalist robotics stack. The GitHub page emphasizes pretrained weights, reference code, and fine-tuning/inference support; do not treat it as fully benchmarked public science.
- **Figure Helix / Helix 02:** Treat as company case study. Use it to motivate whole-body autonomy and humanoid deployment, not as a peer-reviewed reference.
- **VLA Foundry:** Treat as an emerging open-source training stack and engineering framework.
- **vla-eval, BeTTER, ASIMOV v2:** Treat as evidence that evaluation/safety is now an active research frontier, not as final arbitration of capability.

---

## 13. Open Issues Before Drafting Chapter 1

1. **How broad should the term "Real VLA System" be?**  
   Current decision: VLA policy + embodied reasoning + motion/control + safety + data/evaluation stack.
2. **How should Gemini Robotics-ER be classified?**  
   Current decision: ER/VLM layer, not VLA policy layer unless paired with motor-command generation.
3. **How much should Ch1 discuss humanoids?**  
   Current decision: only as a deployment frontier and case study. Detailed treatment goes to Ch20.
4. **Should Ch1 contain equations?**  
   Current decision: only minimal notation `o_t`, `q_t`, `a_t`, `u_t`. Derivations go to later chapters.
5. **Should Ch1 cite company blogs?**  
   Current decision: yes, but only as Tier D system examples with explicit caution.
6. **Should Ch1 mention ASIMOV/vla-eval/BeTTER?**  
   Current decision: yes, as examples showing why evaluation/safety cannot be postponed to deployment.
7. **Should Ch1 include exhaustive VLA model list?**  
   Current decision: no. Use representative models only. Detailed model taxonomy comes later.

---

## 14. Next-Step Prompt: Chapter 1 Detailed Outline

Use the following prompt after approving this Evidence Map.

```text
Book Bible v0.1, Wave 1 Chapter Contracts v0.1, Interface Specification + Global Glossary v0.1, and Chapter 1 Evidence Map v0.1을 기준으로 Chapter 1. "What Is a Real VLA System?"의 Detailed Outline을 작성해줘.

목표:
본문 원고 작성 직전 단계로, section/subsection 단위의 논증 흐름, 각 subsection의 핵심 문장, 사용할 evidence source ID, figure/table placement, bridge sentence를 고정하는 것.

조건:
- 본문 원고는 아직 쓰지 마.
- 단순 목차가 아니라 argument outline으로 작성해.
- 각 section마다 다음을 포함해:
  1. Section goal
  2. Core claim
  3. Subsection structure
  4. Evidence source IDs
  5. Figure/table placement
  6. Definitions introduced
  7. Concepts deferred to later chapters
  8. Failure mode or caution
  9. Section closing bridge
- Ch1 전체의 opening example을 1개 선택하고, 왜 그것이 최적인지 설명해.
- 마지막에는 Section 1.1 본문 작성을 위한 prompt를 제안해.
출력은 md와 docx 둘 다 만들어줘.
```

---

## 15. Compact Reminder for Future Writing Turns

```text
Chapter 1 should define Real VLA as a system interface, not introduce every VLA paper.
It must lock the stack, the action/control boundary, the data/evaluation/safety layers, and the handoff to Ch13/Ch14/Ch16/Ch19.
Do not write a survey. Write the definition layer of the book.
```
