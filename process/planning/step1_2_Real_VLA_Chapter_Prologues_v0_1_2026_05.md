# Real VLA: A Roboticist’s Perspective
## Chapter Prologue Drafts v0.1

**Date:** 2026-05-12
**Purpose:** 21장 전체에 들어갈 본문형 프롤로그 초안. 각 장은 문제의식, 로봇공학적 배경, VLA 관점의 전환, 독자에게 남길 질문을 포함한다.

## Part 0. Orientation

### Chapter 1. What Is a Real VLA System? — 무엇이 ‘진짜 VLA 시스템’인가

#### Prologue

Vision-Language-Action이라는 이름은 매력적이다. 이미지와 언어를 넣으면 로봇 액션이 나온다는 설명은 간결하고, 최근 로봇 파운데이션 모델의 성과를 한 문장으로 포장하기에도 좋다. 그러나 실제 로봇을 움직여 본 사람에게 이 설명은 너무 짧다. 로봇은 텍스트 생성기처럼 다음 토큰만 맞히면 되는 시스템이 아니다. 로봇은 자신의 몸을 가진 물리 시스템이고, 액션은 곧 힘, 속도, 접촉, 지연, 충돌 가능성으로 이어진다.

이 책의 첫 장은 그래서 VLA를 하나의 모델명이 아니라 하나의 시스템 경계로 정의하는 데서 출발한다. Real VLA는 카메라 이미지와 자연어 명령을 받아 저수준 motor command를 바로 뱉는 거대한 신경망 하나가 아니다. 그것은 perception, language grounding, proprioception, temporal memory, action policy, motion generation, low-level control, runtime monitoring, safety intervention이 연결된 embodied stack이다. 어떤 구현은 이 stack의 많은 부분을 하나의 모델 안으로 흡수하고, 어떤 구현은 reasoning model, VLA policy, controller, verifier를 분리한다. 중요한 것은 어느 쪽이 더 ‘순수한’가가 아니라, 물리 세계에서 닫힌 루프로 작동하느냐이다.

VLA를 제대로 이해하려면 ‘모델이 무엇을 출력하는가’보다 ‘그 출력이 시스템 어디에 꽂히는가’를 먼저 물어야 한다. 어떤 VLA는 end-effector delta pose를 낸다. 어떤 VLA는 joint position target을 낸다. 어떤 VLA는 action chunk를 생성하고, 어떤 VLA는 high-level subgoal만 내고 실제 궤적은 planner가 만든다. 같은 VLA라는 이름 아래에서도 control boundary, time horizon, safety responsibility, embodiment assumption은 크게 다르다. 이 차이를 보지 못하면 논문 성능표는 이해해도 실제 로봇 시스템은 이해하지 못한다.

이 장은 책 전체의 map이다. 앞으로 우리는 state estimation, control interface, contact, planning, imitation learning, VLM, Robotics Transformer, action representation, data engine, evaluation, safety, humanoid deployment를 차례로 다룬다. 하지만 이 모든 장의 중심 질문은 하나로 모인다. VLA는 로봇공학을 대체하는가, 아니면 로봇공학의 오래된 문제들을 새로운 interface 아래 다시 조직하는가? 이 책의 답은 후자다. Real VLA는 로봇공학을 지우는 모델이 아니라, 로봇공학의 여러 계층을 언어와 시각 중심의 embodied policy interface로 재배열하는 시스템이다.

#### 이 장이 던지는 질문

- VLA를 단일 모델이 아니라 시스템 stack으로 정의해야 하는 이유는 무엇인가?
- VLA의 output interface는 low-level control, planning, safety 책임을 어떻게 바꾸는가?
- ‘real’ VLA를 논문 benchmark용 VLA와 구분하는 기준은 무엇인가?

## Part I. Physical Foundations for VLA

### Chapter 2. State, Dynamics, and Estimation — 상태, 동역학, 상태추정

#### Prologue

로봇공학에서 가장 오래된 질문 중 하나는 단순하다. 지금 로봇은 어디에 있고, 무엇을 하고 있으며, 다음 순간 어디로 갈 것인가? VLA 시대가 되어도 이 질문은 사라지지 않는다. 오히려 더 중요해진다. 카메라 이미지는 풍부한 정보를 담고 있지만 그 자체가 로봇의 상태는 아니다. 언어 명령은 목표를 표현하지만 관절각, 속도, 접촉력, 물체 pose, occlusion, latency를 해결해 주지는 않는다. 실제 로봇은 항상 부분적으로만 관측되고, 센서는 noisy하며, 세계는 움직이고, 액션은 지연되어 반영된다.

많은 VLA 논문은 observation이라는 단어로 이미지, 언어, proprioception을 한꺼번에 묶는다. 이 표기는 편리하지만 위험하다. observation은 state가 아니다. 로봇이 본 것과 로봇이 실제로 알아야 하는 것은 다르다. 컵이 카메라에 보인다는 것과 컵의 graspable pose를 알고 있다는 것은 다르고, 손목 카메라가 문손잡이를 본다는 것과 현재 접촉 상태를 알고 있다는 것도 다르다. VLA가 생성한 액션이 안정적인 동작으로 이어지려면, perception과 control 사이에는 항상 state estimation이라는 해석 계층이 존재한다.

이 장은 Kalman filtering, Bayesian estimation, robot dynamics, partial observability를 단순한 고전 이론으로 소개하지 않는다. 우리는 이 개념들이 왜 현대 VLA에서도 그대로 살아 있는지 본다. VLA가 high-level semantic reasoning을 잘하더라도, 로봇이 자신의 end-effector 위치를 부정확하게 알고 있거나 object pose가 잘못 추정되어 있으면 task는 실패한다. 반대로 좋은 state representation은 작은 모델도 강하게 만든다. 어떤 정보를 proprioception으로 넣을지, 어떤 정보를 vision encoder가 맡을지, 어떤 정보를 controller가 추정하게 둘지는 VLA 설계의 핵심 결정이다.

이 장의 목표는 독자가 ‘이미지를 넣었으니 로봇이 세계를 안다’는 생각에서 벗어나게 하는 것이다. Real VLA는 observation을 action으로 매핑하는 함수가 아니라, 불완전한 관측으로부터 충분히 쓸 만한 상태를 구성하고, 그 상태 위에서 물리적으로 실행 가능한 action을 생성하는 닫힌 루프 시스템이다. 상태추정은 과거의 robotics appendix가 아니라, VLA가 hallucination이 아닌 embodied action을 하게 만드는 첫 번째 안전장치다.

#### 이 장이 던지는 질문

- 왜 observation과 state를 구분해야 하는가?
- VLA에서 proprioception, visual state, memory는 어떤 역할을 나누어 갖는가?
- 상태추정 오류는 language-conditioned manipulation에서 어떤 실패로 나타나는가?

### Chapter 3. Control Interfaces — 제어 인터페이스

#### Prologue

VLA 논문에서 action이라는 단어는 자주 너무 쉽게 쓰인다. 하지만 로봇공학자에게 action은 하나의 단어가 아니라 하나의 계약이다. 이 계약은 모델이 무엇을 예측하고, controller가 무엇을 보장하며, hardware가 어떤 위험을 감수하는지를 정한다. joint position target, joint velocity, torque, end-effector delta pose, gripper command, impedance parameter, waypoint, trajectory, action chunk는 모두 action이라고 부를 수 있지만, 물리적 의미와 실패 양상은 전혀 다르다.

제어 인터페이스는 VLA의 성능을 결정하는 숨은 변수다. 같은 데이터와 같은 backbone을 사용해도 action space가 달라지면 학습 난이도, smoothness, latency tolerance, safety envelope, embodiment transfer가 달라진다. end-effector delta pose는 manipulation 데이터 수집과 multi-robot transfer에는 편리하지만, contact-rich task에서는 force regulation이 부족할 수 있다. torque command는 표현력이 크지만 학습과 안전 검증이 어렵다. waypoint는 planning과 잘 맞지만 reactive correction이 느릴 수 있다. 이 선택들은 단순한 engineering detail이 아니라 모델이 배워야 할 문제 자체를 바꾼다.

이 장은 고전 제어에서 말하는 inner loop와 outer loop, joint space와 task space, position/velocity/torque control, operational-space command를 VLA 관점에서 다시 읽는다. VLA가 직접 motor command를 내야 하는가, 아니면 controller가 추적할 target을 내야 하는가? action chunk를 내는 모델은 어느 주파수로 실행되어야 하는가? learned policy가 불확실할 때 controller가 어떻게 motion을 제한해야 하는가? 이런 질문은 architecture diagram보다 deployment에서 더 중요하다.

Real VLA를 만드는 첫 번째 practical decision은 거대한 모델을 고르는 것이 아니라, 모델이 로봇과 어떤 언어로 대화할지를 정하는 것이다. 자연어가 인간과 VLA 사이의 interface라면, action representation은 VLA와 로봇 몸 사이의 interface다. 이 장은 그 interface를 설계하는 법을 다룬다.

#### 이 장이 던지는 질문

- VLA의 action space는 왜 모델 구조만큼 중요한가?
- joint-space action과 task-space action은 각각 어떤 deployment trade-off를 갖는가?
- low-level controller와 VLA policy 사이의 책임 경계는 어떻게 정해야 하는가?

### Chapter 4. Contact, Force, and Manipulation — 접촉, 힘, 조작

#### Prologue

로봇 조작의 본질은 접촉이다. 물체를 집고, 밀고, 넣고, 돌리고, 닦고, 접고, 여는 모든 작업은 결국 로봇과 환경 사이의 물리적 상호작용으로 귀결된다. 화면에서는 ‘pick up the mug’라는 명령이 단순해 보이지만, 실제 로봇에게 이 명령은 surface normal, friction, compliance, grasp closure, contact force, slip, collision, object deformation의 문제로 바뀐다. VLA가 언어와 이미지를 잘 이해해도 접촉을 잘 다루지 못하면 조작은 실패한다.

많은 end-to-end policy는 성공 demonstration을 통해 contact behavior를 암묵적으로 배운다. 이 방식은 놀라울 정도로 강력할 수 있지만, contact-rich manipulation에서는 한계도 명확하다. 접촉은 discontinuous하고, 작은 pose error가 큰 force error로 바뀌며, 카메라로 보이지 않는 힘이 task outcome을 결정한다. 로봇이 drawer handle을 잡는 순간, peg를 hole에 넣는 순간, cloth를 당기는 순간, action은 더 이상 기하학적 이동만이 아니다. 그때부터는 force regulation과 compliance가 중심이 된다.

이 장은 hybrid position/force control, impedance control, admittance control, grasp stability, tactile and force sensing을 VLA의 언어로 다시 해석한다. VLA가 낸 waypoint를 impedance controller가 따라가게 할 때 어떤 장점이 있는가? learned policy가 contact mode를 암묵적으로 예측할 수 있는가? tactile feedback은 VLA observation에 어떻게 들어가야 하는가? safety filter는 force limit을 어떤 방식으로 적용해야 하는가? 이런 질문은 dexterous manipulation과 humanoid manipulation으로 갈수록 더 중요해진다.

이 장의 중심 메시지는 단순하다. 조작 VLA의 성능은 semantic understanding만으로 결정되지 않는다. 로봇이 세계를 ‘이해한다’는 말은 물체 이름을 맞힌다는 뜻이 아니라, 그 물체와 어떻게 안전하게 접촉하고, 힘을 조절하고, 실패를 감지하고, 다시 시도할 수 있는지를 안다는 뜻이다. Real VLA에서 contact는 예외 상황이 아니라 action의 기본 문법이다.

#### 이 장이 던지는 질문

- 언어로 표현된 manipulation goal은 어떤 contact/control problem으로 변환되는가?
- VLA policy와 impedance/force controller는 어떻게 결합될 수 있는가?
- contact-rich task에서 vision-only policy가 놓치기 쉬운 정보는 무엇인가?

### Chapter 5. Planning, Motion Planning, and TAMP — 계획, 모션플래닝, TAMP

#### Prologue

로봇에게 ‘식탁을 치워라’라고 말하는 것은 하나의 action을 요구하는 것이 아니다. 그것은 컵을 찾고, 잡을 수 있는 위치로 이동하고, 장애물을 피하고, 컵을 들어 올리고, 싱크대나 트레이를 찾고, 놓을 장소를 결정하고, 중간 실패를 복구하는 긴 과정이다. 인간에게는 하나의 명령이지만 로봇에게는 discrete decision과 continuous motion이 얽힌 장기 문제다. 이 문제를 다루기 위해 로봇공학과 AI는 오래전부터 planning, motion planning, task-and-motion planning을 발전시켜 왔다.

LLM과 VLM이 등장하면서 planning은 다시 주목받고 있다. 하지만 이 흐름은 완전히 새로운 것이 아니다. A*, STRIPS, PDDL, GraphPlan은 이미 goal, action, precondition, effect, search, heuristic이라는 구조를 만들었다. PRM, RRT, trajectory optimization은 continuous configuration space에서 feasible path를 찾는 법을 제공했다. TAMP는 symbolic task decision과 geometric feasibility를 연결했다. 오늘날 VLA가 subgoal이나 affordance를 생성한다면, 그 출력은 여전히 motion feasibility와 constraint satisfaction을 통과해야 한다.

이 장은 고전 planning을 nostalgia로 다루지 않는다. 오히려 VLA가 왜 다시 planner와 결합되는지 설명하기 위한 현재형 도구로 다룬다. 순수 end-to-end VLA는 short-horizon manipulation에서는 강력할 수 있지만, long-horizon task에서는 goal decomposition, resource constraint, object relation, reversible/irreversible action, recovery plan이 필요하다. 반대로 고전 planner는 명시적 구조와 검증 가능성이 있지만 open-world perception과 language grounding에는 약하다. Real VLA는 이 두 세계의 장단점을 다시 조합한다.

이 장의 목적은 독자에게 하나의 균형 감각을 주는 것이다. VLA가 planning을 대체한다고 보는 관점도, planning이 VLA를 단순 executor로만 사용한다고 보는 관점도 부족하다. 미래의 강한 로봇 시스템은 semantic reasoning, learned affordance, symbolic abstraction, geometric planning, controller-level feasibility를 하나의 loop로 묶을 것이다. 이 장은 그 loop의 고전적 뿌리와 현대적 재구성을 함께 다룬다.

#### 이 장이 던지는 질문

- LLM/VLA planning과 고전 symbolic planning은 어떤 문제를 공유하는가?
- motion feasibility는 language-conditioned task planning에서 왜 병목이 되는가?
- TAMP는 VLA system stack에서 어떤 위치를 차지할 수 있는가?

## Part II. Learning Before VLA

### Chapter 6. Imitation Learning and Covariate Shift — 모방학습과 covariate shift

#### Prologue

현재의 많은 VLA는 겉으로는 foundation model처럼 보이지만, 학습의 핵심에는 여전히 imitation learning이 있다. 로봇이 본 demonstration을 따라 하고, 관측과 명령이 주어졌을 때 사람이 했을 법한 action을 예측한다. 이 아이디어는 직관적이고 실용적이다. reward를 설계하지 않아도 되고, 복잡한 조작 기술을 사람의 시연에서 바로 배울 수 있다. 그러나 imitation learning은 시작부터 하나의 깊은 문제를 품고 있다. 학습 데이터 속의 로봇과 실제 배치된 로봇은 같은 상태분포 위에 있지 않다.

Behavior cloning은 expert trajectory 안에서는 그럴듯하다. 하지만 policy가 작은 실수를 하면 로봇은 demonstration dataset에서 거의 보지 못한 상태로 들어간다. 이때 policy는 더 큰 실수를 하고, 실수는 다시 상태분포를 밀어낸다. 이 현상이 covariate shift다. VLA에서도 문제는 동일하다. 거대한 VLM backbone, 대규모 로봇 데이터, 언어 조건이 붙어도, closed-loop execution 중 policy가 training distribution 밖으로 나가면 모델은 자신이 무엇을 모르는지 모른 채 action을 계속 생성할 수 있다.

이 장은 DAgger, dataset aggregation, offline imitation, failure data, correction data를 VLA 시대의 언어로 다시 읽는다. VLA fine-tuning에서 어떤 demonstration을 모아야 하는가? 성공 trajectory만으로 충분한가? 실패 직전의 상태, recovery action, human correction은 어떻게 데이터셋에 들어가야 하는가? multi-task VLA가 특정 task에서 실패할 때 그것은 model capacity 부족인가, 데이터분포 문제인가, action interface 문제인가? 이런 질문은 단순히 학습 알고리즘의 선택을 넘어 데이터 엔진 설계로 이어진다.

모방학습은 VLA의 과거가 아니라 현재다. 차이는 scale과 conditioning이다. 예전에는 한 task의 이미지와 action을 모방했다면, 이제는 수천 task, 여러 embodiment, language instruction, visual context를 함께 모방한다. 하지만 distribution shift라는 핵심 문제는 그대로 남아 있다. Real VLA를 만들려면 좋은 demonstration을 많이 모으는 것뿐 아니라, policy가 틀렸을 때 어떤 상태로 빠지는지, 그 상태에서 어떻게 복구할지를 데이터와 시스템 양쪽에서 설계해야 한다.

#### 이 장이 던지는 질문

- behavior cloning의 covariate shift는 VLA fine-tuning에서 어떻게 나타나는가?
- 성공 demonstration, 실패 demonstration, correction data는 각각 어떤 역할을 하는가?
- imitation learning 기반 VLA의 closed-loop 안정성은 어떻게 평가해야 하는가?

### Chapter 7. RL, Optimal Control, and Control as Inference — 강화학습, 최적제어, 추론으로서의 제어

#### Prologue

로봇이 demonstration을 따라 하는 것만으로 충분하지 않을 때, 우리는 다시 목적함수로 돌아간다. 무엇을 최대화할 것인가? 어떤 제약을 지켜야 하는가? 위험과 탐색을 어떻게 균형 잡을 것인가? 이 질문은 강화학습의 질문이기도 하고, 최적제어의 질문이기도 하다. VLA 시대에도 reward, cost, constraint, uncertainty, exploration은 사라지지 않는다. 단지 그 위에 language instruction과 visual context가 얹혔을 뿐이다.

최적제어는 로봇을 물리 시스템으로 보고, 목표와 제약 아래에서 trajectory나 control sequence를 계산한다. 강화학습은 환경과의 상호작용을 통해 policy를 개선한다. 두 흐름은 역사적으로 다른 언어를 사용했지만, 현대 로봇러닝에서는 점점 가까워졌다. model-based RL, guided policy search, maximum entropy RL, control as probabilistic inference는 이 경계를 흐리게 만들었다. 특히 action distribution, uncertainty, entropy, trajectory probability를 다루는 관점은 diffusion policy와 flow-based VLA를 이해하는 데도 중요하다.

이 장은 VLA를 강화학습으로 ‘대체’하려는 장이 아니다. 오히려 강화학습과 최적제어가 VLA에 어떤 질문을 남겼는지 설명하는 장이다. VLA가 language-conditioned policy라면 reward는 어디에 있는가? human preference나 success detector는 reward 역할을 할 수 있는가? offline robot data로 학습한 VLA를 online으로 개선할 수 있는가? exploration이 위험한 실제 로봇에서 policy improvement는 어떻게 해야 하는가? controller나 planner가 최적화한 trajectory는 neural policy 학습에 어떻게 사용될 수 있는가?

Real VLA는 단순히 더 큰 behavior cloning model로만 발전하지 않을 가능성이 크다. 미래의 시스템은 imitation으로 초기 능력을 얻고, evaluation과 feedback으로 실패를 발견하고, 제한된 online interaction과 model-based optimization으로 스스로 개선될 것이다. 이 장은 그 미래를 이해하기 위한 수학적 언어를 제공한다. 강화학습과 최적제어는 VLA 이전의 유산이 아니라, VLA 이후에도 남을 policy improvement의 grammar다.

#### 이 장이 던지는 질문

- VLA에서 reward, cost, success signal은 어떤 형태로 나타날 수 있는가?
- optimal control과 RL은 action distribution 기반 VLA를 이해하는 데 어떤 도움을 주는가?
- 실제 로봇에서 online improvement를 안전하게 수행하려면 어떤 구조가 필요한가?

### Chapter 8. Visuomotor Policies — 비주얼-모터 정책

#### Prologue

언어가 로봇 정책의 중심에 들어오기 전, 로봇러닝의 큰 꿈은 이미지를 곧바로 action으로 바꾸는 것이었다. 카메라가 본 픽셀에서 grasp, pushing, reaching, insertion 같은 동작을 학습하고, 사람이 hand-engineered feature를 만들지 않아도 neural network가 필요한 representation을 찾게 하자는 아이디어였다. 이 흐름은 오늘날 VLA의 직접적인 조상이다. VLA에서 language가 추가되었지만, 실제 action을 만들어 내는 하위 문제는 여전히 visuomotor policy의 문제다.

Visuomotor policy는 로봇공학에 큰 가능성과 큰 교훈을 동시에 남겼다. 가능성은 명확했다. 충분한 데이터와 적절한 architecture가 있으면 raw image에서 실제 로봇 action까지 end-to-end로 학습할 수 있었다. 하지만 한계도 뚜렷했다. 데이터가 적으면 쉽게 overfit되고, 환경 변화에 약하며, long-horizon reasoning이 어렵고, 보이지 않는 접촉 상태를 추정하기 힘들었다. 이 한계들은 단순히 2010년대 모델의 약점이 아니라, VLA 시대에도 반복되는 structural problem이다.

이 장은 CNN/RNN 기반 policy, recurrent visuomotor control, real-robot grasping, attention, transformer policy, action parameterization을 다룬다. 특히 우리는 ‘image-to-action’이 어떤 형태로 성공했고 어떤 형태로 실패했는지 본다. 카메라 viewpoint, proprioception, temporal memory, gripper state, calibration, data augmentation, control frequency 같은 세부 요소들이 policy performance를 어떻게 좌우했는지 살펴본다. 이 요소들은 최신 VLA 논문에서도 종종 appendix나 implementation detail로 밀려나지만, 실제 배치에서는 핵심 변수다.

VLA는 visuomotor policy 위에 언어와 대규모 representation을 얹은 것이다. 따라서 VLA를 이해하려면 먼저 language가 없던 시절의 image-to-action 문제를 이해해야 한다. 이 장은 독자가 ‘VLA의 새로움’과 ‘visuomotor learning에서 이미 배운 교훈’을 구분하도록 돕는다. 새 backbone이 오래된 물리 문제를 자동으로 없애지는 않는다. 하지만 오래된 교훈을 잘 흡수하면, VLA는 훨씬 더 강한 embodied policy가 될 수 있다.

#### 이 장이 던지는 질문

- visuomotor policy의 성공과 실패는 현대 VLA에 어떤 교훈을 주는가?
- temporal memory와 proprioception은 image-to-action policy에서 왜 중요한가?
- 언어 조건이 추가되면서 visuomotor policy 문제는 어떻게 바뀌는가?

## Part III. Semantic Foundations

### Chapter 9. Transformers, VLMs, and Grounding — Transformer, VLM, grounding

#### Prologue

VLA가 가능해진 배경은 로봇공학 내부에만 있지 않다. 오히려 결정적인 전환은 언어와 시각 foundation model의 발전에서 왔다. Transformer는 sequence를 다루는 방식을 바꾸었고, vision transformer는 이미지를 token sequence로 재해석했으며, CLIP류의 모델은 이미지와 텍스트를 같은 표현공간에서 정렬했다. 이 흐름이 없었다면 ‘언어 명령을 이해하는 범용 로봇 정책’이라는 아이디어는 지금처럼 빠르게 구체화되지 못했을 것이다.

하지만 VLM의 grounding과 로봇의 grounding은 같지 않다. 인터넷 이미지와 caption을 통해 학습한 모델은 ‘컵’, ‘문’, ‘서랍’, ‘잡다’, ‘열다’라는 단어와 시각 패턴을 연결할 수 있다. 그러나 로봇에게 grounding은 거기서 끝나지 않는다. 컵은 grasp point와 mass distribution을 가진 물체이고, 문은 hinge constraint를 가진 mechanism이며, 서랍은 friction과 handle geometry를 가진 조작 대상이다. VLM이 보는 semantic world와 로봇이 행동해야 하는 physical world 사이에는 여전히 간극이 있다.

이 장은 Transformer, tokenization, attention, multimodal pretraining, contrastive learning, VLM architecture를 VLA 독자의 관점에서 설명한다. 우리는 VLM이 어떤 종류의 prior를 제공하는지, 어떤 종류의 knowledge transfer가 가능한지, 그리고 어떤 종류의 physical knowledge는 여전히 로봇 데이터나 controller가 맡아야 하는지 구분한다. foundation model의 강점은 open-vocabulary recognition, semantic association, instruction following, compositional language understanding에 있다. 약점은 contact, dynamics, force, calibration, embodiment-specific action에 있다.

Real VLA는 VLM을 blind faith로 받아들이지 않는다. VLM은 강력한 semantic prior이지만, 그 prior는 로봇 몸과 물리적 feedback을 통해 다시 검증되어야 한다. 이 장은 독자에게 ‘grounding’이라는 단어를 더 엄밀하게 보게 한다. 단어와 이미지의 정렬은 grounding의 시작이고, 물리적으로 성공하는 action까지 이어지는 닫힌 루프가 grounding의 완성이다.

#### 이 장이 던지는 질문

- VLM의 semantic grounding과 로봇의 embodied grounding은 어떻게 다른가?
- Transformer와 tokenization은 VLA architecture에 어떤 설계 자유도를 주는가?
- 인터넷 pretraining 지식은 robot action으로 어디까지 전이될 수 있는가?

### Chapter 10. LLM/VLM as Robot Planner — 로봇 planner로서의 LLM/VLM

#### Prologue

VLA가 등장하기 직전, 로봇 연구자들은 먼저 LLM과 VLM을 planner로 사용하기 시작했다. 이 시기의 시스템은 대개 언어모델이 high-level plan을 만들고, 로봇은 이미 갖고 있던 skill이나 controller를 호출하는 구조였다. 모델은 ‘컵을 집어라’라는 명령을 ‘컵을 찾는다, 접근한다, grasp skill을 실행한다, 지정된 위치에 놓는다’와 같은 sequence로 나누었다. 이 접근은 완전한 end-to-end VLA는 아니었지만, 언어 기반 로봇 reasoning이 어떤 가능성과 한계를 갖는지 선명하게 보여주었다.

LLM planner의 강점은 상식과 조합성이다. 사람의 명령이 모호하거나 긴 task로 이루어져 있을 때, LLM은 task를 분해하고 순서를 제안하며 필요한 도구나 skill을 호출할 수 있다. 그러나 실행 가능성은 별개의 문제다. 말로는 그럴듯한 plan이 로봇의 reachability, graspability, collision constraint, current scene state와 맞지 않을 수 있다. 그래서 SayCan, Code as Policies, Inner Monologue, VoxPoser 같은 흐름은 language reasoning을 robot affordance, visual feedback, executable code, value map, controller와 연결하려고 했다.

이 장은 LLM/VLM planner를 VLA의 전사로 다룬다. 여기서 중요한 것은 ‘LLM이 계획을 잘 짠다’는 단순한 결론이 아니다. 중요한 것은 language model이 로봇 시스템 안에서 어떤 역할을 맡을 수 있는지다. planner인가, code generator인가, success monitor인가, scene interpreter인가, tool router인가, human-robot dialogue interface인가? 이 역할 구분은 이후 hierarchical VLA와 embodied reasoning model을 이해하는 핵심 배경이 된다.

Real VLA는 LLM planner의 실패를 교훈으로 삼아야 한다. 언어적 타당성과 물리적 실행 가능성은 다르다. 좋은 로봇 planner는 세상에 대해 말할 수 있을 뿐 아니라, 자신이 말한 plan이 현재 로봇에게 가능한지 확인해야 한다. 이 장의 중심 질문은 그래서 다음과 같다. LLM/VLM은 로봇에게 무엇을 해줄 수 있고, 무엇을 해줄 수 없는가? 그리고 그 한계를 보완하기 위해 VLA, TAMP, controller, feedback loop는 어떻게 결합되어야 하는가?

#### 이 장이 던지는 질문

- LLM/VLM planner의 plan은 왜 executable하지 않을 수 있는가?
- affordance, skill library, controller는 language planner의 한계를 어떻게 보완하는가?
- LLM/VLM planner 흐름은 hierarchical VLA로 어떻게 이어지는가?

### Chapter 11. From Planner + Skills to VLA — Planner + skill에서 VLA로

#### Prologue

초기의 언어 기반 로봇 시스템은 대개 planner와 skill library의 결합이었다. LLM은 무엇을 할지 정하고, 로봇은 미리 정의된 grasp, place, navigate, open, push 같은 skill을 실행했다. 이 구조는 해석 가능하고 안전장치를 붙이기 쉬웠다. 하지만 한계도 분명했다. 새로운 작업은 기존 skill 조합으로 표현되지 않을 수 있고, skill boundary가 너무 딱딱하면 자연스러운 조작이 어려우며, perception과 action 사이의 미세한 feedback은 planner 수준에서 잘 처리되지 않는다.

VLA는 이 경계를 흐리게 만든다. 모델은 더 이상 단순히 skill name을 고르는 데서 멈추지 않고, observation과 language를 바탕으로 action 자체를 생성한다. 이것은 큰 전환이다. 언어적 목표, 시각적 장면, 로봇의 현재 상태가 하나의 policy 안에서 만나기 시작한다. 하지만 이 전환이 planner와 skill의 죽음을 의미하지는 않는다. 오히려 Real VLA에서는 planner, skill, controller, learned policy가 서로 다른 시간척도와 책임을 나누는 계층 구조로 재조립된다.

이 장은 modular robotics와 end-to-end VLA 사이의 연속선을 그린다. 한쪽 끝에는 symbolic planner와 hand-designed skill이 있고, 다른 쪽 끝에는 observation-to-action foundation policy가 있다. 실제 시스템은 대개 그 중간 어딘가에 있다. VLA가 low-level action을 내더라도 high-level task decomposition은 별도 reasoning model이 맡을 수 있다. 반대로 skill library가 존재하더라도 skill 내부의 parameter나 trajectory는 learned policy가 생성할 수 있다. 중요한 것은 모듈성 대 end-to-end라는 이분법을 넘어서 어떤 경계를 어디에 둘지 결정하는 것이다.

이 장은 책의 앞부분과 뒷부분을 연결하는 bridge다. 고전 planning과 VLM planner를 배운 독자는 이제 왜 VLA가 필요했는지 이해하게 된다. 동시에 action representation과 data engine으로 넘어가기 전에, VLA가 모든 것을 흡수하는 단일 모델이라는 환상도 버리게 된다. Real VLA는 planner + skill의 한계를 넘어서지만, 그들이 남긴 구조적 지혜를 버리지 않는다.

#### 이 장이 던지는 질문

- skill library 기반 시스템은 어떤 task에서 강하고 어떤 task에서 한계를 보이는가?
- end-to-end VLA는 planner + skill 구조의 어떤 부분을 흡수하는가?
- 모듈성과 학습 가능성 사이의 경계는 어떻게 설계해야 하는가?

## Part IV. VLA Core

### Chapter 12. Robotics Transformer Era — Robotics Transformer 시대

#### Prologue

로봇 action이 sequence modeling의 대상이 될 수 있다는 생각은 VLA 시대의 문을 열었다. 언어 문장을 token sequence로 보고 다음 token을 예측하듯이, 로봇 trajectory도 observation과 instruction이 주어졌을 때 다음 action을 예측하는 문제로 볼 수 있다. BC-Z, Gato, RT-1, PaLM-E, RT-2, RoboCat 같은 흐름은 이 관점을 각기 다른 방식으로 밀어붙였다. 이 시기부터 로봇 정책은 더 이상 task-specific controller나 small neural policy만이 아니라, 대규모 데이터와 transformer architecture를 활용하는 generalist policy로 다루어지기 시작했다.

Robotics Transformer 시대의 핵심은 scale이다. task 수, environment 다양성, language instruction, embodiment, model capacity가 함께 커지면서 로봇 정책은 single-task behavior cloning을 넘어섰다. 특히 RT 계열은 language-conditioned robot data와 web-scale vision-language knowledge를 연결하려고 했다. 이것은 단순한 engineering upgrade가 아니라 로봇학습 문제의 formulation 변화였다. 로봇 action은 더 이상 고립된 motor output이 아니라, language와 visual semantics가 결합된 sequence prediction target이 되었다.

하지만 이 시대의 성공은 동시에 다음 시대의 문제를 만들었다. action을 token처럼 다루는 접근은 VLM/LLM 학습 pipeline과 잘 맞지만, continuous control, high-frequency action, dexterous manipulation, latency-sensitive deployment에서는 제약을 드러냈다. 큰 모델은 좋은 semantic prior를 제공하지만, 로봇 손끝의 미세한 force control을 자동으로 해결하지는 않는다. multi-task generalization은 좋아졌지만, benchmark 밖의 perturbation과 real-world recovery는 여전히 어렵다.

이 장은 Robotics Transformer 시대를 찬양하거나 비판하는 데서 멈추지 않는다. 우리는 이 시기를 VLA의 첫 번째 완성형이자 두 번째 문제 제기의 출발점으로 읽는다. 이 장을 지나면 독자는 왜 RT-2가 중요했는지, 왜 OpenVLA가 의미 있었는지, 그리고 왜 이후 연구가 action chunking, diffusion, flow, efficient fine-tuning, data engine, evaluation으로 이동했는지 자연스럽게 이해하게 된다.

#### 이 장이 던지는 질문

- robot trajectory를 token sequence로 보는 관점은 무엇을 가능하게 했는가?
- Robotics Transformer 계열은 어떤 종류의 generalization을 보여주었고 어떤 한계를 남겼는가?
- RT-style VLA 이후 action representation 연구가 중요해진 이유는 무엇인가?

### Chapter 13. Action Representation — 액션 표현

#### Prologue

VLA에서 가장 중요한 질문은 ‘어떤 backbone을 쓰는가’만이 아니다. 더 근본적인 질문은 ‘action을 무엇으로 표현하는가’다. 로봇 action은 token일 수도 있고, continuous vector일 수도 있고, 여러 step을 묶은 chunk일 수도 있고, diffusion이나 flow를 통해 생성되는 trajectory distribution일 수도 있다. 이 선택은 모델의 출력 형식에 관한 사소한 결정이 아니다. 그것은 로봇 제어의 경계를 어디에 둘 것인지, 시간구조를 어떻게 다룰 것인지, 불확실성과 multimodality를 어떻게 표현할 것인지에 대한 결정이다.

Discrete action token은 VLM/LLM pipeline과 잘 맞는다. action을 단어처럼 다루면 web-pretrained model을 robot action으로 fine-tune하기 쉽고, language generation과 action generation 사이의 형태적 통일성이 생긴다. 하지만 continuous manipulation은 종종 token보다 더 부드럽고 높은 해상도의 표현을 요구한다. 단일 step action은 빠르게 누적오차를 만들 수 있고, high-frequency control은 inference latency와 충돌한다. 그래서 action chunking, ACT, diffusion policy, flow matching, action expert 같은 접근이 중요해졌다.

이 장은 action representation을 네 가지 축으로 비교한다. 첫째, action은 discrete인가 continuous인가. 둘째, 한 시점의 action인가 시간적으로 확장된 chunk인가. 셋째, deterministic prediction인가 distributional generation인가. 넷째, controller가 추적할 reference인가 robot hardware에 가까운 command인가. 이 축을 이해하면 RT-2, OpenVLA, ALOHA/ACT, Diffusion Policy, RDT, π0, FAST, OpenVLA-OFT 같은 연구들을 단순한 논문 목록이 아니라 하나의 설계 공간으로 볼 수 있다.

이 장의 핵심 메시지는 명확하다. Action representation은 output format이 아니라 control philosophy다. 실제 로봇에서 좋은 action representation은 학습이 잘되어야 할 뿐 아니라, smooth하고, 안전하고, 지연에 견디고, controller와 호환되고, 실패 복구가 가능해야 한다. Real VLA의 성패는 언어를 얼마나 잘 이해하느냐만큼이나, 그 이해를 어떤 시간적·물리적 action으로 번역하느냐에 달려 있다.

#### 이 장이 던지는 질문

- action token, action chunk, diffusion, flow는 각각 어떤 control boundary를 가정하는가?
- multimodal action distribution은 manipulation에서 왜 중요한가?
- action representation 선택은 latency, safety, embodiment transfer에 어떤 영향을 주는가?

### Chapter 14. Data Engines — 데이터 엔진

#### Prologue

VLA는 모델만으로 만들어지지 않는다. 오히려 2026년 현재, VLA의 진짜 경쟁력은 데이터 엔진에서 나온다고 해도 과장이 아니다. 웹 언어모델은 인터넷 규모의 텍스트와 이미지에 기대어 성장했지만, 로봇 데이터는 그런 방식으로 쉽게 수집되지 않는다. 로봇 trajectory는 비싸고 느리며, embodiment마다 action space가 다르고, sensor setup이 다르고, task success label이 모호하다. 게다가 real-world failure는 위험하고, rare event는 데이터셋에 잘 나타나지 않는다.

Open X-Embodiment, BridgeData, DROID, ALOHA, LIBERO, CALVIN, ManiSkill 같은 흐름은 이 문제에 대한 서로 다른 답이다. 어떤 데이터셋은 multi-embodiment scaling을 강조하고, 어떤 데이터셋은 in-the-wild teleoperation을 강조하며, 어떤 benchmark는 lifelong learning이나 simulation coverage를 제공한다. 중요한 것은 데이터가 단순한 파일 묶음이 아니라는 점이다. 수집 protocol, teleoperation interface, language annotation, success/failure labeling, action normalization, embodiment metadata, curation rule이 모두 데이터의 일부다.

이 장은 VLA data를 ‘많으면 좋은 것’이라는 수준에서 다루지 않는다. 우리는 어떤 데이터가 어떤 능력을 만들고, 어떤 데이터가 어떤 bias를 남기는지 본다. 성공 trajectory만 모으면 recovery를 배우기 어렵고, short-horizon demonstration만 모으면 long-horizon execution을 평가하기 어렵다. 한 로봇의 데이터만 쓰면 embodiment transfer가 어렵고, 여러 로봇의 데이터를 섞으면 action normalization과 embodiment representation 문제가 생긴다. simulation data는 scale을 주지만 sim-to-real gap을 만든다. human video는 semantic prior를 주지만 robot action label이 없다.

Real VLA에서 데이터 엔진은 모델 학습 이전의 준비물이 아니라 계속 돌아가는 시스템이다. 로봇은 배치 후 실패를 기록하고, human correction을 받고, 새로운 task를 수집하고, safety-critical edge case를 보강하고, 평가 결과를 다시 데이터 수집으로 연결해야 한다. 이 장은 VLA를 static pretrained model이 아니라 self-improving data loop 안에 놓는다. 좋은 VLA를 만들려면 좋은 architecture만큼이나 좋은 data operation이 필요하다.

#### 이 장이 던지는 질문

- 로봇 데이터는 웹 데이터와 어떤 점에서 근본적으로 다른가?
- multi-embodiment dataset은 어떤 일반화 능력과 어떤 normalization 문제를 동시에 만드는가?
- failure data와 recovery data는 Real VLA 데이터 엔진에서 왜 중요한가?

### Chapter 15. Adaptation and Fine-Tuning — 적응과 fine-tuning

#### Prologue

범용 VLA가 있다고 해서 곧바로 모든 연구실의 로봇을 잘 움직이는 것은 아니다. 로봇은 camera pose가 다르고, gripper가 다르고, action frequency가 다르고, joint limit과 calibration이 다르고, workspace와 task distribution이 다르다. 같은 ‘pick and place’라도 실험실마다 object set, table height, lighting, controller, reset protocol이 다르다. 따라서 generalist VLA를 실제 시스템에 넣는 순간, adaptation과 fine-tuning은 선택이 아니라 필수가 된다.

Fine-tuning은 단순히 마지막 layer를 학습하는 일이 아니다. VLA에서 adaptation은 embodiment adapter, action normalization, sensor remapping, language prompt style, data mixture, LoRA/full fine-tuning, offline evaluation, real-robot validation을 포함하는 system integration process다. 작은 데이터로 빠르게 적응하려면 pretrained representation을 보존해야 하지만, robot-specific behavior를 충분히 바꾸지 못하면 task는 실패한다. 반대로 aggressive fine-tuning은 catastrophic forgetting이나 unsafe overfitting을 만들 수 있다.

이 장은 Octo, OpenVLA, OpenVLA-OFT, FAST, VLA Foundry 같은 흐름을 중심으로 practical VLA adaptation을 다룬다. 어떤 경우에는 action head만 바꾸는 것이 충분하고, 어떤 경우에는 vision encoder나 language backbone까지 조정해야 한다. action chunking이나 continuous action objective는 fine-tuning efficiency를 크게 바꿀 수 있다. 데이터셋이 작을 때는 augmentation과 normalization이 성능을 좌우하고, real robot deployment에서는 inference speed와 control compatibility가 accuracy만큼 중요하다.

Real VLA의 진짜 가치는 foundation model 자체보다 그것을 특정 로봇과 특정 task ecology에 맞추는 능력에서 드러난다. 이 장의 목표는 독자가 ‘pretrained VLA를 가져와 fine-tune한다’는 말을 더 구체적으로 이해하게 하는 것이다. 무엇을 고정하고, 무엇을 학습하며, 어떤 데이터로 검증하고, 어떤 실패를 허용하지 않을 것인가? 이 질문에 답하는 과정이 바로 VLA deployment의 핵심이다.

#### 이 장이 던지는 질문

- pretrained VLA를 새 로봇에 옮길 때 어떤 mismatch가 발생하는가?
- LoRA, action-head tuning, full fine-tuning은 각각 어떤 상황에 적합한가?
- fine-tuning 성능을 실제 로봇에서 검증하려면 어떤 protocol이 필요한가?

### Chapter 16. Evaluation and Benchmarking — 평가와 벤치마킹

#### Prologue

로봇이 task를 성공했다는 말은 생각보다 복잡하다. 한 번 성공했는가, 여러 번 성공했는가, 어떤 초기조건에서 성공했는가, 얼마나 빠르게 성공했는가, 실패했을 때 안전하게 멈췄는가, distribution shift에서도 성공했는가, 사람의 개입 없이 성공했는가? VLA 논문에서 success rate는 가장 흔한 숫자지만, 그 숫자 하나로 로봇의 실제 능력을 설명하기는 어렵다. Benchmark score는 capability의 그림자이지 capability 그 자체가 아니다.

VLA 평가가 어려운 이유는 task가 semantic, geometric, dynamic, temporal 요소를 모두 포함하기 때문이다. 모델이 ‘빨간 컵을 집어라’라는 명령을 이해했는지 평가하려면 object recognition, language grounding, grasp planning, trajectory execution, contact handling, recovery를 모두 봐야 한다. 또 benchmark 환경은 종종 너무 깨끗하고 반복 가능하다. 실제 세계에서는 object arrangement, lighting, occlusion, distractor, human intervention, hardware drift, sensor noise가 계속 바뀐다. 모델이 benchmark artifact를 배웠는지, 진짜 embodied reasoning을 했는지 구분하는 것은 쉽지 않다.

이 장은 LIBERO, CALVIN, ManiSkill, Simpler, vla-eval 같은 benchmark와 evaluation harness를 다루며, real robot evaluation protocol을 별도로 논의한다. 우리는 success rate, robustness, generalization, latency, recovery, safety intervention, human oversight, statistical confidence를 함께 보아야 한다. 또한 benchmark를 설계할 때 어떤 variation이 필요하고, 어떤 causal intervention이 shortcut behavior를 드러내며, 어떤 reporting standard가 재현성을 높이는지 살펴본다.

Real VLA의 평가는 ‘잘한다’는 인상을 만드는 일이 아니라, 어떤 조건에서 무엇을 할 수 있고 무엇을 못하는지 정직하게 드러내는 일이다. 이 장은 독자가 VLA 논문의 성능표를 더 비판적으로 읽도록 돕는다. 좋은 benchmark는 모델을 돋보이게 하는 무대가 아니라, 모델의 한계를 드러내고 다음 데이터 수집과 시스템 개선을 안내하는 계측기다.

#### 이 장이 던지는 질문

- VLA benchmark success rate는 어떤 capability를 보여주고 어떤 capability를 숨기는가?
- distribution shift와 causal intervention은 embodied reasoning 평가에 왜 필요한가?
- real robot evaluation protocol에는 어떤 reporting standard가 포함되어야 하는가?

## Part V. Real Deployment

### Chapter 17. Hierarchical VLA and Embodied Reasoning — 계층형 VLA와 embodied reasoning

#### Prologue

VLA 연구는 한때 모든 것을 하나의 end-to-end model로 밀어 넣는 방향으로 보였다. 그러나 실제 배치에 가까워질수록 다시 계층 구조가 중요해지고 있다. 상위 모델은 장면을 해석하고, task를 분해하고, 진행 상황을 판단하고, 도구나 skill을 호출한다. 하위 VLA policy는 주어진 subgoal이나 instruction에 대해 action chunk나 trajectory를 생성한다. controller와 safety monitor는 물리적 실행을 제한하고 감시한다. 이것은 고전 로봇 architecture의 단순한 회귀가 아니다. VLM/LLM 기반 embodied reasoning이 고전 planning의 자리를 새로운 방식으로 채우는 것이다.

Embodied reasoning은 텍스트 추론과 다르다. 로봇은 세계에 대해 말하는 것이 아니라 세계 안에서 행동해야 한다. 그래서 reasoning model은 object relation, spatial layout, affordance, task progress, failure state, human instruction, robot capability를 함께 다뤄야 한다. ‘이 물체를 저 상자에 넣어라’라는 명령은 어떤 물체인지, 어디에 있는지, 잡을 수 있는지, 상자가 열려 있는지, 경로가 막혀 있는지, 이미 넣었는지, 실패하면 무엇을 해야 하는지를 묻는다. 이것이 embodied reasoning이다.

이 장은 Gemini Robotics-ER류의 reasoning layer, VLA + TAMP, world model, tool/function calling, progress detection, success estimation을 하나의 계층형 system design 문제로 본다. 단일 VLA가 모든 action을 직접 예측하는 방식과, reasoning model이 subgoal을 만들고 VLA/controller가 실행하는 방식은 서로 배타적이지 않다. 오히려 task horizon, safety requirement, compute budget, robot capability에 따라 적절한 계층 구조를 선택해야 한다.

Real VLA의 미래는 아마도 순수한 monolithic model과 순수한 modular planner 사이 어딘가에 있을 것이다. 이 장은 그 중간 지대를 체계적으로 설명한다. 상위 reasoning은 의미와 구조를 제공하고, 하위 VLA는 fluid한 action generation을 제공하며, controller는 물리적 안정성을 제공한다. 이 세 계층을 어떻게 연결하느냐가 real deployment의 핵심이다.

#### 이 장이 던지는 질문

- embodied reasoning model은 VLA system stack에서 어떤 역할을 맡는가?
- hierarchical VLA는 monolithic VLA보다 어떤 상황에서 유리한가?
- task progress, success detection, recovery reasoning은 어떻게 평가할 수 있는가?

### Chapter 18. Real-Time and Hardware-Aware VLA — 실시간성과 하드웨어 인지 VLA

#### Prologue

로봇에게 시간은 추상적인 index가 아니다. 100ms 늦은 action은 단순히 조금 늦은 예측이 아니라, 이미 다른 상태가 된 세계에 대한 잘못된 명령일 수 있다. 큰 VLA 모델은 더 많은 지식과 표현력을 제공하지만, 실제 로봇 위에서는 latency, memory, power, thermal budget, communication delay, control frequency가 성능을 제한한다. VLA가 real-time system 안에 들어가는 순간, 모델의 품질은 accuracy와 함께 timing behavior로 평가되어야 한다.

대화형 AI에서는 응답이 1초 늦어도 큰 문제가 아닐 수 있다. 그러나 manipulation, locomotion, human-robot interaction에서는 loop frequency가 task 안정성을 좌우한다. VLA가 5Hz로 high-level action chunk를 내고, low-level controller가 500Hz로 추적하는 구조와, VLA가 직접 50Hz action을 내는 구조는 완전히 다른 시스템이다. inference batching, KV cache, quantization, edge accelerator, asynchronous execution, fallback controller는 모두 로봇 deployment의 일부가 된다.

이 장은 VLA를 hardware-aware하게 보는 법을 다룬다. 모델 크기, token length, image resolution, action horizon, control rate, communication architecture, GPU/NPU/XPU deployment, on-device vs cloud inference, fail-safe behavior를 함께 고려한다. 좋은 VLA는 benchmark에서 높은 점수를 내는 모델만이 아니라, 로봇 위에서 정해진 시간 안에 예측하고, 지연이 생기면 안전하게 degrade하며, controller와 schedule을 맞출 수 있는 모델이다.

Real VLA에서 실시간성은 optimization의 마지막 단계가 아니다. 처음부터 architecture와 action representation을 결정하는 핵심 제약이다. 이 장은 독자가 ‘큰 모델이면 더 좋다’는 단순한 관점을 넘어서도록 한다. 로봇에서는 가장 좋은 모델이 아니라, 주어진 hardware와 safety envelope 안에서 닫힌 루프를 안정적으로 유지하는 모델이 필요하다.

#### 이 장이 던지는 질문

- VLA inference latency는 closed-loop manipulation에서 어떤 실패를 만들 수 있는가?
- action chunking과 asynchronous execution은 real-time constraint를 어떻게 완화하는가?
- on-device VLA와 cloud-based VLA는 각각 어떤 trade-off를 갖는가?

### Chapter 19. Safety and Assurance — 안전성과 보증

#### Prologue

로봇 안전은 prompt 하나로 해결되지 않는다. VLA가 아무리 똑똑해 보여도, 그것이 물리 로봇을 움직이는 순간 잘못된 action은 사람, 물체, 로봇 자신에게 손상을 줄 수 있다. 언어모델의 hallucination은 화면 위의 오류로 끝날 수 있지만, 로봇의 hallucinated action은 충돌, 낙하, 끼임, 과도한 힘, 위험한 접촉으로 이어질 수 있다. 따라서 Real VLA에서 safety는 모델의 부가 기능이 아니라 시스템의 기본 성질이다.

VLA safety는 여러 층으로 나누어 보아야 한다. semantic safety는 명령 자체가 위험한지 판단한다. geometric safety는 경로와 작업공간의 충돌 가능성을 본다. dynamic safety는 속도, 힘, 토크, 접촉 안정성을 제한한다. system safety는 failure detection, emergency stop, fallback policy, human override를 다룬다. data safety는 모델이 unsafe demonstration이나 편향된 behavior를 학습하지 않도록 한다. 어느 한 층만으로 충분하지 않다. 안전은 stack property다.

이 장은 runtime monitor, safety shield, constraint filtering, formal verification, human-in-the-loop supervision, safe recovery, red-teaming, safety benchmark를 다룬다. 특히 VLA의 어려움은 semantic ambiguity와 physical uncertainty가 동시에 존재한다는 점이다. ‘칼을 가져와’라는 명령은 context에 따라 안전할 수도 위험할 수도 있고, ‘컵을 건네줘’라는 명령도 상대방의 위치, gripper force, cup temperature에 따라 달라진다. 안전한 VLA는 명령을 이해할 뿐 아니라, 모르면 멈추고 물어보고, 자신이 제어할 수 없는 상황에서는 실행하지 않아야 한다.

Real VLA의 안전성은 모델 성능표 뒤에 붙이는 마지막 장식이 아니다. 오히려 deployment 가능한 VLA와 demo용 VLA를 가르는 핵심 기준이다. 이 장은 독자에게 안전을 ‘막연한 윤리 문제’가 아니라 control, planning, perception, data, evaluation이 함께 만드는 engineering discipline으로 보게 한다. VLA가 실제 세계로 나가려면, 무엇을 할 수 있는지보다 무엇을 하지 말아야 하는지를 더 정확히 알아야 한다.

#### 이 장이 던지는 질문

- VLA safety를 semantic, geometric, dynamic, system, data safety로 나누어야 하는 이유는 무엇인가?
- runtime monitor와 safety shield는 learned policy의 어떤 한계를 보완하는가?
- 안전한 failure와 unsafe success를 어떻게 구분하고 평가할 수 있는가?

### Chapter 20. Humanoids and Whole-Body VLA — 휴머노이드와 전신 VLA

#### Prologue

휴머노이드 로봇은 VLA의 난이도를 한 단계 끌어올린다. tabletop manipulator에서는 arm과 gripper의 action을 주로 다루면 되지만, humanoid에서는 torso, head, arms, hands, legs, balance, locomotion, gaze, bimanual coordination, whole-body contact가 함께 움직인다. 하나의 물체를 집는 일조차 base pose, reachability, balance margin, hand posture, collision avoidance, visual attention이 얽힌 전신 문제로 바뀐다. 따라서 humanoid VLA는 단순히 action dimension이 커진 VLA가 아니다. 그것은 embodiment 자체가 달라진 VLA다.

Whole-body VLA에서 가장 어려운 점은 high-level semantic goal과 low-level dynamic feasibility 사이의 간극이 커진다는 것이다. ‘선반 위 상자를 내려라’라는 명령은 손만 움직이면 되는 문제가 아니라, 어느 위치로 걸어갈지, 몸을 어떻게 기울일지, 어느 손을 쓸지, 균형을 어떻게 유지할지, object를 든 상태에서 어떻게 이동할지를 포함한다. 이때 VLA가 직접 모든 joint command를 예측하는 것은 어려울 수 있고, system-2 reasoning, system-1 action policy, whole-body controller, locomotion controller의 결합이 필요해진다.

이 장은 GR00T류의 humanoid foundation model, dual-system architecture, whole-body control, bimanual manipulation, dexterous hand control, locomotion-manipulation coupling을 다룬다. 우리는 humanoid VLA를 company demo의 화려함으로만 보지 않고, 어떤 control interface와 data engine이 필요한지 분석한다. human video pretraining은 어떤 prior를 줄 수 있는가? teleoperation은 humanoid whole-body data를 어떻게 수집해야 하는가? action chunk는 arm-only manipulation과 humanoid control에서 어떻게 달라지는가? safety envelope는 사람 크기의 로봇에서 어떻게 강화되어야 하는가?

Humanoid VLA는 Real VLA의 종착점처럼 보이지만, 사실은 Real VLA의 모든 문제가 한꺼번에 드러나는 시험장이다. state estimation, contact, planning, action representation, data scaling, adaptation, real-time inference, safety가 모두 동시에 필요하다. 이 장은 책 전체를 휴머노이드라는 가장 어려운 embodiment 위에서 다시 통합한다.

#### 이 장이 던지는 질문

- humanoid VLA는 arm-only manipulation VLA와 어떤 점에서 근본적으로 다른가?
- whole-body controller와 VLA policy의 책임 경계는 어떻게 나눌 수 있는가?
- human video, teleoperation, simulation은 humanoid VLA 데이터 엔진에서 어떤 역할을 하는가?

### Chapter 21. Future Directions — 미래 방향

#### Prologue

VLA의 미래를 예측하는 일은 쉽지 않다. 몇 년 사이에 Robotics Transformer, Open X-Embodiment, OpenVLA, diffusion/flow action policy, embodied reasoning model, humanoid foundation model이 빠르게 등장했다. 그러나 빠른 변화 속에서도 분명한 방향은 있다. VLA는 단순히 더 큰 VLM에 action head를 붙이는 방식으로만 발전하지 않을 것이다. 미래의 Real VLA는 world model, online adaptation, self-improving data loop, multi-embodiment transfer, formal safety assurance, hardware-aware deployment가 함께 결합된 시스템으로 갈 가능성이 크다.

가장 큰 질문은 로봇이 세계를 어떻게 internalize할 것인가다. 현재의 VLA는 강력한 pattern recognition과 imitation 능력을 보여주지만, long-horizon consequence, hidden state, physical causality, object permanence, tool use, failure recovery를 안정적으로 다루려면 더 나은 world model이 필요하다. 세계모델은 단순한 video prediction이 아니라, action이 세계를 어떻게 바꾸는지, 어떤 변화가 task success와 safety에 중요한지, 불확실할 때 어떤 정보를 더 얻어야 하는지 추론하는 기반이 되어야 한다.

두 번째 질문은 VLA가 어떻게 계속 좋아질 것인가다. static pretrained model은 배치 후 새로운 환경, 새로운 물체, 새로운 실패를 만난다. 미래의 로봇 시스템은 deployment data를 수집하고, failure를 분류하고, human feedback을 반영하고, simulation과 real data를 섞고, 안전한 범위 안에서 online learning을 수행해야 한다. 이것은 모델 연구만이 아니라 MLOps, robot ops, safety engineering, evaluation protocol의 결합 문제다.

마지막 질문은 VLA가 로봇공학을 어디로 데려갈 것인가다. 이 책의 결론은 낙관적이지만 단순하지 않다. VLA는 로봇 제어, 계획, 모션플래닝, 로봇러닝을 대체하지 않는다. 오히려 그 모든 요소를 새롭게 연결하고, language와 vision을 통해 더 넓은 task space로 확장한다. 미래의 로봇공학자는 controller와 foundation model, dataset과 safety case, benchmark와 real deployment를 동시에 이해해야 한다. Real VLA는 하나의 모델이 아니라, 새로운 로봇 시스템 설계 철학이다.

#### 이 장이 던지는 질문

- world model은 VLA의 어떤 한계를 보완할 수 있는가?
- self-improving data loop를 안전하게 운영하려면 어떤 평가·검증 체계가 필요한가?
- 미래의 roboticist는 foundation model 시대에 어떤 시스템 감각을 가져야 하는가?
