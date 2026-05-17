# Chapter 1. What Is a Real VLA System? - Section Draft v0.2

## 1.1 Why Real VLA Is Not Just a Bigger VLM

로봇에게 "테이블 위의 머그컵을 들어 싱크대 옆에 놓아라"라고 지시했다고 하자. 큰 VLM은 장면을 설명하고, 컵과 싱크대를 찾아내고, 사용자의 의도를 자연어로 풀어낼 수 있다. 하지만 실제 로봇에게 필요한 것은 그 설명 자체가 아니다. 로봇은 카메라 영상, 깊이 정보, 관절 상태, 그리퍼 상태, 접촉 가능성, 속도 제한, 충돌 위험, 작업 순서, 실패 복구 가능성을 모두 고려하면서 시간에 따라 변하는 물리계 안에서 행동해야 한다. 따라서 Real VLA의 질문은 "모델이 장면을 이해했는가?"가 아니라 "그 이해가 안전하고 실행 가능한 action으로 변환되었는가?"이다.

이 차이가 VLM과 VLA를 가르는 첫 번째 경계이다. VLM은 주로 image와 text 사이의 의미적 대응을 학습한다. 반면 VLA는 vision, language, action 사이의 폐루프 대응을 다룬다. 여기서 action은 텍스트 답변처럼 한 번 출력하면 끝나는 symbol이 아니라, 로봇의 동역학과 제어기, 센서 지연, 환경 접촉, 안전 제약을 통과해야 하는 실행 객체이다. 그래서 VLA를 단순히 "VLM 뒤에 action head를 붙인 모델"로 정의하면 실제 로봇 시스템에서 가장 중요한 부분이 사라진다. Action head가 어떤 형식의 행동을 내는지, 그 행동이 어떤 controller로 들어가는지, 그 사이에서 safety shield가 무엇을 차단하는지, 실패했을 때 누가 replanning을 하는지가 모두 Real VLA의 일부이다. [CITATION: RT-1, RT-2, OpenVLA]

이 책에서 사용하는 Real VLA라는 표현은 특정 모델 이름이 아니라 시스템 관점을 뜻한다. 최소한의 VLA model은 observation과 instruction을 입력으로 받아 action을 예측하는 policy일 수 있다. 그러나 실제 배치 가능한 Real VLA system은 그보다 넓다. 상위 embodied reasoning layer는 장면, 언어, 기억, 목적을 해석하고 작업을 분해한다. VLA policy layer는 현재 관측과 목표를 바탕으로 action token, waypoint, delta pose, action chunk, 또는 연속 action distribution을 생성한다. Motion/control layer는 이 출력을 궤적, 속도, 힘, 임피던스, 또는 whole-body command로 변환한다. Safety layer는 semantic, geometric, dynamic, runtime constraint를 검사한다. Data/evaluation layer는 어떤 행동이 성공했고 어떤 상황에서 실패했는지 다시 학습과 평가로 되돌린다.

여기서 말하는 layer는 반드시 별도의 모듈이나 별도의 neural network를 뜻하지 않는다. 현대 VLA system에서는 perception, memory, reasoning, action head, controller wrapper가 하나의 service나 하나의 모델 안에 부분적으로 합쳐질 수 있다. 그러나 구현이 통합되어도 책임은 통합되지 않는다. 이 책에서 layer는 시스템이 져야 하는 기능적 책임의 분해이다. ER layer는 무엇을 해야 하는지, 무엇이 중요한지, 어떤 제약이 있는지를 구조화한다. VLA policy layer는 그 구조화된 의도와 현재 observation을 robot action representation으로 변환한다. Motion/control layer는 그 action proposal을 실제 로봇이 추적할 수 있는 command로 해석한다.

**Real VLA의 핵심은 지능을 하나의 거대한 모델에 가두는 것이 아니라, task semantics와 embodied perception이 physical control로 넘어가는 interface를 어떻게 설계하느냐에 있다.** 이 문장이 이 책의 출발점이다. 로봇공학자의 관점에서 VLA는 classical robotics를 대체하는 기술이 아니라, classical robotics가 풀어온 문제를 새로운 표현 학습과 데이터 스케일링 위에서 다시 조직하는 기술이다. 안정성, 제약 만족, 접촉 제어, 모션 feasibility, 상태 추정, 복구 전략은 VLM의 파라미터 수가 커진다고 사라지지 않는다. 오히려 VLA가 실제 로봇에 가까워질수록 이 문제들은 더 선명하게 드러난다. [CITATION: Khatib; Hogan; Mayne et al.; Murray, Li, and Sastry]

### Box 1.1. VLA is not a controller replacement

VLA는 controller를 없애는 기술이 아니다. VLA가 action을 생성하더라도, 그 action은 반드시 어떤 형태의 execution interface를 거친다. 이 interface는 joint-level servo일 수도 있고, end-effector controller일 수도 있고, impedance controller, MPC, trajectory optimizer, whole-body controller일 수도 있다. Real VLA의 설계 문제는 learned policy와 classical controller 중 하나를 선택하는 것이 아니라, 둘의 경계를 어디에 둘 것인지 결정하는 것이다.

이 책에서는 VLA policy가 제안하는 policy-level action `a_t`와 controller가 실제 로봇 또는 servo loop에 보내는 low-level command `u_t`를 구분한다. `a_t`는 waypoint, delta pose, skill call, action token, action chunk, 또는 action distribution일 수 있다. 반면 `u_t`는 joint position, velocity, torque, impedance target, whole-body command처럼 특정 controller와 robot driver가 해석하는 물리 명령이다. 이 구분은 notation의 문제가 아니라 책임 경계의 문제이다. VLA가 어떤 action type을 출력하는지에 따라 controller가 떠안는 부담, safety shield가 검사할 수 있는 조건, evaluation이 측정해야 할 지표가 모두 달라진다.

고전 제어와 모션플래닝은 이 지점에서 다시 현재형 도구가 된다. 컵을 집는 작업에서 VLA가 "컵을 잡아라"라는 subgoal이나 end-effector delta를 낼 수는 있다. 그러나 그 명령이 gripper의 접근 방향, 충돌 없는 궤적, 접촉 순간의 힘 제어, 미끄러짐에 대한 보정, 관절 한계와 속도 제한을 자동으로 보장하지는 않는다. Operational space control, impedance control, MPC, trajectory optimization, TAMP 같은 도구는 여전히 VLA output을 물리적으로 실행 가능한 motion으로 바꾸는 데 필요하다. 그러므로 VLA의 성능을 논할 때는 model architecture만 볼 수 없고, action이 어떤 control boundary를 통과하는지 함께 봐야 한다. [CITATION: OSC; impedance control; MPC; TAMP]

로봇러닝의 역사도 같은 이유로 중요하다. VLA 이전에도 behavior cloning, DAgger, visuomotor policy, guided policy search, visual RL은 image-to-action mapping을 학습하려고 했다. VLA가 새롭게 가져온 것은 언어와 시각 foundation model의 표현력을 robot policy에 결합했다는 점이다. 하지만 imitation learning의 covariate shift, offline dataset의 coverage 문제, distribution shift에서의 recovery 문제는 그대로 남아 있다. 더 많은 언어-시각 지식이 들어왔다고 해서 로봇 데이터의 희소성, embodiment gap, action label의 불일치, 실제 환경의 예측 불가능성이 자동으로 해결되는 것은 아니다. [CITATION: DAgger; Guided Policy Search; QT-Opt; Open X-Embodiment; DROID]

이 때문에 Real VLA는 모델만의 문제가 아니라 데이터 엔진, 평가 프로토콜, 안전 계층의 문제이기도 하다. 대규모 웹데이터에서 학습한 VLM은 세계에 대한 풍부한 상식을 가질 수 있지만, 로봇 action-labeled data는 비싸고 느리며 embodiment마다 다르다. 한 로봇의 joint position command는 다른 로봇의 end-effector delta command와 직접 대응하지 않는다. 시뮬레이션 benchmark에서 높은 success rate를 보인 policy도 실제 로봇에서는 calibration error, sensor latency, friction, cable, lighting, human interference, actuator saturation 때문에 다르게 동작할 수 있다. 따라서 benchmark score는 robot capability의 일부 증거일 수는 있어도 그 자체가 능력의 완전한 정의는 아니다. [CITATION: Open X-Embodiment; DROID; vla-eval; BeTTER]

최신 시스템들이 다시 계층형 구조로 향하는 것도 이 때문이다. 어떤 시스템은 큰 VLM이나 embodied reasoning model이 느리지만 강한 장면 이해와 작업 분해를 담당하고, 더 작은 policy나 diffusion/flow action model이 빠른 trajectory generation을 담당한다. 어떤 시스템은 VLA가 직접 low-level command를 내기보다 waypoint, affordance map, skill call, 또는 intermediate goal을 내고 classical planner나 controller가 실행을 맡는다. 이 흐름은 과거의 모듈식 로봇공학으로 단순 회귀하는 것이 아니다. 의미, 시각, 행동, 제약, 데이터, 안전을 어떤 경계에서 나누고 어떤 경계에서 학습할 것인지 다시 설계하는 일이다. [CITATION: Gemini Robotics-ER; Gemini Robotics; GR00T; pi0; OpenVLA-OFT; FAST]

따라서 이 장의 목적은 VLA를 하나의 유행어가 아니라 하나의 시스템 stack으로 정의하는 것이다. 앞으로의 장에서는 action representation, data engine, evaluation, safety를 각각 깊게 다루겠지만, 먼저 독자는 Real VLA가 왜 model-only framing으로는 설명되지 않는지 이해해야 한다. VLA가 어떤 입력을 받고 어떤 출력을 내는지보다 더 중요한 질문은, 그 출력이 어떤 로봇 제어 인터페이스를 통해 물리 세계에 작용하고, 그 과정에서 어떤 실패가 감지되고, 어떤 데이터로 다시 개선되는지이다.

### Bridge to Section 1.2

Section 1.1이 Real VLA를 model-only framing에서 분리했다면, Section 1.2는 이 분리를 더 명확한 계층 구조로 바꾼다. 다음 절에서는 이 mug 예제를 따라가며 자연어 instruction이 어떻게 embodied reasoning, VLA policy, motion/control, safety-assurance, data-evaluation layer를 통과하는지 분해한다. 이 과정에서 Figure 1.1은 Real VLA System Stack을, Table 1.1은 각 layer의 input, output, responsibility, failure mode를 정리한다.

## Citation Placeholders for Later Integration

- **[C1.1-1] RT-1, RT-2, OpenVLA** - VLM/VLA backbone과 robot action prediction이 결합되는 흐름의 대표 사례.
- **[C1.1-2] Khatib; Hogan; Mayne et al.; Murray, Li, and Sastry** - VLA output이 physical control boundary를 통과해야 한다는 주장에 배치.
- **[C1.1-3] OSC; impedance control; MPC; TAMP** - VLA action proposal과 controller/planner interface의 근거.
- **[C1.1-4] DAgger; Guided Policy Search; QT-Opt** - VLA 이전 image-to-action robot learning 계보와 distribution shift 문제.
- **[C1.1-5] Open X-Embodiment; DROID; BridgeData V2; OpenVLA** - robot data scaling과 embodiment/action-space mismatch.
- **[C1.1-6] Diffusion Policy; ACT/ALOHA; pi0; FAST; OpenVLA-OFT** - action representation이 control boundary라는 Ch13 bridge.
- **[C1.1-7] vla-eval; BeTTER; ASIMOV-style safety/eval work** - benchmark score, diagnostic evaluation, safety evidence를 구분하기 위한 Ch16/Ch19 bridge.
- **[C1.1-8] Gemini Robotics-ER / Gemini Robotics; GR00T; Figure Helix** - 최신 ER+VLA, humanoid, deployment case study. Ch1에서는 landscape teaser로만 사용하고 상세 판단은 Ch17/Ch19/Ch20으로 넘긴다.

## Revision Notes

- v0.2는 v0.1의 구조를 유지하고 gate review에서 지적된 boundary/citation 문제만 보강했다.
- Real VLA layer가 별도 모듈이 아니라 functional responsibility라는 점을 명시했다.
- ER layer와 VLA policy layer의 역할 차이를 한 문단으로 고정했다.
- `a_t`와 `u_t`의 차이를 Box 1.1 직후에 추가해 Ch13으로 넘어갈 control boundary를 강화했다.
- Section 1.2로 넘어가는 bridge에 Figure 1.1과 Table 1.1 preview를 추가했다.
