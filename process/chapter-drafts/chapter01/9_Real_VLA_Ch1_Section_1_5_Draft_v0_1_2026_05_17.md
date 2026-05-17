# Chapter 1. What Is a Real VLA System? - Section Draft v0.1

## 1.5 Historical Convergence: Control, Planning, Robot Learning, and VLM/LLM

지금까지 이 장은 Real VLA를 system stack과 interface contract로 정의했다. 그렇다면 이런 질문이 자연스럽게 따라온다. 왜 VLA 책에서 Kalman filtering, MPC, impedance control, TAMP, imitation learning, VLM, LLM을 모두 함께 다루어야 하는가? 답은 간단하다. VLA는 갑자기 등장한 model family가 아니라, control/estimation, planning/TAMP, robot learning, VLM/LLM, data/evaluation/safety가 하나의 embodied policy stack으로 수렴한 결과이기 때문이다.

VLA를 단순히 "이미지와 언어를 넣으면 action이 나오는 모델"로 보면 이 역사적 수렴이 보이지 않는다. 그러나 Section 1.4의 interface 관점으로 보면 각 흐름이 맡는 역할이 분명해진다. Control과 estimation은 로봇이 물리계 안에서 안정적으로 움직이게 한다. Planning과 TAMP는 목표, 제약, feasibility, recovery를 구조화한다. Robot learning은 perception에서 action으로 가는 mapping을 학습했다. VLM/LLM은 언어, 시각, 상식, instruction following을 제공했다. 현대 VLA는 이 흐름들을 하나의 action-producing stack으로 다시 조립한다.

### Figure 1.3. Historical Convergence Map

```text
Control / Estimation
  -> stable execution, state feedback, constraints, contact

Planning / TAMP
  -> goals, preconditions, feasibility, sequencing, recovery

Robot Learning
  -> imitation, RL, visuomotor policy, perception-to-action

VLM / LLM
  -> semantics, language grounding, common sense, tool use

Data / Evaluation / Safety
  -> scaling evidence, benchmark protocol, failure/safety loop

                     -> Real VLA System
```

이 그림은 논문 연대표가 아니다. 이것은 개념 계보다. Real VLA는 위 흐름 중 하나가 나머지를 대체한 결과가 아니라, 각 흐름이 해결하던 문제가 하나의 robot system 안에서 다시 만난 결과이다.

### Table 1.2. Historical Ingredients and Their VLA Contribution

| Ingredient | Core question | What it contributes to Real VLA | What remains unresolved |
| --- | --- | --- | --- |
| Control / Estimation | 로봇을 안정적으로 움직이고 상태를 추정하는 방법 | feedback, constraints, contact, actuator-safe command | semantic goal을 어떻게 받아들일 것인가 |
| Planning / TAMP | 복잡한 목표를 어떤 순서와 제약으로 풀 것인가 | subgoal, precondition, feasibility, recovery | learned perception/action과 어떻게 결합할 것인가 |
| Robot Learning | perception에서 action을 학습할 수 있는가 | imitation, RL, visuomotor policy, action distribution | language grounding, data coverage, covariate shift |
| VLM / LLM | 언어와 시각 의미를 대규모로 학습할 수 있는가 | semantics, common sense, instruction following, tool use | embodiment-specific feasibility와 execution |
| Data / Evaluation / Safety | 성능과 안전을 어떤 evidence로 주장할 것인가 | dataset, benchmark, failure log, safety intervention | benchmark score와 real capability의 간극 |

Control과 estimation은 VLA가 없애는 것이 아니라 VLA가 물리계에 들어갈 때 사용하는 언어이다. VLA가 end-effector delta pose를 내든, waypoint를 내든, action chunk를 내든, 로봇은 여전히 kinematics, dynamics, contact, latency, actuator limit 안에서 움직인다. Kalman filtering이 observation과 state를 구분하게 했고, MPC가 constraint와 finite-horizon control을 다루게 했으며, impedance control과 operational space control이 접촉과 task-space execution을 설명하게 했다. **VLA가 의미론을 추가해도 로봇은 여전히 추정, 제어, 접촉, 제약 안에서 움직인다.** [CITATION: Kalman; Mayne et al.; Hogan; Khatib]

Planning과 TAMP도 같은 이유로 현재형 도구이다. 자연어 instruction은 종종 long-horizon structure를 갖는다. "아침 식사 후 테이블을 정리하라"는 명령은 object category, container state, sequence, forbidden action, grasp feasibility, placement feasibility, 실패 복구를 포함한다. LLM/VLM/ER 모델이 planning function 일부를 흡수할 수는 있지만, planning problem 자체가 사라지는 것은 아니다. 문제는 PDDL을 반드시 써야 한다는 것이 아니라, task-level structure, constraint, feasibility, recovery가 system 어딘가에 존재해야 한다는 것이다. **LLM planner가 등장해도 planning problem은 사라지지 않고 representation이 바뀐다.** [CITATION: A*; STRIPS; PDDL; PDDLStream; SayCan]

Robot learning은 VLA의 직접 조상이다. VLA 이전에도 behavior cloning, DAgger, guided policy search, visuomotor policy, visual RL, large-scale grasping은 image-to-action mapping을 학습하려고 했다. 이 흐름은 이미 observation, policy, action, distribution shift, data coverage, rollout failure라는 문제를 만들었다. VLA가 새롭게 한 일은 여기에 language grounding과 foundation-model representation을 결합한 것이다. 따라서 VLA를 LLM에서만 나온 field로 보면 절반만 보는 것이다. **VLA의 직접 조상은 LLM만이 아니라 visuomotor robot learning이다.** [CITATION: DAgger; Guided Policy Search; Deep Visuomotor Policies; QT-Opt; Diffusion Policy]

VLM과 LLM은 다른 종류의 전환을 만들었다. CLIP과 Flamingo류의 vision-language representation은 object, relation, scene, language instruction을 대규모 데이터에서 학습할 수 있음을 보여주었다. SayCan, Code as Policies, PaLM-E, VoxPoser 같은 bridge system은 LLM/VLM이 robot skill, controller, affordance, value function, code API와 결합될 수 있음을 보여주었다. 하지만 이 흐름은 embodiment-specific feasibility와 low-level execution 문제를 끝내지 않았다. LLM은 plausible plan을 만들 수 있지만, 그 plan이 gripper reachability, collision-free path, contact stability, force limit, controller rate를 만족한다는 보장은 없다. **VLM/LLM은 로봇에게 의미를 주었지만, 그 의미를 물리적으로 실행 가능하게 만드는 문제를 끝내지는 않았다.** [CITATION: CLIP; Flamingo; SayCan; Code as Policies; PaLM-E; VoxPoser]

Robotics Transformer와 RT 계열은 이 흐름을 action-producing model 쪽으로 밀었다. RT-1은 real robot data와 task diversity를 이용해 language-conditioned robot policy를 만들었고, RT-2는 web-scale VLM knowledge와 robot trajectory data를 결합해 action을 token처럼 다루는 관점을 강하게 제시했다. OpenVLA는 이 방향을 open-source VLA policy로 확장했고, 이후 pi0, FAST, OpenVLA-OFT 같은 흐름은 action expert, action tokenization, continuous action, flow matching, fine-tuning efficiency를 중심 이슈로 만들었다. 이 전환은 backbone이 커졌다는 이야기만이 아니다. action을 어떤 시간구조와 확률분포로 표현하고, controller와 어떻게 만나는지가 핵심축이 되었다. [CITATION: RT-1; RT-2; OpenVLA; pi0; FAST; OpenVLA-OFT]

Data, evaluation, safety는 이 수렴의 마지막 장식이 아니라 수렴을 실제 시스템으로 바꾸는 조건이다. Open X-Embodiment, DROID, BridgeData V2 같은 데이터 흐름은 로봇 데이터가 웹 텍스트와 다르다는 사실을 더 분명하게 만들었다. Robot data는 embodiment, sensor setup, action label, teleoperation style, task distribution, success/failure annotation을 포함한다. Evaluation도 단순 success rate만으로 끝나지 않는다. protocol, latency, safety intervention, distribution shift, recovery, hidden human help를 함께 봐야 한다. Safety 역시 semantic filtering만으로 충분하지 않고, geometric, dynamic, runtime, data safety가 함께 필요하다. [CITATION: Open X-Embodiment; DROID; BridgeData V2; vla-eval; BeTTER; ASIMOV]

이 관점에서 보면 VLA의 역사는 "LLM이 로봇을 움직이게 되었다"는 이야기가 아니다. 더 정확한 이야기는 이것이다. 고전 제어는 안정성과 실시간성을 제공했고, planning은 목표와 제약의 구조를 제공했으며, robot learning은 perception-to-action learning을 제공했고, VLM/LLM은 semantic grounding과 instruction following을 제공했다. VLA는 이 요소들을 하나의 embodied policy stack으로 재조립하는 흐름이다.

Section 1.5의 목적은 최신 논문을 연대순으로 나열하는 것이 아니라, 독자가 현대 VLA system을 읽을 때 필요한 역사적 렌즈를 제공하는 것이다. 이 렌즈를 갖고 나면 다음 질문을 더 정확히 던질 수 있다. 어떤 시스템은 왜 model-only VLA처럼 보이는가? 어떤 시스템은 왜 ER + VLA + controller로 나뉘는가? 어떤 시스템은 왜 humanoid whole-body deployment를 강조하는가? 다음 Section 1.6은 최신 모델을 leaderboard가 아니라 이런 system pattern으로 분류한다.

## Citation Placeholders for Later Integration

- **[C1.5-1] Kalman; Mayne et al.; Hogan; Khatib; Murray, Li, and Sastry** - control, estimation, contact, operational-space execution.
- **[C1.5-2] A*; STRIPS; PDDL; PDDLStream; TAMP surveys** - planning, task structure, feasibility, recovery.
- **[C1.5-3] DAgger; Guided Policy Search; Deep Visuomotor Policies; QT-Opt; Diffusion Policy** - robot learning and perception-to-action lineage.
- **[C1.5-4] CLIP; Flamingo; SayCan; Code as Policies; PaLM-E; VoxPoser** - VLM/LLM robotics bridge lineage.
- **[C1.5-5] RT-1; RT-2; OpenVLA; pi0; FAST; OpenVLA-OFT** - VLA core and action representation transition.
- **[C1.5-6] Open X-Embodiment; DROID; BridgeData V2; vla-eval; BeTTER; ASIMOV** - data, evaluation, safety evidence.

## Revision Notes

- This is the first draft of Section 1.5 based on Section 1.4.
- It treats history as concept lineage, not chronology.
- It includes Figure 1.3 and Table 1.2 as text/table placeholders.
- It bridges to Section 1.6 modern system patterns.
