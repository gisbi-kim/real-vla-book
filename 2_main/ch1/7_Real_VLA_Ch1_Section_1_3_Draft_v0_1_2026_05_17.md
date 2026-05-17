# Chapter 1. What Is a Real VLA System? - Section Draft v0.1

## 1.3 The Five-Layer Real VLA Stack

Section 1.2에서는 자연어 instruction이 곧바로 motor command가 되지 않는다는 점을 실행 경로로 보았다. 이제 그 경로를 책 전체에서 반복해서 사용할 stack으로 고정한다. 이 책에서 Real VLA system은 다섯 개의 responsibility layer로 읽는다: embodied reasoning, VLA policy, motion/control, safety/assurance, data/evaluation이다.

이 stack은 "모든 좋은 로봇 시스템은 반드시 다섯 개의 독립 모듈로 구현되어야 한다"는 주장이 아니다. 어떤 시스템은 하나의 큰 model 안에서 reasoning과 action proposal을 함께 수행할 수 있고, 어떤 시스템은 controller wrapper와 safety filter를 하나의 runtime service로 묶을 수 있다. 그러나 구현이 합쳐져도 책임은 합쳐지지 않는다. Real VLA stack은 software module diagram이 아니라 conceptual accountability stack이다. 어떤 layer가 무엇을 입력받고, 무엇을 내보내고, 무엇을 보장하지 못하는지 읽기 위한 도구이다.

머그컵 예제로 돌아가 보자. Embodied reasoning layer는 장면, 명령, 기억, 작업 이력을 보고 "머그컵을 drying rack에 놓아야 한다", "유리컵 주변은 피해야 한다", "놓은 뒤 안정적으로 지지되어야 한다"는 subgoal과 constraint를 만든다. VLA policy layer는 현재 observation과 robot proprioception을 보고 grasp, lift, move, place에 해당하는 policy-level action을 제안한다. Motion/control layer는 그 action을 실제 robot state와 kinematic/dynamic limit 안에서 trajectory, impedance target, velocity command, whole-body reference로 바꾼다. Safety/assurance layer는 instruction, plan, action, command, runtime state를 보며 allow, modify, stop, recover, ask human 결정을 내린다. Data/evaluation layer는 이 실행이 성공했는지, 어디서 위험했는지, 어떤 action type과 control rate가 쓰였는지 기록하고 다음 학습과 평가의 근거를 만든다.

### Table 1.1. Real VLA Stack Responsibilities

| Layer | Typical input | Typical output | Responsibility | Common failure |
| --- | --- | --- | --- | --- |
| Embodied Reasoning | instruction, observation, memory, scene context | subgoal, plan, constraint, tool/VLA call | 무엇을 해야 하는지 구조화한다 | infeasible subgoal, missing precondition, unsafe ambiguity |
| VLA Policy | observation, proprioception, instruction/subgoal, short memory | action token, waypoint, delta pose, action chunk, action distribution | task semantics를 policy-level action으로 바꾼다 | action granularity mismatch, controller mismatch, embodiment mismatch |
| Motion/Control | policy-level action, robot state, constraints | trajectory, servo command, torque/velocity/position target | action proposal을 물리적으로 추적 가능한 command로 해석한다 | IK failure, force overshoot, timing jitter, saturation |
| Safety/Assurance | instruction, plan, action, command, state, monitor signal | allow, modify, stop, recover, ask human | semantic, geometric, dynamic, runtime safety를 관리한다 | monitor latency, wrapper-only safety, unsafe recovery |
| Data/Evaluation | trajectories, failures, intervention logs, labels, protocols | dataset, metric, regression test, deployment evidence | 성능 주장의 근거와 다음 개선 loop를 만든다 | success-only bias, hidden intervention, underspecified protocol |

첫 번째 layer인 embodied reasoning은 "무엇을 해야 하는가"를 정리한다. 이 layer는 VLM/LLM, scene graph, memory, planning module, skill library를 사용할 수 있다. 그러나 이 layer의 출력은 motor command가 아니다. 좋은 plan이나 subgoal은 physical execution의 필요조건일 수 있지만 충분조건은 아니다. "유리컵을 피해서 머그컵을 drying rack에 놓아라"라는 구조화된 intent가 있어도, 그 intent가 grasp pose, collision-free trajectory, compliant contact, actuator-safe command로 자동 변환되는 것은 아니다. [CITATION: SayCan; Code as Policies; PaLM-E; Gemini Robotics-ER]

두 번째 layer인 VLA policy는 이 책에서 "VLA"라는 단어가 가장 좁은 의미로 쓰이는 위치이다. VLA policy는 observation, instruction 또는 subgoal, proprioception, short memory를 받아 policy-level action object를 제안한다. 이 action object는 token일 수도 있고, waypoint일 수도 있고, delta pose나 short action chunk일 수도 있고, continuous action distribution일 수도 있다. 이 장에서는 그 action taxonomy를 깊게 비교하지 않는다. 여기서 고정할 것은 하나다. VLA policy output은 action type, coordinate frame, rate, horizon, scaling, downstream controller를 필요로 하는 interface object이다. 이 세부 비교는 Chapter 13에서 다룬다. [CITATION: RT-1; RT-2; OpenVLA; pi0; Diffusion Policy]

세 번째 layer인 motion/control은 VLA output을 그대로 통과시키는 executor가 아니다. Controller는 robot state와 constraints를 보고 action proposal을 물리적으로 해석한다. 같은 "move right"라도 robot base frame인지 end-effector frame인지, normalized action인지 metric pose인지, velocity command인지 target pose인지에 따라 완전히 다른 실행이 된다. Operational space control, impedance control, MPC, trajectory optimization, whole-body control은 이 layer에서 VLA action을 trackable command로 바꾸는 현재형 도구이다. 따라서 controller는 learned policy의 하위 부품이 아니라 physical feasibility를 해석하는 별도의 책임 layer이다. [CITATION: Khatib; Hogan; MPC; WBC]

네 번째 layer인 safety/assurance는 stack 전체를 가로지른다. Safety는 마지막에 붙이는 "거절 필터"만이 아니다. 위험한 instruction을 거절하는 semantic safety, glass와의 충돌을 피하는 geometric safety, 과도한 속도와 힘을 막는 dynamic safety, 실행 중 이상을 감지하는 runtime assurance, 실패 후 더 위험한 recovery를 막는 recovery policy가 모두 필요하다. 특히 VLA system에서는 safety layer가 어떤 action type을 해석할 수 있는지가 중요하다. safety shield가 waypoint는 검사할 수 있지만 action token의 물리 의미를 모른다면, runtime assurance는 약해진다. [CITATION: ASIMOV; VLA safety survey; vla-eval]

다섯 번째 layer인 data/evaluation은 deployment 이후의 문서화 절차가 아니다. VLA의 성능 주장은 데이터와 평가 프로토콜이 만든 evidence 위에 선다. 어떤 robot에서 어떤 camera와 gripper를 썼는지, action이 joint position인지 delta pose인지, VLA inference rate와 control frequency가 얼마였는지, 성공만 기록했는지 실패와 intervention도 기록했는지에 따라 같은 success rate의 의미가 달라진다. Data/evaluation layer는 학습 corpus를 만드는 동시에, 그 model이 어떤 조건에서 재현 가능하고 어떤 조건에서 무너지는지 증명하는 layer이다. [CITATION: Open X-Embodiment; DROID; VLA Foundry; vla-eval; BeTTER]

이 다섯 layer를 분리하면 VLA 논문과 시스템을 읽는 방식도 달라진다. 더 큰 backbone을 썼는지만 묻는 대신, 우리는 다음을 묻는다. ER layer는 무엇을 구조화했는가? VLA policy는 어떤 action type을 냈는가? Controller는 어떤 physical command로 해석했는가? Safety는 어디서 무엇을 검사했는가? Data/evaluation은 어떤 protocol로 capability claim을 만들었는가? 이 질문들이 없으면 Real VLA는 다시 "image + language -> action"이라는 너무 납작한 그림으로 돌아간다.

Figure 1.1은 이 다섯 layer를 하나의 accountability stack으로 표현한다. 위쪽 또는 왼쪽에서 instruction과 observation이 들어오고, ER layer가 subgoal과 constraint를 만든다. VLA policy layer는 policy-level action을 제안한다. Motion/control layer는 trajectory 또는 low-level command를 만든다. Robot/environment는 이를 실행하고 sensor feedback을 되돌린다. Safety/assurance layer는 이 경로의 여러 지점에 붙어 있고, data/evaluation layer는 실행 기록을 다음 학습, 평가, regression test로 되돌린다.

Section 1.3의 결론은 간단하다. **Real VLA system은 하나의 모델 이름이 아니라, semantic reasoning, action generation, physical control, safety assurance, data/evaluation evidence가 서로 책임 경계를 맺는 embodied stack이다.** 이 stack을 정의했으므로, 다음 Section 1.4에서는 layer 사이의 interface를 더 엄밀하게 다룬다. 특히 observation과 state의 차이, policy-level action `a_t`와 low-level command `u_t`의 차이, frame/rate/horizon/controller metadata가 왜 필요한지 정리한다.

## Citation Placeholders for Later Integration

- **[C1.3-1] SayCan; Code as Policies; PaLM-E; Gemini Robotics-ER** - ER layer, planning, tool/VLA call, embodied reasoning case studies.
- **[C1.3-2] RT-1; RT-2; OpenVLA; pi0; Diffusion Policy** - VLA policy layer and action proposal examples.
- **[C1.3-3] Khatib; Hogan; MPC; WBC** - motion/control layer and physical feasibility evidence.
- **[C1.3-4] ASIMOV; VLA safety survey; vla-eval** - safety/assurance and runtime/evaluation evidence.
- **[C1.3-5] Open X-Embodiment; DROID; VLA Foundry; BeTTER** - data/evaluation layer and benchmark/protocol evidence.

## Revision Notes

- This is the first draft of Section 1.3 based on Section 1.2.
- It formalizes the five-layer stack without requiring modular implementation.
- It includes a table-style responsibility map for later conversion into Table 1.1 or Table 1.2.
- It defers action taxonomy details to Chapter 13.
- It bridges to Section 1.4 interface contracts.
