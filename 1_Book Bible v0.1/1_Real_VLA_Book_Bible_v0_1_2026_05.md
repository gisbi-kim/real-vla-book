# Real VLA: A Roboticist's Perspective

## Book Bible v0.1

**문서 목적:** 이후 모든 챕터를 incremental하게 작성하기 위한 내부 편집 규격, claim policy, 장별 역할, 반복 템플릿을 고정한다.  
**버전:** 2026.05.12  
**상태:** Working specification. 본문 원고가 아니라 집필 운영 문서다.  
**기반 산출물:** v2 저술계획서, source corpus, chapter prologue draft, 초기 역사/커리큘럼 문서.

---

## 0. One-page Lock

### 0.1 Locked Title

**Real VLA: A Roboticist's Perspective**  
**Subtitle:** *From Control, Planning, and Robot Learning to Embodied Foundation Models*

### 0.2 Core Thesis

> **A real VLA is not a model that replaces robotics; it is a policy interface that reorganizes control, planning, perception, language, data, and safety into one embodied system.**

한국어 원고에서는 다음 문장을 중심 thesis로 반복한다.

> **VLA는 로봇 제어이론의 대체물이 아니라, task semantics와 embodied perception을 action-generation으로 연결하는 새로운 policy interface다.**

이 문장은 책 전체에서 변하지 않는다. 각 장은 이 thesis를 자기 주제의 언어로 다시 증명해야 한다.

### 0.3 Anti-thesis

이 책은 다음 식의 서술을 피한다.

- “LLM/VLM이 로봇을 움직인다”라는 단순화.
- 최신 VLA 논문을 연대순으로 나열하는 survey.
- 고전 제어/계획을 과거 배경으로만 취급하는 서술.
- 회사 데모나 project page를 검증된 연구 성과처럼 취급하는 서술.
- benchmark success rate를 실제 로봇 능력과 동일시하는 서술.

### 0.4 Locked Stack

| Layer | Input | Output | 대표 역할 | 책임 경계 |
|---|---|---|---|---|
| Embodied reasoning layer | image/video/audio, language, memory, scene graph | subgoal, plan, tool call, VLA call | task decomposition, spatial reasoning, progress/success 판단 | 무엇을 해야 하는가 |
| VLA policy layer | observation, instruction/subgoal, proprioception, short memory | action token, waypoint, delta pose, action chunk, action distribution | language-conditioned action generation | 어떤 action을 제안하는가 |
| Motion/control layer | target, constraint, robot state | feasible trajectory, servo command, torque/velocity/position target | MPC, OSC, impedance, WBC, trajectory tracking | 물리적으로 어떻게 움직일 것인가 |
| Safety/assurance layer | command, state, environment, policy confidence, rule set | allow, modify, stop, recover, ask human | monitoring, shielding, verification, recovery | 무엇을 금지하거나 수정할 것인가 |
| Data/evaluation layer | trajectories, failures, sim logs, labels, benchmark protocol | training corpus, metrics, regression tests, deployment evidence | data engine, benchmark, audit loop | 무엇을 근거로 성능을 주장할 것인가 |

### 0.5 Chapter Writing Rhythm

모든 장은 가능하면 다음 공통 구조를 따른다.

1. **Problem** - 이 장이 다루는 로봇 문제는 무엇인가?
2. **Classical formulation** - 제어, 계획, 추정, 최적화에서는 이 문제를 어떻게 썼는가?
3. **Learning formulation** - imitation learning, RL, visuomotor policy에서는 무엇이 달라졌는가?
4. **VLA formulation** - language, vision, action, data scaling이 들어오면서 무엇이 다시 정의되었는가?
5. **System interface** - 실제 robot stack에서는 어느 input/output boundary에 해당하는가?
6. **Failure mode** - latency, contact, distribution shift, safety, benchmark artifact, hardware constraint가 어디서 문제를 만든는가?

---

## 1. Book Identity

### 1.1 What This Book Is

이 책은 Vision-Language-Action model을 로봇공학자의 관점에서 해석하는 시스템 책이다. VLA를 하나의 neural architecture나 특정 benchmark family로 좁히지 않고, 언어적 목표가 물리적 action으로 바뀌는 전체 stack의 interface problem으로 본다.

독자가 책을 끝까지 읽은 뒤 가져야 할 능력은 최신 모델 이름을 많이 아는 것이 아니다. 새로운 VLA 논문, 오픈소스 모델, 회사 데모, 로봇 시스템을 봤을 때 다음 질문에 답할 수 있어야 한다.

- 이 시스템은 robot stack의 어느 boundary를 바꾸는가?
- 출력 action은 controller가 추적할 수 있는 형태인가?
- 데이터는 어떤 embodiment와 action space를 전제로 하는가?
- benchmark 성능은 실제 배치 능력을 얼마나 설명하는가?
- safety와 recovery는 모델 내부 책임인가, stack 책임인가?

### 1.2 What This Book Is Not

이 책은 다음이 아니다.

- VLM/LLM 일반론 교과서.
- 로봇 제어 이론 전체를 증명하는 classical robotics textbook.
- 최신 arXiv 논문을 빠르게 훑는 survey.
- 특정 회사 모델이나 demo를 홍보하는 기술 소개서.
- VLA가 기존 robotics를 대체한다는 주장.

### 1.3 Reader Profile

주 독자는 로봇공학, 제어, 컴퓨터비전, 머신러닝, 딥러닝 중 하나 이상에 익숙한 대학원생, 연구자, 엔지니어다. 독자가 모든 분야의 전문가일 필요는 없지만, 다음 정도의 배경은 가정한다.

| 영역 | 필요한 수준 | 책에서 다시 다루는 방식 |
|---|---|---|
| Linear algebra / probability | 상태, 추정, policy, distribution을 이해할 수 있는 수준 | notation을 통일하고 필요한 부분만 복습 |
| Control / robotics | kinematics, dynamics, feedback control의 기본 감각 | VLA interface와 연결되는 부분 중심 |
| Machine learning | supervised learning, representation learning, transformer의 기본 구조 | VLA와 action generation에 필요한 만큼만 설명 |
| Computer vision / VLM | image encoder, multimodal representation의 기본 감각 | grounding과 embodied perception 중심 |
| Robot deployment | 없어도 됨 | latency, safety, hardware, evaluation을 책에서 설명 |

### 1.4 Tone

원고는 전문적인 교과서체로 쓴다. 한국어 본문은 “이다”체를 사용한다. 영어 technical term은 무리하게 번역하지 않는다. 단, 처음 등장할 때는 한국어 설명을 붙인다.

- 좋은 문체: “VLA의 action representation은 출력 포맷 문제가 아니라 control boundary를 어디에 둘 것인가의 문제이다.”
- 피할 문체: “요즘 VLA는 엄청 강력하다”, “이 모델은 로봇 지능을 해결했다”, “이 논문은 SOTA라서 중요하다.”

---

## 2. Global Concept Map

### 2.1 VLA Definition

이 책에서 VLA는 다음 조건을 만족하는 embodied policy interface로 정의한다.

1. 최소 하나 이상의 visual observation을 사용한다.
2. language instruction, language-conditioned subgoal, 또는 semantic task representation을 사용한다.
3. robot action, action chunk, waypoint, trajectory target, controller call, 또는 skill invocation으로 실행 가능한 출력을 낸다.
4. real or simulated embodiment의 state/action constraint와 연결된다.
5. data, evaluation, safety layer와 분리할 수 없는 시스템 구성요소로 취급된다.

이 정의는 넓지만 무제한적이지 않다. 순수 VLM captioner, pure text planner, offline-only benchmark classifier는 이 책의 핵심 VLA가 아니다. 단, 이들이 VLA stack의 reasoning layer나 perception layer로 쓰이는 경우에는 다룬다.

### 2.2 Real VLA vs Benchmark VLA

| 구분 | Benchmark VLA | Real VLA |
|---|---|---|
| 목표 | 정해진 benchmark에서 높은 success rate | 실제 task completion, safety, recovery, maintainability |
| 시간 구조 | episode 단위 평가 | continuous operation, interrupt, retry, recovery |
| action | benchmark action space에 맞춤 | robot controller, latency, hardware limit에 맞춤 |
| 실패 처리 | 실패 episode로 기록 | 멈춤, 복구, 재계획, 인간 개입 |
| 데이터 | curated demonstration 중심 | demonstration, failure, sim, deployment log, monitoring data |
| 안전 | 평가 외부 조건으로 처리되기 쉬움 | stack property로 설계 |

### 2.3 Core Comparison Axes

최신 VLA 시스템을 비교할 때는 다음 축을 사용한다.

| 축 | 질문 | 원고에서의 사용법 |
|---|---|---|
| Backbone | LLM 기반인가, VLM 기반인가, robot-specific transformer인가? | 모델 이름 소개보다 representation 역할을 먼저 설명 |
| Action representation | discrete token, continuous regression, diffusion, flow, action chunk 중 무엇인가? | Chapter 13의 중심 비교축으로 고정 |
| Temporal horizon | single-step인가, chunk인가, long-horizon planner와 결합하는가? | control frequency와 recovery 문제로 연결 |
| Embodiment | 단일 robot인가, multi-embodiment인가, humanoid까지 가는가? | action normalization과 embodiment adapter 문제로 연결 |
| Data source | teleoperation, autonomous data, simulation, synthetic data, web data를 어떻게 섞는가? | Chapter 14/15에서 evidence로 사용 |
| Control interface | joint position, end-effector delta, velocity, torque, waypoint, whole-body action 중 무엇을 내는가? | Chapter 3/13/18/20에 cross-link |
| Safety | constraint, verification, recovery, human intervention을 어떻게 다루는가? | Chapter 19와 모든 deployment claim에 연결 |
| Deployment | real-time inference, on-device compute, latency, memory cost를 어떻게 해결하는가? | Chapter 18의 평가 기준으로 사용 |

### 2.4 Five Recurrent Tensions

책 전체에서 반복될 다섯 가지 tension은 다음이다.

1. **Semantic generality vs physical reliability** - 언어/상식 능력은 넓어지지만 물리적 실행 안정성은 별개의 문제다.
2. **End-to-end learning vs modular assurance** - end-to-end policy는 강력하지만 검증과 recovery는 modular stack이 유리할 수 있다.
3. **Discrete token convenience vs continuous control reality** - VLM/LLM pipeline은 token을 좋아하지만 로봇은 연속적인 힘, 속도, 접촉을 다룬다.
4. **Benchmark scalability vs real deployment validity** - benchmark는 비교를 가능하게 하지만 실제 배치 능력을 완전히 대표하지 못한다.
5. **Data scaling vs embodiment mismatch** - 데이터가 많아져도 robot morphology, action space, sensor setup이 다르면 transfer가 어렵다.

---

## 3. Chapter Architecture

### 3.1 Locked 21-Chapter Map

| Part | Chapter | Title | Role in the Book | Anchor Question |
|---|---:|---|---|---|
| Part 0 | Ch. 01 | What Is a Real VLA System? | 책 전체의 세계관과 system stack을 고정한다. | VLA를 단일 모델이 아니라 embodied policy stack으로 정의한다. |
| Part I | Ch. 02 | State, Dynamics, and Estimation | observation, state, proprioception, latency, partial observability의 차이를 고정한다. | VLA가 세계를 본다는 말과 상태를 안다는 말의 차이를 분리한다. |
| Part I | Ch. 03 | Control Interfaces | VLA output과 robot controller 사이의 계약을 정의한다. | joint/action/pose/torque/waypoint/chunk 중 무엇을 모델이 책임지는지 분명히 한다. |
| Part I | Ch. 04 | Contact, Force, and Manipulation | 접촉, 힘, compliance, tactile/force sensing을 VLA 조작 문제와 연결한다. | semantic understanding이 contact safety를 자동으로 보장하지 않음을 설명한다. |
| Part I | Ch. 05 | Planning, Motion Planning, and TAMP | symbolic planning, motion planning, TAMP를 VLA subgoal/action feasibility와 연결한다. | 언어적 goal을 실행 가능한 연속공간 궤적으로 바꾸는 문제를 다룬다. |
| Part II | Ch. 06 | Imitation Learning and Covariate Shift | behavior cloning, DAgger, offline learning의 실패 구조를 VLA fine-tuning과 연결한다. | demonstration distribution 밖에서 policy가 왜 무너지는지 설명한다. |
| Part II | Ch. 07 | RL, Optimal Control, and Control as Inference | RL과 optimal control의 연결, model-based/data-efficient learning, inference 관점을 정리한다. | VLA action distribution과 control-as-inference의 개념적 접점을 만든다. |
| Part II | Ch. 08 | Visuomotor Policies | image-to-action policy의 직접 조상을 정리한다. | 언어가 붙기 전 perception-action mapping의 한계와 강점을 설명한다. |
| Part III | Ch. 09 | Transformers, VLMs, and Grounding | Transformer/VLM representation이 VLA backbone으로 들어오는 경로를 설명한다. | tokenization, grounding, multimodal representation을 VLA에 필요한 만큼만 다룬다. |
| Part III | Ch. 10 | LLM/VLM as Robot Planner | LLM/VLM planner 시기를 설명하고 executability/affordance 문제를 드러낸다. | planner가 skill/controller를 호출하던 계층형 구조의 장점과 한계를 보여준다. |
| Part III | Ch. 11 | From Planner + Skills to VLA | skill library, affordance, closed-loop feedback에서 VLA로 넘어가는 경계 장이다. | pure planning과 end-to-end policy 사이의 middle ground를 설명한다. |
| Part IV | Ch. 12 | Robotics Transformer Era | BC-Z, Gato, RT-1, PaLM-E, RT-2, RoboCat 흐름을 VLA 탄생기로 정리한다. | robot action을 sequence/token prediction 문제로 본 역사적 전환을 설명한다. |
| Part IV | Ch. 13 | Action Representation | 책의 기술적 중심 장이다. action token, regression, chunk, diffusion, flow, action expert를 비교한다. | action representation을 output format이 아니라 control boundary로 해석한다. |
| Part IV | Ch. 14 | Data Engines | Open X-Embodiment, BridgeData, DROID, ALOHA, sim/synthetic/failure data를 데이터 엔진 관점으로 묶는다. | VLA 성능이 model-only가 아니라 data collection/curation/evaluation loop의 산물임을 보여준다. |
| Part IV | Ch. 15 | Adaptation and Fine-Tuning | OpenVLA, Octo, OpenVLA-OFT, FAST, VLA Foundry 등 실용적 adaptation 흐름을 다룬다. | foundation policy를 특정 robot/task/action space에 맞추는 engineering recipe를 설명한다. |
| Part IV | Ch. 16 | Evaluation and Benchmarking | LIBERO, CALVIN, ManiSkill, Simpler, vla-eval, real robot protocol을 다룬다. | benchmark score와 실제 robot capability를 분리한다. |
| Part V | Ch. 17 | Hierarchical VLA and Embodied Reasoning | ER + VLA, VLA + TAMP, world model, tool use를 계층형 시스템으로 설명한다. | Gemini Robotics-ER류를 VLA 자체보다 orchestrator/reasoning layer로 해석하는 기준을 잡는다. |
| Part V | Ch. 18 | Real-Time and Hardware-Aware VLA | latency, compute, on-device inference, KV cache, async execution, control frequency를 다룬다. | 좋은 policy와 배치 가능한 policy의 차이를 설명한다. |
| Part V | Ch. 19 | Safety and Assurance | semantic/geometric/dynamic/system/data safety를 분리한다. | safety를 VLA 모델 내부가 아니라 stack property로 정의한다. |
| Part V | Ch. 20 | Humanoids and Whole-Body VLA | GR00T, Helix, whole-body control, locomotion-manipulation coupling을 case study 중심으로 다룬다. | humanoid VLA에서 action space와 safety envelope가 어떻게 커지는지 설명한다. |
| Part V | Ch. 21 | Future Directions | world models, online learning, self-improving data loops, formal verification, multi-embodiment transfer를 전망한다. | 미래 예측을 hype가 아니라 unresolved interface problem으로 정리한다. |

### 3.2 Wave Order for Incremental Writing

원고를 장 번호순으로 쓰지 않는다. 다음 wave 순서로 증식한다.

| Wave | Chapters | 목적 |
|---|---|---|
| Wave 1 - Spine | Ch1, Ch13, Ch14, Ch16, Ch19 | system stack, action API, data/evaluation/safety 기준을 먼저 고정 |
| Wave 2 - Classical-to-VLA bridge | Ch2, Ch3, Ch4, Ch5 | 고전 이론을 현재형 VLA interface로 재해석 |
| Wave 3 - Robot learning history | Ch6, Ch7, Ch8 | VLA 이전 perception-to-action 학습의 직접 조상 정리 |
| Wave 4 - Semantic bridge | Ch9, Ch10, Ch11, Ch12 | VLM/LLM과 Robotics Transformer가 VLA로 이어지는 흐름 정리 |
| Wave 5 - Modern systems | Ch15, Ch17, Ch18, Ch20, Ch21 | 최신 adaptation, deployment, humanoid, future issue 정리 |

이 순서는 원고 품질을 보호하기 위한 장치다. Ch1이 세계관을 고정하고, Ch13이 action/control boundary를 고정하며, Ch14/16/19가 evidence, evaluation, safety 기준을 고정한다. 그 뒤 classical/learning/semantic 장은 이 기준에 맞춰 역방향으로 확장한다.

### 3.3 Chapter Contract Template

각 챕터를 쓰기 전에 반드시 Chapter Contract를 만든다. 본문을 쓰기 전에 구조를 잠그기 위함이다.

```text
Chapter N. [Title]

1. One-sentence thesis
2. Why this chapter exists in a VLA book
3. Reader prerequisites
4. Concepts introduced
5. Concepts intentionally deferred
6. Core equations / algorithms
7. Core papers / textbooks / systems
8. System interface explained in this chapter
9. Failure modes
10. Cross-links to previous and later chapters
11. Figures/tables/boxes needed
12. End-of-chapter Roboticist's Takeaway
13. Claims that require citation or freshness audit
14. Terms that must be added to the glossary
```

### 3.4 Section Template

각 section은 다음 내부 리듬을 따른다. 모든 section이 이 템플릿을 기계적으로 따를 필요는 없지만, 초안 작성 단계에서는 기본값으로 사용한다.

```text
Section N.M. [Section Title]

Opening problem: 독자가 왜 이 section을 읽어야 하는가?
Conceptual move: 이 section이 도입하는 핵심 개념은 무엇인가?
Classical anchor: robotics/control/planning에서는 이 문제를 어떻게 봤는가?
Learning/VLA transition: VLA 시대에는 무엇이 바뀌었는가?
System implication: 실제 로봇 stack에서는 무엇을 설계해야 하는가?
Failure mode: 이 관점이 무너지는 조건은 무엇인가?
Bridge: 다음 section으로 넘어가는 이유는 무엇인가?
```

### 3.5 End-of-Chapter Required Elements

각 장 끝에는 다음 요소를 둔다.

1. **Roboticist's Takeaway** - 실제 로봇 시스템 관점의 결론.
2. **Common Failure Modes** - benchmark에서는 보이지 않지만 real robot에서 중요한 실패.
3. **Design Checklist** - 독자가 시스템을 만들 때 확인할 질문.
4. **Reading Path** - textbook, classic paper, modern VLA paper를 구분한 읽기 순서.
5. **Cross-links** - 앞 장/뒤 장과 연결되는 개념.

---

## 4. Claim and Citation Policy

### 4.1 Claim Classes

모든 factual claim은 다음 중 하나로 분류한다.

| Class | 설명 | citation 필요성 | 예시 |
|---|---|---|---|
| C0 - Definition | 이 책이 내부적으로 정의하는 용어 | 내부적으로 일관되면 됨 | “이 책에서 Real VLA는 stack property로 정의한다.” |
| C1 - Established theory | 오래된 교과서/고전 논문으로 안정된 내용 | textbook/classic citation | Kalman filtering, LQR, MPC, RRT |
| C2 - Research result | 특정 논문이 주장한 결과 | paper citation 필요 | “RT-2는 action을 token처럼 다룬다.” |
| C3 - Benchmark/data claim | 데이터셋 크기, benchmark score, evaluation result | source + date 필요 | “DROID는 몇 시간/몇 trajectory를 포함한다.” |
| C4 - Current system claim | 최신 회사/오픈소스 시스템 상태 | freshness audit 필요 | “GR00T N1.7이 공개되어 있다.” |
| C5 - Interpretation | 저자의 system-level 해석 | 근거 citation + 명시적 해석 표시 | “Gemini Robotics-ER류는 VLA orchestrator로 보는 것이 적절하다.” |

### 4.2 Source Tiers

| Tier | Source type | 사용 방식 | 원고에서의 표현 |
|---|---|---|---|
| T0 | Book Bible, v2 plan, source corpus, chapter drafts | 내부 consistency 기준 | “이 책에서는 ...로 정의한다.” |
| T1 | Established textbook / monograph | 기본 이론의 주 근거 | “classical robotics/control에서는 ...” |
| T2 | Peer-reviewed conference/journal paper | 검증된 연구 결과 | “이 논문은 ...을 보였다.” |
| T3 | arXiv preprint / project page with code | 최신 연구 흐름 | “preprint/project 기준으로 ...을 제안한다.” |
| T4 | Official company technical report/blog/docs | case study 또는 현재 시스템 설명 | “공식 기술 공개에 따르면 ...” |
| T5 | Media article, demo video, social media, secondary blog | 직접 근거로 쓰지 않음. 보조적 맥락만 허용 | “비공식 데모로 알려져 있으나 본문 근거로 삼지 않는다.” |

### 4.3 Freshness Rule

다음 항목은 집필 시점에 반드시 최신성 확인을 한다.

- 최신 회사 시스템: Gemini Robotics, Gemini Robotics-ER, GR00T, Figure Helix 등.
- 오픈소스 release: OpenVLA, OpenVLA-OFT, VLA Foundry, FAST, RDT, π 계열.
- benchmark result, leaderboard, dataset size, public model weight availability.
- 법/안전 규정, deployment guideline, API/SDK status.

Freshness가 필요한 claim은 원고에 작성 날짜 또는 확인 날짜를 함께 둔다.

### 4.4 Company System Handling Rule

회사 시스템은 다음 원칙으로 다룬다.

1. peer-reviewed paper가 있으면 논문을 우선 citation한다.
2. 공식 기술 문서나 blog만 있으면 **case study**로 다룬다.
3. demo video만 있으면 핵심 claim의 근거로 쓰지 않는다.
4. 성능 수치가 독립 재현되지 않았으면 “reported” 또는 “claimed”로 표현한다.
5. 회사 시스템을 책의 conceptual center로 삼지 않는다. conceptual center는 interface, data, action, safety다.

### 4.5 Forbidden Citation Behavior

- citation 없이 숫자를 쓰지 않는다.
- project page의 benchmark 수치를 peer-reviewed result처럼 쓰지 않는다.
- arXiv preprint를 “검증됐다”고 표현하지 않는다.
- secondary blog의 해석을 원문 논문 확인 없이 반복하지 않는다.
- 최신 모델 이름을 넣기 위해 논리 흐름을 깨지 않는다.

---

## 5. Mathematical and Technical Notation Policy

### 5.1 Mathematical Depth

이 책은 수학을 피하지 않지만, 증명 중심 교과서는 아니다. 수식은 다음 목적 중 하나가 있을 때만 넣는다.

1. system boundary를 명확히 할 때.
2. classical formulation과 VLA formulation의 차이를 보일 때.
3. action representation, policy distribution, loss, control objective를 비교할 때.
4. evaluation metric이나 safety constraint를 정의할 때.

### 5.2 Notation Table

책 앞부분 또는 appendix에 notation table을 둔다. 초기 기본값은 다음과 같다.

| Symbol | Meaning | Notes |
|---|---|---|
| $s_t$ | latent or true state | 직접 관측되지 않을 수 있음 |
| $o_t$ | observation | image, proprioception, tactile, audio 등 |
| $x_t$ | robot configuration/state vector | 문맥에 따라 joint state 또는 full state |
| $u_t$ | low-level control input | torque, velocity command, servo command |
| $a_t$ | policy-level action | waypoint, delta pose, token, chunk 등 |
| $g$ | goal or task specification | language, image goal, symbolic goal |
| $\pi_\theta$ | learned policy | VLA or lower-level policy |
| $\tau$ | trajectory | state-action sequence |
| $c(x,u)$ | cost or constraint function | MPC/safety/evaluation에서 사용 |
| $\mathcal{D}$ | dataset | demonstration, sim, failure data 포함 |

### 5.3 Notation Discipline

- $a_t$와 $u_t$를 구분한다. $a_t$는 policy-level action이고, $u_t$는 actuator/control-level command일 수 있다.
- observation $o_t$와 state $s_t$를 구분한다. VLA 문헌의 observation 표기가 상태추정 문제를 지우지 않도록 한다.
- “action”이라는 단어만 쓰지 않고 가능한 한 action type을 명시한다: end-effector delta pose, joint position target, action token, action chunk, waypoint, skill call.
- 수식이 등장한 뒤에는 반드시 system interpretation 문장을 붙인다.

### 5.4 Algorithm Boxes

Algorithm box는 실제 구현 가능한 pseudo-code가 아니라 conceptual algorithm이어도 된다. 단, 다음 항목을 포함한다.

```text
Algorithm: [Name]
Input: observation, instruction, robot state, constraints
Output: action / plan / modified command
Loop: perception -> reasoning/policy -> control -> safety -> feedback
Failure handling: stop / retry / replan / ask human
```

---

## 6. Figure, Table, and Box Policy

### 6.1 Figure Types

| Figure type | 목적 | 예시 |
|---|---|---|
| Stack diagram | system boundary를 한눈에 보여줌 | ER -> VLA -> Controller -> Safety -> Robot |
| Timeline | 역사 흐름을 압축 | Control/Planning -> Robot Learning -> VLM -> VLA |
| Interface diagram | input/output contract 설명 | action token vs delta pose vs torque |
| Failure diagram | 실패 경로 설명 | hallucinated plan -> infeasible waypoint -> unsafe contact |
| Data loop diagram | data engine 설명 | collect -> curate -> train -> evaluate -> deploy -> log |
| Benchmark protocol diagram | evaluation 절차 설명 | reset -> instruction -> rollout -> success/recovery metric |

### 6.2 Table Types

반복적으로 사용할 표 유형은 다음이다.

1. **Classical vs Learning vs VLA** 비교표.
2. **Model/system comparison** 표.
3. **Action representation** 비교표.
4. **Failure mode** 표.
5. **Citation tier** 표.
6. **Design checklist** 표.

### 6.3 Box Types

| Box | 사용 위치 | 내용 |
|---|---|---|
| Roboticist's Takeaway | 각 장 끝 | 실제 시스템 설계 관점의 요약 |
| Common Pitfall | section 중간 | 자주 생기는 오해 |
| System Interface | section 끝 | 이 개념이 stack 어디에 꽂히는지 |
| Citation Caution | 최신 모델/회사 사례 | 증거 수준과 한계 |
| Mini Case Study | 현대 시스템 설명 | 특정 시스템을 conceptual example로 사용 |
| Implementation Note | 실습/엔지니어링 | action normalization, latency, robot wrapper 등 |

### 6.4 Caption Rule

Figure/table caption은 단순 설명이 아니라 주장형이어야 한다.

- 약한 caption: “VLA stack diagram.”
- 좋은 caption: “A real VLA system separates semantic reasoning, action generation, control execution, and safety assurance, even when some layers are implemented by a single neural model.”

---

## 7. Terminology and Glossary Policy

### 7.1 Term Introduction Rule

새로운 term은 처음 등장할 때 다음 순서로 소개한다.

1. English term.
2. 가능한 한국어 설명.
3. 이 책에서의 operational definition.
4. 다른 문헌에서의 넓은/좁은 사용과 차이.

예시:

> **Action chunk**는 단일 시점 action이 아니라 여러 time step의 action sequence를 한 번에 예측하는 출력 단위이다. 이 책에서는 action chunk를 temporal abstraction이자 control frequency mismatch를 완화하는 interface로 다룬다.

### 7.2 Terms to Keep in English

다음 term은 한국어로 번역하지 않거나 병기한다.

- Vision-Language-Action model / VLA
- Vision-Language Model / VLM
- Embodied reasoning / ER
- Action token, action chunk, action expert
- Waypoint, end-effector, proprioception
- Operational space control / OSC
- Model predictive control / MPC
- Task and motion planning / TAMP
- Benchmark, rollout, success rate, distribution shift

### 7.3 Disambiguation Rules

| Ambiguous term | 반드시 구분할 것 |
|---|---|
| action | action token, action chunk, controller command, skill call, waypoint |
| state | latent state, robot state, world state, belief state, observation |
| planning | symbolic planning, motion planning, task planning, embodied reasoning, replanning |
| policy | learned robot policy, VLA policy, skill policy, controller policy |
| safety | semantic, geometric, dynamic, system, data safety |
| grounding | visual grounding, language grounding, affordance grounding, physical grounding |

---

## 8. Writing Workflow

### 8.1 Pass Structure

전체 책은 다음 pass로 키운다.

| Pass | 산출물 | 목적 |
|---|---|---|
| Pass 0 | Book Bible | 책의 고정 규격 확정 |
| Pass 1 | 21 Chapter Contracts | 각 장의 역할, 범위, interface 고정 |
| Pass 2 | Evidence Maps | 장별 교과서/논문/시스템 근거 정리 |
| Pass 3 | Detailed Outlines | section 단위 argument flow 설계 |
| Pass 4 | Section Drafts | section별 본문 작성 |
| Pass 5 | Technical Deepening | 수식, 알고리즘, 그림, 표, box 추가 |
| Pass 6 | Reviewer Critique | 로봇제어, VLA, 교과서 편집 관점 평가 |
| Pass 7 | Patch Revision | 평가에 따른 국소 수정 |
| Pass 8 | Integrated Chapter | 장 전체 통합 |
| Pass 9 | Cross-reference Audit | 용어, claim, citation, chapter link 정리 |
| Pass 10 | Final Manuscript Polish | 문체, 수식, 그림, bibliography, index 정리 |

### 8.2 Chapter Expansion Protocol

한 장을 작성할 때는 다음 턴 순서를 기본값으로 한다.

```text
Turn 1: Chapter Contract
Turn 2: Evidence Map
Turn 3: Detailed section outline
Turn 4-N: Section drafts, one section per turn
Turn N+1: Figures/tables/equations design
Turn N+2: Roboticist's Takeaway + exercises/checklists
Turn N+3: Reviewer critique
Turn N+4: Patch revision
Turn N+5: Final integrated chapter
```

### 8.3 Working State Block

이후 모든 incremental writing prompt 앞에는 다음 블록을 붙인다.

```text
[Working State]

Book: Real VLA: A Roboticist's Perspective
Core thesis: VLA is not a replacement for robotics control; it is a policy interface connecting task semantics and embodied perception to action generation.
Current phase: [Chapter contract / Evidence map / Section draft / Revision]
Current chapter: Chapter [N]. [Title]
Current deliverable: [specific deliverable]
Locked decisions:
- Use Problem -> Classical formulation -> Learning formulation -> VLA formulation -> System interface -> Failure mode.
- Avoid paper-list survey style.
- Always connect to real robot control interface.
- Treat latest company systems as case studies unless peer-reviewed.
- End each section with a bridge to the next section.
Do not change:
- Overall book thesis
- 21-chapter sequence
- Real VLA stack definition
```

### 8.4 Open Issues Log

모호한 결정은 본문에 흘려보내지 말고 open issue로 남긴다.

```text
Open Issue #[ID]
Question:
Current decision:
Evidence needed:
Affected chapters:
Resolution deadline:
Status: open / resolved / deferred
```

예시:

```text
Open Issue #007
Question: Gemini Robotics-ER should be described as VLA, ER model, or VLA orchestrator?
Current decision: Describe it as an embodied reasoning layer that may call VLA/controller.
Evidence needed: official docs, technical report, peer-reviewed paper if available.
Affected chapters: Ch1, Ch17, Ch19, Ch21.
Status: open until source audit.
```

---

## 9. Prompt Templates

### 9.1 Book Bible Update Prompt

```text
Book Bible v0.1을 기준으로 [항목]을 업데이트해줘.

조건:
- Core thesis와 21장 구조는 바꾸지 마.
- 변경해야 하는 이유를 먼저 설명해.
- 변경 전/후를 표로 보여줘.
- affected chapters와 open issues를 함께 업데이트해.
- 원고 본문은 쓰지 마.
```

### 9.2 Chapter Contract Prompt

```text
Book Bible v0.1을 기준으로 Chapter [N]. [Title]의 Chapter Contract를 작성해줘.

본문 원고는 아직 쓰지 마.
다음 항목만 작성해:
1. One-sentence thesis
2. 이 장이 책 전체에서 맡는 역할
3. 이전 장에서 받아오는 개념
4. 이후 장으로 넘겨주는 개념
5. section-level outline
6. 각 section의 핵심 주장
7. 핵심 수식/개념도/표
8. 반드시 다룰 논문과 시스템
9. 빠지면 안 되는 failure mode
10. Roboticist's Takeaway 초안
11. 이 장에서 조심해야 할 과장/오해
```

### 9.3 Evidence Map Prompt

```text
Chapter [N]. [Title]의 Evidence Map을 작성해줘.

목표는 본문 작성 전에 이 장에서 인용하거나 재료로 삼을 문헌과 시스템을 정리하는 거야.

각 항목마다:
- 핵심 reference
- 이 reference가 답하는 질문
- 책에서 사용할 위치
- 장점
- 한계
- VLA system 관점의 해석
- source tier
- freshness 필요 여부

최신 논문/회사 시스템은 최신성 확인이 필요한 항목으로 표시해줘.
```

### 9.4 Section Draft Prompt

```text
Book Bible v0.1과 Chapter [N] Contract를 기준으로 Section [N.M] “[Title]”을 본문 원고로 작성해줘.

조건:
- 한국어 전문 원고체, ‘이다’체
- 길이 [X]자
- 논문 나열 금지
- classical formulation과 VLA formulation을 연결할 것
- 실제 robot control/data/evaluation/safety interface와 연결할 것
- 필요한 수식은 최소한으로 넣고 바로 system interpretation을 붙일 것
- 마지막에는 5문장 요약과 다음 section으로 넘어가는 bridge를 넣을 것
- 과장 표현 금지
- 독자가 기억해야 할 핵심 문장 1개를 bold로 표시
```

### 9.5 Reviewer Critique Prompt

```text
지금까지 작성한 Chapter [N] 초안을 세 명의 reviewer 관점에서 평가해줘.

Reviewer A: 로봇 제어/동역학 전문가
Reviewer B: VLA/robot learning 연구자
Reviewer C: 교과서 편집자

각 reviewer마다:
1. 가장 강한 점 3개
2. 가장 위험한 약점 5개
3. 빠진 개념
4. 과장되거나 부정확할 수 있는 claim
5. 앞뒤 장과 충돌하는 부분
6. 수정 우선순위

마지막에는 바로 적용 가능한 patch plan을 제시해줘.
아직 전체 rewrite는 하지 마.
```

### 9.6 Patch Revision Prompt

```text
방금 reviewer 평가에서 나온 patch plan만 반영해서 Chapter [N] Section [range]를 수정해줘.

조건:
- 구조는 유지
- 새 section 추가 금지
- claim을 더 정확하게 만드는 방향
- 논문 나열식 문단으로 바꾸지 말 것
- 바뀐 부분만 보여주고, 각 변경 이유를 한 줄로 설명
```

---

## 10. Quality Checklist

### 10.1 Chapter-level Checklist

각 장 초안이 완료되면 다음을 확인한다.

| Check | 질문 | Pass condition |
|---|---|---|
| Thesis alignment | 이 장이 core thesis를 자기 주제로 재증명하는가? | 장 끝 takeaway가 thesis와 직접 연결됨 |
| Interface clarity | 이 장의 개념이 stack 어디에 들어가는지 명확한가? | input/output boundary가 명시됨 |
| Classical bridge | 고전 이론이 배경이 아니라 현재형 도구로 설명되는가? | classical formulation과 VLA formulation 모두 있음 |
| Evidence quality | 중요한 claim에 적절한 citation tier가 붙었는가? | C2-C4 claim에 근거가 있음 |
| Failure modes | 실제 로봇 실패 조건을 다루는가? | latency/contact/safety/distribution shift 중 관련 항목 포함 |
| Non-hype | 최신 모델을 과장하지 않았는가? | company/system claims가 tier와 함께 처리됨 |
| Pedagogy | 독자가 따라올 수 있는 순서인가? | section bridge와 summary가 있음 |
| Cross-reference | 앞뒤 장과 연결되는가? | 최소 3개 cross-link 있음 |

### 10.2 Section-level Checklist

- section opening이 문제를 명확히 제시하는가?
- 논문 이름 나열로 시작하지 않는가?
- 핵심 개념이 실제 robot interface와 연결되는가?
- action/state/control/data/evaluation 용어가 일관되는가?
- 최신 시스템 claim은 source tier와 함께 제시되는가?
- 다음 section으로 넘어가는 bridge가 있는가?

### 10.3 Hype Filter

다음 표현은 피하거나 약화한다.

| 피할 표현 | 권장 표현 |
|---|---|
| “해결했다” | “특정 조건에서 개선을 보였다” |
| “범용 로봇 지능” | “multi-task 또는 multi-embodiment generalization을 목표로 한다” |
| “사람처럼 이해한다” | “semantic/spatial representation을 사용한다” |
| “end-to-end가 classical robotics를 대체한다” | “일부 interface를 learned policy로 재정의한다” |
| “SOTA이므로 중요하다” | “이 논문은 action/data/interface 관점에서 중요한 설계 선택을 보인다” |

---

## 11. Roboticist's Takeaway Templates

### 11.1 General Template

```text
Roboticist's Takeaway

[Concept]는 [model component]의 문제가 아니라 [robot system boundary]의 문제이다.
실제 로봇에서는 [latency/contact/safety/data/evaluation] 때문에 [naive interpretation]이 깨진다.
따라서 [recommended design principle]을 기준으로 [VLA layer]와 [control/safety/data layer]의 책임을 나누어야 한다.
```

### 11.2 Action Representation Takeaway

> Action representation은 VLA의 output format 문제가 아니라, robot control boundary를 어디에 둘 것인가의 문제이다.

### 11.3 Evaluation Takeaway

> A VLA benchmark score is not a robot capability. Real capability requires reproducible protocol, distribution-shift tests, recovery evaluation, safety intervention, and hardware-aware latency measurement.

### 11.4 Safety Takeaway

> Safety cannot be delegated to the VLA. Safety is a stack property: semantic filter, geometric constraint, dynamic controller, runtime monitor, recovery policy, and human override must work together.

---

## 12. Revision and File Management

### 12.1 File Structure

권장 파일 구조는 다음이다.

```text
real_vla_book/
  00_book_bible/
    book_bible_v0_1.md
    global_glossary.md
    citation_policy.md
    open_issues.md
  01_chapter_contracts/
    ch01_contract.md
    ch13_contract.md
  02_evidence_maps/
    ch01_evidence_map.md
    ch13_evidence_map.md
  03_drafts/
    ch01_draft.md
    ch13_draft.md
  04_revision_logs/
    ch01_revision_log.md
    ch13_revision_log.md
  05_figures_tables/
    figure_inventory.md
    table_inventory.md
  06_final_manuscript/
```

### 12.2 Revision Log Template

```text
Revision Log - Chapter [N]

Date:
Version:
Changed sections:
Reason for change:
Claims added:
Claims weakened or removed:
Citations added/updated:
Open issues created/resolved:
Remaining risks:
```

### 12.3 Cross-reference Map Template

```text
Concept: [e.g., action chunk]
First definition: Ch13 Sec 13.X
Used in: Ch3, Ch8, Ch14, Ch18, Ch20
Potential conflict: action chunk vs trajectory segment vs skill call
Required consistency check: notation, frequency, controller boundary
```

---

## 13. Initial Locked Decisions

### 13.1 Decisions That Should Not Change Without Book Bible Update

1. 책 제목은 **Real VLA: A Roboticist's Perspective**를 기본안으로 한다.
2. 중심 thesis는 “VLA는 controller replacement가 아니라 embodied policy interface”이다.
3. 전체 구조는 5개 Part + 21 Chapter를 기본안으로 한다.
4. Chapter 1, 13, 14, 16, 19를 먼저 작성하는 wave order를 따른다.
5. Chapter 13은 책의 action API 정의서로 취급한다.
6. Evaluation과 Safety는 한 장으로 합치지 않는다.
7. Gemini Robotics-ER류는 우선 embodied reasoning/orchestration layer로 다룬다.
8. GR00T/Figure Helix류는 humanoid/whole-body case study로 다루되 evidence tier를 명시한다.
9. Company demo는 conceptual example로만 쓰고, 독립 검증된 연구성과처럼 쓰지 않는다.
10. 각 장은 반드시 실제 robot system interface와 연결한다.

### 13.2 Immediate Next Tasks

Book Bible v0.1 이후의 다음 작업은 다음 순서로 진행한다.

1. Ch1과 Ch13의 Chapter Contract 작성.
2. Ch1과 Ch13에서 정의할 global terminology 목록 확정.
3. Ch13 Evidence Map 작성.
4. Ch14, Ch16, Ch19 Chapter Contract 작성.
5. Ch1 Section 1.1 본문 초안 작성.

---

## 14. Minimal Operating Rule

앞으로 어떤 장을 쓰더라도 다음 세 질문에 답하지 못하면 그 section은 아직 준비되지 않은 것이다.

1. **이 내용은 Real VLA stack의 어느 interface를 설명하는가?**
2. **이 claim은 어떤 source tier에 의해 뒷받침되는가?**
3. **실제 로봇에서 이 관점이 실패하는 조건은 무엇인가?**

이 세 질문이 Book Bible v0.1의 최소 운영 규칙이다.
