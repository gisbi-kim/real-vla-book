# Chapter 1. What Is a Real VLA System? - Section Draft v0.1

## 1.2 From Language Goal to Motor Command

Section 1.1에서는 Real VLA가 단순히 더 큰 VLM이 아니라는 점을 확인했다. 이제 같은 주장을 실행 경로로 바꾸어 보자. 로봇에게 "테이블 위의 머그컵을 들어 drying rack에 놓되, 옆의 유리컵은 건드리지 말라"고 지시했다고 하자. 이 문장은 겉으로는 하나의 자연어 명령이지만, 로봇 시스템 안으로 들어가면 여러 종류의 representation으로 분해된다. 여기에는 목표 object, 목표 위치, 금지 조건, 성공 조건, 실패 복구 조건, 가능한 skill, 필요한 sensor feedback, controller가 추적할 수 있는 command가 모두 포함된다.

첫 번째 변환은 language에서 task semantics로 가는 변환이다. "머그컵"은 조작 대상이고, "drying rack"은 목표 relation을 정의하는 장소이며, "유리컵을 건드리지 말라"는 constraint이다. "놓아라"라는 동사는 단순한 motion primitive가 아니라 grasp, lift, transport, place, release, verify로 이어질 수 있는 task structure를 암시한다. 따라서 자연어 instruction은 action 자체가 아니다. 그것은 어떤 action들이 필요할지 조직하는 task semantics이다. [CITATION: STRIPS; PDDL; SayCan]

두 번째 변환은 task semantics에서 subgoal과 constraint bundle로 가는 변환이다. ER layer는 장면과 명령을 보고 "mug가 graspable해야 한다", "drying rack 위에 collision-free placement가 있어야 한다", "glass 근처의 forbidden region을 피해야 한다", "놓은 뒤 mug가 안정적으로 지지되어야 한다" 같은 조건을 만들 수 있다. 이 단계의 출력은 아직 motor command가 아니다. 그것은 로봇이 무엇을 달성해야 하는지와 무엇을 피해야 하는지를 정리한 구조화된 의도이다.

세 번째 변환은 subgoal에서 policy-level action으로 가는 변환이다. VLA policy layer는 현재 observation, proprioception, instruction 또는 subgoal을 받아 `a_t`를 제안한다. 이 `a_t`는 end-effector delta pose일 수도 있고, waypoint일 수도 있고, short action chunk일 수도 있고, action token 또는 action distribution일 수도 있다. 중요한 점은 `a_t`가 robot stack이 해석해야 하는 실행 객체라는 것이다. Subgoal은 "무엇이 달라져야 하는가"를 말하지만, action은 "어떤 interface를 통해 로봇에게 무엇을 보낼 것인가"를 말한다.

### Box 1.2. ER layer vs VLA policy layer

ER layer와 VLA policy layer는 모두 language와 vision을 사용할 수 있지만, 책임은 다르다. ER layer는 scene, instruction, memory, task history를 이용해 무엇을 해야 하는지 구조화한다. 그 출력은 subgoal, plan, constraint, tool call, VLA call, success condition일 수 있다. 반면 VLA policy layer는 observation, proprioception, instruction 또는 subgoal을 받아 robot action representation을 제안한다. 그 출력은 `a_t` 또는 `A_t^{(H)}`처럼 controller와 safety layer가 해석해야 하는 policy-level action이다.

이 구분은 model architecture를 강제로 나누자는 뜻이 아니다. 하나의 큰 model이 reasoning과 action proposal을 모두 수행할 수도 있다. 그러나 그 경우에도 원고에서는 두 책임을 분리해서 읽어야 한다. Reasoning이 좋다는 사실은 action이 물리적으로 실행 가능하다는 보장이 아니고, action을 잘 예측한다는 사실은 task decomposition과 safety reasoning이 충분하다는 보장이 아니다.

네 번째 변환은 policy-level action에서 controller target과 low-level command로 가는 변환이다. VLA가 "action을 낸다"고 말할 때, 그 action이 곧 actuator command라는 뜻은 아니다. 예를 들어 VLA가 end-effector delta pose를 냈다면 motion/control layer는 현재 robot state, kinematic limits, workspace constraint, obstacle geometry를 보고 그것을 controller reference로 해석해야 한다. 이후 operational space controller, impedance controller, MPC, trajectory optimizer, whole-body controller 같은 layer가 `u_t`를 만든다. `u_t`는 velocity, torque, joint position, impedance target, whole-body command처럼 실제 servo loop 또는 robot driver가 받는 값이다. [CITATION: Khatib; Hogan; MPC; WBC]

이 경로를 간단히 쓰면 다음과 같다.

```text
instruction
  -> task semantics
  -> subgoal / constraint / success condition
  -> policy-level action a_t
  -> safety decision
  -> controller target
  -> low-level command u_t
  -> execution feedback
```

Figure 1.1은 이 경로를 Real VLA System Stack으로 보여줄 것이다. 왼쪽에는 instruction과 observation이 있고, 중앙에는 embodied reasoning과 VLA policy가 있으며, 오른쪽에는 motion/control과 robot/environment가 있다. Safety/assurance layer는 instruction, plan, action, command, execution을 가로질러 붙고, data/evaluation layer는 아래쪽 feedback loop로 실패, intervention, success, latency, safety event를 기록한다. 이 그림의 목적은 모든 시스템이 정확히 같은 pipeline을 구현한다는 주장이 아니다. 목적은 언어 목표가 물리 행동으로 바뀔 때 어떤 책임들이 사라지지 않는지 보여주는 것이다.

Safety는 이 경로의 마지막 wrapper가 아니다. "유리컵을 건드리지 말라"는 constraint는 instruction 단계에서 해석되어야 하고, subgoal 단계에서 forbidden region으로 바뀔 수 있으며, action 단계에서 workspace violation 여부를 검사할 수 있고, command 단계에서 속도나 힘 제한으로 반영될 수 있다. 실행 중에는 예상치 못한 접촉이나 사람의 개입을 감지해 stop, modify, recover, ask human 결정을 내려야 한다. 따라서 Real VLA의 실행 경로는 one-shot prediction path가 아니라 monitored feedback path이다. [CITATION: ASIMOV; VLA safety survey; vla-eval]

Data/evaluation layer도 같은 이유로 실행 경로의 일부이다. 로봇이 mug를 놓는 데 성공했다는 사실만 기록하면 충분하지 않다. 어떤 action representation을 썼는지, VLA inference rate와 control rate가 얼마였는지, safety shield가 개입했는지, glass와의 최소 거리가 얼마였는지, 실패했다면 grasp 실패인지 collision risk인지 placement instability인지 기록해야 한다. 이런 기록이 없으면 다음 학습 loop에서 무엇을 고쳐야 하는지 알 수 없고, benchmark score가 실제 capability를 얼마나 대표하는지도 판단하기 어렵다. [CITATION: Open X-Embodiment; DROID; vla-eval; BeTTER]

이 section의 핵심은 하나다. **언어 명령은 action이 아니라 action을 조직하는 task semantics이고, VLA action은 motor command가 아니라 controller와 safety layer가 해석해야 하는 policy-level proposal이다.** 이 구분을 놓치면 VLA를 과대평가하거나 과소평가하게 된다. 과대평가는 semantic understanding이 physical executability를 자동으로 만든다고 믿는 데서 온다. 과소평가는 반대로 VLA를 단순한 action regressor로만 보고, language와 vision이 task structure, affordance, recovery reasoning을 제공할 수 있다는 점을 놓치는 데서 온다.

Section 1.2는 실행 경로를 보였다. 그러나 아직 각 layer의 이름, 입력, 출력, 책임 경계를 정식으로 고정하지는 않았다. 다음 Section 1.3에서는 이 경로를 다섯 개 layer의 Real VLA stack으로 정리한다. 그때 Table 1.1은 embodied reasoning, VLA policy, motion/control, safety/assurance, data/evaluation layer가 각각 무엇을 받고 무엇을 내보내며 어디까지 책임지는지를 한 번에 보여줄 것이다.

## Citation Placeholders for Later Integration

- **[C1.2-1] STRIPS; PDDL; Ghallab/Nau/Traverso; LaValle** - language goal, task semantics, planning structure, motion feasibility의 배경.
- **[C1.2-2] SayCan; Code as Policies; PaLM-E; VoxPoser** - LLM/VLM planning, skill/tool/controller 호출, affordance grounding의 bridge evidence.
- **[C1.2-3] Khatib; Hogan; MPC; WBC** - policy-level action과 physical controller command의 차이를 설명하는 control evidence.
- **[C1.2-4] Gemini Robotics-ER; Gemini Robotics; GR00T** - ER layer, VLA policy, humanoid/deployment stack의 최신 case study.
- **[C1.2-5] Open X-Embodiment; DROID; BridgeData V2** - action-labeled robot data와 embodiment/action metadata 필요성.
- **[C1.2-6] vla-eval; BeTTER; ASIMOV-style safety/eval work** - evaluation, diagnostic benchmark, safety evidence가 execution path의 일부라는 근거.

## Revision Notes

- This is the first draft of Section 1.2 based on Section 1.1 v0.2.
- It uses the mug/drying-rack/glass example as the running execution path.
- It includes Box 1.2 for ER vs VLA policy boundary.
- It introduces Figure 1.1 as a described placeholder, not a rendered diagram.
- It defers formal five-layer stack definition to Section 1.3.
