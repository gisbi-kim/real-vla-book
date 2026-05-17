# Real VLA: A Roboticist's Perspective

## Wave 1 Chapter Contracts v0.1

**문서 목적:** Book Bible v0.1을 기준으로 Wave 1 핵심 5개 장의 역할, 섹션 구조, 핵심 주장, reference tier, failure mode, cross-link를 고정한다. 이 문서는 본문 원고가 아니라 이후 원고 생성을 제어하기 위한 **chapter-level contract**이다.  
**버전:** 2026.05.12  
**상태:** Working specification. 이후 Chapter 1/13 interface specification과 section draft 작성의 기준 문서로 사용한다.  
**대상 장:** Ch1, Ch13, Ch14, Ch16, Ch19.

---

## 0. Locked Basis

### 0.1 Core Thesis

> **A real VLA is not a model that replaces robotics; it is a policy interface that reorganizes control, planning, perception, language, data, and safety into one embodied system.**

한국어 원고에서는 다음 문장을 책 전체의 반복 thesis로 사용한다.

> **VLA는 로봇 제어이론의 대체물이 아니라, task semantics와 embodied perception을 action-generation으로 연결하는 새로운 policy interface다.**

이 문장은 Wave 1의 모든 장에서 다른 언어로 재증명되어야 한다. Ch1은 system stack으로, Ch13은 action/control boundary로, Ch14는 data engine으로, Ch16은 evidence/evaluation으로, Ch19는 safety/assurance로 이 thesis를 구체화한다.

### 0.2 Wave 1의 역할

Wave 1은 본문 집필의 기준축이다. 장 번호순으로 원고를 쓰지 않고, 먼저 다음 다섯 장을 계약서 수준에서 고정한다.

| Chapter | Title | Wave 1에서의 역할 |
|---:|---|---|
| Ch1 | What Is a Real VLA System? | 책 전체의 세계관, stack, 용어, 책임 경계를 고정한다. |
| Ch13 | Action Representation | VLA output을 control boundary로 해석하는 action API를 고정한다. |
| Ch14 | Data Engines | VLA 성능 주장의 근거가 되는 data collection/curation/evaluation loop를 고정한다. |
| Ch16 | Evaluation and Benchmarking | benchmark score와 실제 robot capability를 분리하는 증거 기준을 고정한다. |
| Ch19 | Safety and Assurance | safety를 모델 속성이 아니라 stack property로 정의한다. |

### 0.3 공통 서술 구조

각 장은 가능하면 다음 구조를 따른다.

1. **Problem** - 이 장이 다루는 로봇 문제는 무엇인가?
2. **Classical formulation** - 제어, 계획, 추정, 최적화에서는 이 문제를 어떻게 썼는가?
3. **Learning formulation** - imitation learning, RL, visuomotor policy에서는 무엇이 달라졌는가?
4. **VLA formulation** - language, vision, action, data scaling이 들어오면서 무엇이 다시 정의되었는가?
5. **System interface** - 실제 robot stack에서는 어느 input/output boundary에 해당하는가?
6. **Failure mode** - latency, contact, distribution shift, safety, benchmark artifact, hardware constraint가 어디서 문제를 만드는가?

### 0.4 Claim and Source Tier Policy

Wave 1은 최신 논문과 회사 시스템을 많이 다루므로 claim tier를 분리한다.

| Tier | 예시 | 원고에서의 사용법 |
|---|---|---|
| Tier A: textbook / classical paper | Kalman filtering, MPC, operational space control, STRIPS, PRM/RRT | 안정적인 배경 이론으로 사용한다. 단, VLA와 연결되는 interface만 자세히 다룬다. |
| Tier B: peer-reviewed robotics/ML paper | Diffusion Policy, DAgger, RT-1, CLIP 등 | 개념적 근거와 역사적 turning point로 사용한다. |
| Tier C: arXiv / preprint / project paper | OpenVLA, π0, FAST, vla-eval, BeTTER 등 | 최신 흐름의 evidence로 사용하되, 과장 없이 한계와 함께 다룬다. |
| Tier D: official company page / GitHub / release | Gemini Robotics-ER 1.6, NVIDIA Isaac GR00T N1.7, OpenVLA-OFT project page | 검증된 일반 원리로 쓰지 않고 **case study** 또는 **source-watch item**으로 둔다. |
| Tier E: news / blog / secondary source | 기사, 요약 블로그 | 본문 claim의 primary evidence로 사용하지 않는다. 필요하면 맥락 설명에만 제한적으로 사용한다. |

---

# Chapter 1 Contract

## Chapter 1. What Is a Real VLA System?

### 1. One-sentence Thesis

**Real VLA는 더 큰 VLM이 아니라, language-conditioned embodied reasoning, VLA policy, motion/control, safety, data/evaluation이 서로 계약을 맺는 robot system stack이다.**

### 2. 이 장이 책 전체에서 맡는 역할

Ch1은 책의 header file이다. 독자가 이후 classical control, robot learning, VLM, action representation, data, evaluation, safety 장을 읽을 때 사용할 공통 vocabulary와 system boundary를 제공한다. 이 장의 목적은 “VLA가 무엇인가?”를 모델 이름으로 답하는 것이 아니라, “언어적 목표가 물리적 action으로 바뀌는 과정에서 어떤 layer가 무엇을 책임지는가?”로 답하는 것이다.

이 장은 특히 다음 오해를 초반에 차단해야 한다.

- VLA는 VLM에 robot action token을 붙인 것일 뿐이라는 오해.
- VLA가 low-level controller를 완전히 대체한다는 오해.
- benchmark success가 real robot competence와 동일하다는 오해.
- 최신 company demo가 곧 검증된 embodied intelligence라는 오해.

### 3. 이전 장에서 받아오는 개념

Ch1은 Part 0의 시작 장이므로 이전 장이 없다. 대신 독자가 최소한 다음 직관을 가지고 있다고 가정한다.

| 선수 개념 | 필요한 수준 |
|---|---|
| Robot action | position/velocity/torque/waypoint/action chunk가 서로 다르다는 감각 |
| Feedback loop | observation과 action이 반복되는 closed-loop system이라는 감각 |
| Foundation model | VLM/LLM이 vision-language representation을 학습한다는 감각 |
| Robot deployment | 실제 robot은 latency, safety, hardware limit, failure recovery를 갖는다는 감각 |

### 4. 이후 장으로 넘겨주는 개념

| 넘겨주는 개념 | 받는 장 | Ch1에서의 깊이 | 이후 장에서의 깊이 |
|---|---:|---|---|
| Observation vs state | Ch2 | 문제 제기 | state estimation, latency, partial observability로 상세화 |
| Control interface | Ch3, Ch13 | stack boundary로 정의 | action representation과 controller contract로 상세화 |
| Contact and physical interaction | Ch4, Ch19 | failure mode로 소개 | impedance, force, dynamic safety로 상세화 |
| Planning/TAMP boundary | Ch5, Ch17 | high-level reasoning layer로 소개 | symbolic-continuous feasibility와 ER+VLA로 상세화 |
| Data engine | Ch14 | evidence layer로 정의 | collection, curation, labeling, failure data로 상세화 |
| Evaluation protocol | Ch16 | real VLA vs benchmark VLA 구분 | benchmark validity와 reproducibility로 상세화 |
| Safety stack | Ch19 | model property가 아니라 stack property로 정의 | semantic/geometric/dynamic/system/data safety로 상세화 |

### 5. Section-level Outline and Core Claims

| Section | 제목 | 핵심 주장 | 다음 장과의 연결 |
|---:|---|---|---|
| 1.1 | Why Real VLA Is Not Just a Bigger VLM | VLA의 본질은 vision-language representation이 아니라 physical action boundary에 있다. | Ch13으로 action boundary를 넘긴다. |
| 1.2 | From Language Goal to Motor Command | instruction이 바로 torque가 되는 것이 아니라 subgoal, policy output, controller target, safety decision을 거친다. | Ch3/Ch5/Ch17과 연결된다. |
| 1.3 | The Five-layer Real VLA Stack | Embodied reasoning, VLA policy, motion/control, safety/assurance, data/evaluation layer를 정의한다. | 전체 책의 공통 stack으로 사용된다. |
| 1.4 | Interface Contracts: Observation, State, Action, Controller | stack이 작동하려면 각 layer의 input/output 계약이 명확해야 한다. | Ch2/Ch3/Ch13의 용어를 예고한다. |
| 1.5 | Real VLA vs Benchmark VLA | benchmark에서 잘하는 model과 실제 배치 가능한 system은 다르다. | Ch16/Ch19로 연결된다. |
| 1.6 | Failure Modes That Define the Field | hallucination보다 중요한 실패는 state mismatch, controller mismatch, latency, unsafe recovery, hidden benchmark assumption이다. | 모든 후속 장의 failure-mode lens가 된다. |
| 1.7 | How to Read VLA Papers as a Roboticist | 논문을 backbone, action representation, data, control interface, evaluation, safety 기준으로 읽는 법을 제시한다. | Ch12-21의 reading protocol이 된다. |

### 6. 핵심 수식 / 개념도 / 표

| 유형 | 제목 | 설명 | 삽입 위치 |
|---|---|---|---|
| Figure | Real VLA stack diagram | Language/instruction -> ER -> VLA policy -> controller -> robot/environment -> sensors -> data/eval/safety loop | 1.3 직후 |
| Table | Benchmark VLA vs Real VLA | success rate 중심 benchmark와 deployment-oriented system의 차이 | 1.5 |
| Box | What counts as VLA? | pure VLM, planner, skill library, VLA, embodied reasoning model의 경계 | 1.1 또는 1.3 |
| Equation | Closed-loop policy interface | \(a_t \sim \pi_\theta(\cdot \mid o_{\le t}, q_{\le t}, l, m_t)\), 단 여기서 \(a_t\)는 반드시 low-level torque일 필요가 없다는 점 강조 | 1.4 |
| Checklist | Six questions for reading a VLA paper | backbone/action/data/control/eval/safety 질문 | 1.7 |

### 7. 반드시 다룰 references and systems

| Tier | Reference / system | 이 장에서의 역할 |
|---|---|---|
| B/C | RT-1, RT-2, PaLM-E, OpenVLA, π0 | VLA가 image-language-action interface로 등장한 역사적 사례 |
| C/D | Gemini Robotics / Gemini Robotics-ER | VLA와 embodied reasoning layer를 분리해서 볼 수 있는 case study |
| D | NVIDIA Isaac GR00T | humanoid/generalist VLA가 system stack으로 가는 case study |
| B/C | Diffusion Policy, ACT/ALOHA, OpenVLA-OFT, FAST | action representation이 model architecture보다 control boundary 문제임을 예고하는 사례 |
| C | vla-eval, BeTTER | benchmark success와 embodied reasoning/evaluation validity를 분리하는 사례 |
| C/D | ASIMOV / ASIMOV-2.0 | physical AI safety가 별도의 layer로 필요함을 예고하는 사례 |

### 8. 빠지면 안 되는 failure modes

- **Model-stack mismatch:** VLM/VLA가 좋은 plan을 내도 controller가 추적할 수 없는 action이면 실패한다.
- **Observation-state mismatch:** image observation이 robot/environment state를 완전히 대표하지 못한다.
- **Action granularity mismatch:** high-level subgoal, waypoint, delta pose, torque를 혼동하면 system boundary가 붕괴한다.
- **Latency mismatch:** VLA inference rate와 controller loop rate가 다르면 closed-loop behavior가 불안정해질 수 있다.
- **Benchmark artifact:** benchmark score가 real-world robustness, recovery, safety를 대표하지 않을 수 있다.
- **Safety externalization:** safety를 “나중에 wrapper로 붙이면 된다”고 취급하면 deployment story가 약해진다.

### 9. Roboticist's Takeaway 초안

> **A real VLA is not a replacement for robotics. It is a new interface layer that makes robotics more semantic, but it still depends on state estimation, control, planning, data, evaluation, and safety.**

한국어 본문에서는 다음 형태로 쓴다.

> **Real VLA는 로봇공학을 대체하는 모델이 아니라, 로봇공학의 여러 layer를 언어와 시각 의미론 아래에서 다시 연결하는 interface이다.**

### 10. 조심해야 할 과장 / 오해

| 위험한 표현 | 수정 방향 |
|---|---|
| “VLA가 로봇을 직접 제어한다” | 어떤 action interface를 통해 어떤 controller와 연결되는지 명시한다. |
| “Gemini Robotics-ER는 VLA다” | ER layer 또는 orchestrator로 설명하고, action-producing VLA와 구분한다. |
| “benchmark에서 SOTA이므로 generalist robot intelligence다” | benchmark protocol과 real deployment evidence를 분리한다. |
| “end-to-end면 더 real하다” | modular assurance와 recovery가 필요한 경우를 함께 설명한다. |
| “safety는 별도 장에서만 다룬다” | Ch1에서 safety를 stack layer로 먼저 선언한다. |

### 11. Ch1 작성 전 잠금 질문

1. 이 책에서 VLA의 최소 정의는 action-producing model인가, action-producing stack인가?
2. ER model이 직접 action을 내지 않을 때도 VLA system의 일부로 부를 것인가?
3. Skill invocation과 action generation의 경계는 어떻게 정의할 것인가?
4. “Real VLA”의 real은 physical deployment인가, system-completeness인가, evaluation validity인가?

---

# Chapter 13 Contract

## Chapter 13. Action Representation

### 1. One-sentence Thesis

**Action representation은 VLA의 출력 포맷 문제가 아니라, model이 어디까지 의미 추론을 하고 어디부터 controller가 물리 실행을 책임지는지를 정하는 control boundary 문제이다.**

### 2. 이 장이 책 전체에서 맡는 역할

Ch13은 책의 기술적 중심 장이다. Ch1이 Real VLA stack을 정의한다면, Ch13은 그 stack에서 VLA policy layer가 motion/control layer와 만나는 API를 정의한다. 이 장의 결론이 흔들리면 Ch3, Ch14, Ch16, Ch18, Ch19, Ch20의 해석이 모두 흔들린다.

이 장은 다음 질문에 답해야 한다.

- VLA가 내는 action은 token인가, continuous vector인가, trajectory인가, controller target인가?
- action chunking은 왜 단순 inference acceleration이 아니라 temporal abstraction인가?
- diffusion/flow action head는 왜 multimodal contact-rich behavior와 연결되는가?
- action tokenizer는 NLP-style convenience인가, robot control interface인가?
- humanoid/whole-body setting에서는 action representation이 왜 더 어려워지는가?

### 3. 이전 장에서 받아오는 개념

| 받는 개념 | 받는 장 | Ch13에서의 사용법 |
|---|---:|---|
| Real VLA stack | Ch1 | VLA policy layer와 motion/control layer의 boundary로 사용 |
| State/observation/proprioception | Ch2 | action이 condition되는 input variable 정의에 사용 |
| Control modes | Ch3 | joint position, velocity, torque, end-effector delta, waypoint의 차이 설명 |
| Contact/compliance | Ch4 | action smoothness, force/impedance, contact-rich manipulation의 필요성 설명 |
| Imitation learning/covariate shift | Ch6 | action chunking과 compounding error 설명 |
| Control as inference / distribution | Ch7 | diffusion/flow policy를 확률적 action distribution으로 설명 |
| Robotics Transformer era | Ch12 | tokenized action의 역사적 출발점 설명 |

### 4. 이후 장으로 넘겨주는 개념

| 넘겨주는 개념 | 받는 장 | 이유 |
|---|---:|---|
| Action normalization / embodiment adapter | Ch14, Ch15 | multi-embodiment dataset과 fine-tuning recipe의 핵심 |
| Evaluation metrics beyond success | Ch16 | smoothness, latency, throughput, recovery, control frequency 측정 필요 |
| Hierarchical VLA interfaces | Ch17 | ER layer가 subgoal을 내고 VLA가 action chunk를 내는 구조 설명 |
| Real-time constraints | Ch18 | action generation throughput과 controller loop frequency 연결 |
| Safety filters | Ch19 | action이 safety shield에 들어가기 전 어떤 형태인지 정의 |
| Whole-body action space | Ch20 | humanoid action representation의 확장 문제 설명 |

### 5. Section-level Outline and Core Claims

| Section | 제목 | 핵심 주장 | 대표 사례 |
|---:|---|---|---|
| 13.1 | Why Action Representation Is the Control Boundary | action format은 robot stack의 책임 분할을 결정한다. | Ch1 stack, OSC/MPC interface |
| 13.2 | Discrete Action Tokens | tokenized action은 VLM/LLM pipeline과 잘 맞지만 quantization, latency, high-frequency control 한계가 있다. | RT-2, OpenVLA |
| 13.3 | Continuous Regression and Normalization | continuous action은 controller와 자연스럽지만 embodiment/action scale 차이를 엄격히 관리해야 한다. | BC, Octo, OpenVLA variants |
| 13.4 | Action Chunking as Temporal Interface | chunk는 compounding error와 temporal consistency 문제를 줄이지만 recovery granularity를 바꾼다. | ACT, ALOHA, Mobile ALOHA |
| 13.5 | Diffusion Policies and Multimodal Actions | diffusion은 multimodal action distribution을 표현하는 강력한 방식이지만 sampling cost와 real-time 문제가 있다. | Diffusion Policy, RDT-1B |
| 13.6 | Flow Matching and Action Expert | flow matching은 continuous action generation을 더 direct하게 만들며 VLM backbone과 action expert 분리를 가능하게 한다. | π0, π0.5 |
| 13.7 | Action Tokenizers and Compression | action tokenization은 단순 binning이 아니라 temporal-frequency structure를 보존해야 한다. | FAST, FAST+ |
| 13.8 | Choosing an Interface for a Robot | action representation 선택은 task, robot, controller, data, latency, safety envelope에 의해 결정된다. | deployment design matrix |
| 13.9 | Failure Modes and Design Checklist | action API가 잘못 정해지면 model 성능보다 system failure가 먼저 온다. | mismatch examples |

### 6. 핵심 수식 / 알고리즘 / 표

| 유형 | 제목 | 설명 | 삽입 위치 |
|---|---|---|---|
| Equation | Single-step action policy | \(a_t \sim \pi_\theta(a \mid o_t, s_t, l)\). 여기서 \(a_t\)는 token, vector, waypoint, skill call이 될 수 있음을 명시한다. | 13.1 |
| Equation | Action chunk policy | \(A_t = (a_t, a_{t+1}, \ldots, a_{t+H-1}) \sim \pi_\theta(\cdot \mid o_{\le t}, l)\). | 13.4 |
| Equation | Diffusion action generation | \(A^0 \leftarrow \text{Denoise}_\theta(A^K, o, l)\). 자세한 diffusion derivation은 최소화하고 intuition 중심. | 13.5 |
| Equation | Flow matching | \(\frac{dA_\tau}{d\tau}=v_\theta(A_\tau, \tau, o, l)\). continuous trajectory in action space로 설명. | 13.6 |
| Figure | Action representation spectrum | discrete token -> continuous vector -> chunk -> diffusion/flow distribution -> whole-body action | 13.1 |
| Table | Action representation design matrix | token/regression/chunk/diffusion/flow/FAST의 장점, 한계, control compatibility 비교 | 13.8 |
| Box | Control boundary checklist | action frequency, smoothness, safety filter, controller type, recovery granularity 체크리스트 | 13.9 |

### 7. 반드시 다룰 references and systems

| 분류 | Reference / system | 이 장에서의 역할 |
|---|---|---|
| Discrete action token | RT-2, OpenVLA | action을 language-like token으로 다루는 흐름의 대표 사례 |
| Continuous action / fine-tuning | OpenVLA-OFT | continuous action, parallel decoding, action chunking, L1 objective의 practical recipe 사례 |
| Action chunking | ACT, ALOHA, Mobile ALOHA | bimanual manipulation과 temporal consistency의 핵심 사례 |
| Diffusion action | Diffusion Policy, RDT-1B | multimodal action distribution과 contact-rich behavior를 설명하는 핵심 사례 |
| Flow/action expert | π0, π0.5 | VLM backbone + continuous action expert 구조의 핵심 사례 |
| Action tokenization | FAST, FAST+ | DCT/compression 기반 action tokenizer와 high-frequency dexterity 논의 |
| Control background | operational space control, impedance control, MPC | action이 controller와 만나는 physical boundary 설명 |

### 8. 빠지면 안 되는 failure modes

- **Quantization loss:** discrete binning이 fine manipulation과 high-frequency action을 망칠 수 있다.
- **Mode averaging:** continuous regression이 multimodal action distribution을 평균내어 실패 action을 만들 수 있다.
- **Chunk inertia:** action chunk가 길수록 안정성은 좋아질 수 있지만 빠른 recovery가 어려워질 수 있다.
- **Controller mismatch:** VLA가 낸 delta pose나 joint command가 downstream controller와 맞지 않으면 실패한다.
- **Latency-control mismatch:** action generation throughput이 control frequency보다 낮으면 asynchronous execution design이 필요하다.
- **Embodiment mismatch:** 같은 token/action vector가 서로 다른 robot morphology에서 다른 물리 의미를 가질 수 있다.
- **Safety-shield incompatibility:** safety layer가 해석할 수 없는 action representation이면 runtime assurance가 약해진다.

### 9. Roboticist's Takeaway 초안

> **Action representation is not an implementation detail. It is the contract between semantic policy learning and physical control.**

한국어 본문에서는 다음 문장으로 사용한다.

> **Action representation은 VLA의 출력 포맷이 아니라, 의미 기반 policy와 물리 controller 사이의 계약이다.**

### 10. 조심해야 할 과장 / 오해

| 위험한 표현 | 수정 방향 |
|---|---|
| “token action은 구식이고 diffusion/flow가 정답이다” | task, data, latency, controller, safety에 따라 trade-off가 다르다고 설명한다. |
| “diffusion은 항상 더 안전하다” | multimodal 표현력과 safety guarantee는 별개의 문제라고 분리한다. |
| “action chunking은 단순히 빠르게 실행하기 위한 trick이다” | temporal abstraction, compounding error, recovery granularity 문제로 설명한다. |
| “continuous action이면 controller와 바로 연결된다” | normalization, scaling, saturation, impedance, tracking layer를 반드시 명시한다. |
| “humanoid action은 manipulation action의 차원만 늘린 것이다” | whole-body dynamics, balance, contact, locomotion-manipulation coupling을 별도 문제로 둔다. |

### 11. Ch13 작성 전 잠금 질문

1. 이 책에서 “action”은 low-level motor command만 뜻하는가, controller target도 포함하는가?
2. action chunk의 기본 시간 horizon을 수식에서 어떻게 표기할 것인가?
3. skill invocation을 action representation에 포함할 것인가, Ch17에서 별도 hierarchy로 둘 것인가?
4. safety filter가 action representation 앞에 있는가, 뒤에 있는가, 아니면 여러 layer에 있는가?

---

# Chapter 14 Contract

## Chapter 14. Data Engines

### 1. One-sentence Thesis

**VLA의 성능은 모델 아키텍처만의 산물이 아니라, 어떤 embodiment에서 어떤 action을 어떤 언어와 성공/실패 맥락으로 수집·정제·평가했는지를 반복적으로 개선하는 data engine의 산물이다.**

### 2. 이 장이 책 전체에서 맡는 역할

Ch14는 “모델 성능”이라는 표현 뒤에 숨어 있는 evidence-production system을 드러내는 장이다. VLA는 웹 LLM처럼 텍스트 토큰만 스케일링하면 되는 문제가 아니다. robot dataset은 embodiment, sensor setup, action space, control frequency, task distribution, language labeling, success/failure annotation, human teleoperation style의 영향을 받는다.

이 장은 Ch13에서 정의한 action representation이 dataset 설계에서 어떤 문제를 만드는지 보여주고, Ch16의 evaluation과 Ch19의 safety가 data engine 안으로 들어와야 한다는 점을 정리한다.

### 3. 이전 장에서 받아오는 개념

| 받는 개념 | 받는 장 | Ch14에서의 사용법 |
|---|---:|---|
| Real VLA stack | Ch1 | data/evaluation layer를 독립 layer가 아니라 system feedback loop로 설명 |
| Control/action interface | Ch3, Ch13 | action labels와 control modes의 compatibility 설명 |
| Imitation learning/covariate shift | Ch6 | demonstration dataset의 distribution problem 설명 |
| Visuomotor policies | Ch8 | image-to-action dataset의 한계와 language-conditioned data로의 확장 설명 |
| Robotics Transformer era | Ch12 | RT-X/Open X-Embodiment, OpenVLA류 data scaling 흐름 설명 |

### 4. 이후 장으로 넘겨주는 개념

| 넘겨주는 개념 | 받는 장 | 이유 |
|---|---:|---|
| Dataset mixture and curation | Ch15 | fine-tuning recipe와 adaptation data selection의 기반 |
| Benchmark protocol data leakage | Ch16 | evaluation validity와 train/test split 논의의 기반 |
| Failure data / unsafe data | Ch19 | safety-aware data curation의 기반 |
| Deployment logs | Ch18, Ch21 | online improvement, monitoring, self-improving loops의 기반 |
| Multi-embodiment normalization | Ch20 | humanoid/whole-body VLA의 action/state scaling 문제와 연결 |

### 5. Section-level Outline and Core Claims

| Section | 제목 | 핵심 주장 | 대표 사례 |
|---:|---|---|---|
| 14.1 | Robot Data Is Not Web Data | robot data는 embodiment와 action/control interface에 묶여 있다. | Open X-Embodiment |
| 14.2 | Demonstration Collection | teleoperation, kinesthetic teaching, scripted policy, autonomous collection은 서로 다른 bias를 만든다. | BridgeData V2, DROID, ALOHA |
| 14.3 | Multi-Embodiment and Action Normalization | robot morphology와 action space 차이를 normalize하지 않으면 scaling이 illusion이 된다. | RT-X, Octo, OpenVLA |
| 14.4 | Language Labels, Relabeling, and Task Semantics | language label은 task semantics를 주지만 ambiguity와 leakage도 만든다. | language-conditioned manipulation datasets |
| 14.5 | Simulation, Synthetic Data, and Human Video | sim/human video/synthetic data는 coverage를 늘리지만 embodiment/action grounding gap이 있다. | ManiSkill, CALVIN, synthetic VLA pipelines |
| 14.6 | Failure Data and Recovery Data | 성공 demonstration만으로는 real deployment의 recovery를 학습하기 어렵다. | failure relabeling, recovery logs |
| 14.7 | Curation, Dataset Cards, and Evidence Hygiene | data quality는 size보다 중요할 수 있으며 dataset documentation이 필요하다. | dataset cards, benchmark metadata |
| 14.8 | The Data Engine Loop | collection -> curation -> training -> evaluation -> deployment log -> new data의 closed loop를 설계해야 한다. | VLA Foundry, open-source stacks |
| 14.9 | Data Risks | unsafe behavior, privacy, domain bias, contamination, hidden normalization statistics가 성능 주장과 safety를 흔든다. | Ch16/Ch19 bridge |

### 6. 핵심 수식 / 알고리즘 / 표

| 유형 | 제목 | 설명 | 삽입 위치 |
|---|---|---|---|
| Equation | Dataset mixture | \(\mathcal{D}=\bigcup_i w_i\mathcal{D}_i^{(robot,task,action)}\). 각 dataset이 robot/action/task distribution을 가진다는 점을 명시한다. | 14.1 |
| Equation | Action normalization | \(\tilde a=(a-\mu_{r,k})/\sigma_{r,k}\), robot \(r\), action channel \(k\)별 통계 필요성을 설명한다. | 14.3 |
| Algorithm | Data engine loop | Collect -> annotate/relabel -> filter -> train -> evaluate -> deploy -> log failure -> collect again | 14.8 |
| Table | Data source comparison | teleop, autonomous, sim, synthetic, human video, web video의 장점/한계/action grounding 비교 | 14.2-14.5 |
| Box | Dataset claim hygiene | dataset size, embodiment count, task count, success labels, train/test splits, hidden preprocessing 체크리스트 | 14.7 |

### 7. 반드시 다룰 references and systems

| 분류 | Reference / system | 이 장에서의 역할 |
|---|---|---|
| Multi-embodiment scaling | Open X-Embodiment / RT-X | cross-embodiment robot data scaling의 대표 사례 |
| Generalist policies | Octo, OpenVLA | large robot dataset 기반 open-source generalist policy 사례 |
| In-the-wild data | DROID | 다양한 scene/collector에서 모은 real robot manipulation data 사례 |
| Broad manipulation data | BridgeData V2 | open-vocabulary/language-conditioned manipulation dataset 사례 |
| Teleoperation/chunking data | ALOHA, Mobile ALOHA | action chunking과 bimanual/mobile manipulation data collection 사례 |
| Simulation benchmarks/data | CALVIN, LIBERO, ManiSkill | sim-based data/eval ecosystem의 대표 사례 |
| Engineering stack | VLA Foundry | data, model, action expert training을 연결하는 open-source training stack 사례 |

### 8. 빠지면 안 되는 failure modes

- **Dataset-size illusion:** trajectory 수가 많아도 embodiment/task/action coverage가 좁으면 generalization claim이 약하다.
- **Embodiment leakage:** 특정 robot morphology나 camera setup에 맞춘 shortcut이 general policy처럼 보일 수 있다.
- **Language-label ambiguity:** 같은 instruction이 scene/context에 따라 다른 action을 요구할 수 있다.
- **Action-statistics leakage:** hidden normalization statistics가 evaluation reproducibility를 망칠 수 있다.
- **Success-only bias:** 실패와 recovery data가 없으면 real deployment에서 반복 실패가 누적될 수 있다.
- **Synthetic grounding gap:** generated image/video는 semantic variety를 늘리지만 physical action grounding을 보장하지 않는다.
- **Unsafe demonstration contamination:** unsafe behavior가 dataset에 섞이면 policy가 그것을 imitation할 수 있다.

### 9. Roboticist's Takeaway 초안

> **For VLA, data is not just examples. Data is the encoded history of embodiment, control interface, operator bias, task distribution, failures, and evaluation assumptions.**

한국어 본문에서는 다음 문장으로 사용한다.

> **VLA 데이터는 단순한 예제 묶음이 아니라, embodiment, controller, operator, task distribution, failure, evaluation protocol이 함께 기록된 시스템 흔적이다.**

### 10. 조심해야 할 과장 / 오해

| 위험한 표현 | 수정 방향 |
|---|---|
| “데이터가 많으면 generalization이 된다” | embodiment/action/task coverage와 curation quality를 함께 본다. |
| “web-scale data처럼 robot data도 스케일링하면 된다” | robot data는 action grounding과 physical constraint를 갖는다고 설명한다. |
| “sim data는 real data를 대체한다” | sim은 coverage와 controlled evaluation에는 강하지만 sim-to-real gap을 가진다고 쓴다. |
| “human video는 robot data와 같다” | semantics는 풍부하지만 robot action label이 없다는 점을 분리한다. |
| “failure data는 부정적 예제라서 덜 중요하다” | recovery와 safety 학습에는 failure data가 핵심이라고 설명한다. |

### 11. Ch14 작성 전 잠금 질문

1. Ch14에서 VLA Foundry를 training stack으로 다룰 것인가, Ch15로 넘길 것인가?
2. dataset size claim을 표준화할 때 trajectory, episode, hour, task, scene, robot 수 중 무엇을 우선할 것인가?
3. unsafe/failure data를 safety 장으로 넘길 것인가, data engine의 필수 구성으로 먼저 선언할 것인가?
4. synthetic data와 human video는 VLA data로 볼 것인가, pretraining/augmentation source로 제한할 것인가?

---

# Chapter 16 Contract

## Chapter 16. Evaluation and Benchmarking

### 1. One-sentence Thesis

**VLA 평가의 목적은 높은 success rate를 기록하는 것이 아니라, 어떤 robot capability가 어떤 조건에서 재현 가능하고 어떤 조건에서 무너지는지를 분리해서 증명하는 것이다.**

### 2. 이 장이 책 전체에서 맡는 역할

Ch16은 책의 evidence standard를 고정한다. VLA 논문은 success rate, leaderboard, simulation benchmark, real robot demo를 자주 제시하지만, 그 숫자가 실제 robot capability를 얼마나 설명하는지는 protocol에 따라 달라진다. 이 장은 benchmark를 부정하지 않는다. 오히려 benchmark가 왜 필요한지 인정하면서, benchmark를 real deployment claim으로 과잉 해석하지 않는 방법을 제시한다.

이 장은 Ch14의 data hygiene과 Ch19의 safety assurance 사이에 위치한다. 데이터가 무엇을 학습시켰는지와 평가가 무엇을 증명했는지를 분리하지 못하면, VLA system claim은 설득력을 잃는다.

### 3. 이전 장에서 받아오는 개념

| 받는 개념 | 받는 장 | Ch16에서의 사용법 |
|---|---:|---|
| Real VLA vs Benchmark VLA | Ch1 | benchmark score와 deployment capability 분리 |
| Action representation | Ch13 | success rate 외에 smoothness, latency, throughput, control frequency 평가 필요성 설명 |
| Data engine | Ch14 | train/test split, hidden preprocessing, dataset contamination 문제 설명 |
| Adaptation/fine-tuning | Ch15 | benchmark-specific overfitting과 reproduction protocol 설명 |

### 4. 이후 장으로 넘겨주는 개념

| 넘겨주는 개념 | 받는 장 | 이유 |
|---|---:|---|
| Diagnostic evaluation | Ch17 | ER + VLA가 정말 reasoning하는지 평가하기 위한 기반 |
| Latency/throughput metrics | Ch18 | real-time deployment 평가 기준으로 연결 |
| Safety evaluation | Ch19 | unsafe action, intervention, recovery 평가 기준으로 연결 |
| Humanoid evaluation | Ch20 | whole-body action, balance, bimanual dexterity의 평가 기준으로 확장 |
| Open problems | Ch21 | embodied reasoning, causal generalization, self-improving loop 평가로 연결 |

### 5. Section-level Outline and Core Claims

| Section | 제목 | 핵심 주장 | 대표 사례 |
|---:|---|---|---|
| 16.1 | Why Success Rate Is Not Enough | success rate는 task completion의 한 요약값일 뿐, failure type과 deployment cost를 숨긴다. | benchmark score examples |
| 16.2 | Benchmark Families | manipulation, long-horizon, lifelong, sim, real-robot, open-vocabulary benchmark를 구분해야 한다. | LIBERO, CALVIN, ManiSkill, SimplerEnv |
| 16.3 | Protocol Variables and Hidden Confounders | camera, reset, termination, normalization, prompt, horizon, intervention rule이 결과를 바꿀 수 있다. | reproduction audits |
| 16.4 | Metrics Beyond Success | latency, smoothness, safety intervention, recovery, energy, human intervention, calibration을 함께 측정해야 한다. | real deployment metrics |
| 16.5 | Evaluation Harnesses and Reproducibility | benchmark별 script fragmentation을 줄이는 harness가 필요하다. | vla-eval |
| 16.6 | Distribution Shift and Diagnostic Tests | spatial layout shift, temporal extrapolation, causal intervention이 embodied reasoning을 더 잘 드러낼 수 있다. | BeTTER, causal eval |
| 16.7 | Real-Robot Evaluation Protocol | real robot 평가는 task randomization, failure logging, safety stop, repetition, confidence interval을 포함해야 한다. | lab protocol template |
| 16.8 | Reading Leaderboards | leaderboard는 useful signal이지만 model capability의 완전한 순위표가 아니다. | leaderboard caveats |
| 16.9 | Evaluation Checklist | paper/system을 읽을 때 물어야 할 reproducibility/evidence 질문을 정리한다. | reviewer checklist |

### 6. 핵심 수식 / 알고리즘 / 표

| 유형 | 제목 | 설명 | 삽입 위치 |
|---|---|---|---|
| Equation | Success rate with uncertainty | \(\hat p = \frac{1}{N}\sum_i \mathbf{1}[success_i]\). 작은 N에서 confidence interval이 필요함을 설명한다. | 16.1 |
| Equation | Cost-weighted evaluation | \(J = \mathbb{E}[c_{fail}+c_{time}+c_{intervention}+c_{risk}]\). success-only metric의 한계를 설명한다. | 16.4 |
| Table | Benchmark taxonomy | LIBERO, CALVIN, ManiSkill, SimplerEnv, real-robot eval의 scope/strength/limits 비교 | 16.2 |
| Table | Hidden confounders | reset policy, horizon, termination, normalization, camera pose, prompts, human intervention | 16.3 |
| Figure | Evaluation stack | task suite -> protocol -> model server -> execution -> metric -> audit log | 16.5 |
| Box | Real-robot evaluation minimum report | robot, controller, action frequency, latency, task randomization, trial count, failure taxonomy, safety intervention report | 16.7 |

### 7. 반드시 다룰 references and systems

| 분류 | Reference / system | 이 장에서의 역할 |
|---|---|---|
| Simulation/long-horizon benchmarks | LIBERO, CALVIN, ManiSkill, SimplerEnv | VLA evaluation ecosystem의 대표 benchmark families |
| Evaluation harness | vla-eval | reproducibility, benchmark integration, parallel evaluation, hidden assumption audit의 핵심 사례 |
| Diagnostic benchmark | BeTTER | standard benchmark success와 true embodied reasoning을 분리하는 사례 |
| Dataset/eval boundary | Open X-Embodiment, Octo, OpenVLA | training/evaluation split과 published scores를 읽는 사례 |
| Safety benchmark bridge | ASIMOV / ASIMOV-2.0 | safety-aware evaluation으로 Ch19와 연결 |

### 8. 빠지면 안 되는 failure modes

- **Benchmark overfitting:** benchmark task distribution에 과도하게 맞춘 policy가 real setting에서 실패한다.
- **Underspecified protocol:** reset, termination, camera setup, normalization이 명시되지 않아 reproduction이 어렵다.
- **Hidden intervention:** 사람이 reset, object placement, prompt selection으로 암묵적으로 돕는 경우가 있다.
- **Success-only blindness:** success rate가 near-miss, collision, unsafe motion, excessive intervention을 숨긴다.
- **Distribution shift blindness:** spatial layout, distractor, timing, lighting 변화가 없는 benchmark는 robust reasoning을 검증하지 못한다.
- **Simulation comfort:** sim benchmark에서 높은 점수가 contact dynamics, latency, sensor noise를 충분히 반영하지 못할 수 있다.
- **Leaderboard compression:** 서로 다른 robot/action/control setup을 하나의 숫자로 압축하면 해석이 왜곡된다.

### 9. Roboticist's Takeaway 초안

> **A VLA benchmark score is not a robot capability. It is evidence produced under a protocol. The protocol must be read as carefully as the model architecture.**

한국어 본문에서는 다음 문장으로 사용한다.

> **VLA benchmark score는 robot capability 그 자체가 아니라, 특정 protocol 아래에서 생성된 evidence이다.**

### 10. 조심해야 할 과장 / 오해

| 위험한 표현 | 수정 방향 |
|---|---|
| “SOTA benchmark 결과가 real-world generalization을 의미한다” | benchmark scope와 shift condition을 명시한다. |
| “simulation benchmark는 쓸모없다” | controlled comparison의 장점과 sim-real limitation을 함께 쓴다. |
| “real robot demo면 충분하다” | trial count, randomization, failure logging, safety intervention이 필요하다고 설명한다. |
| “evaluation harness가 evaluation 문제를 해결한다” | harness는 reproducibility를 돕지만 metric validity는 별도 문제라고 쓴다. |
| “diagnostic benchmark에서 실패하면 모델 전체가 쓸모없다” | failure mode를 밝히는 도구로 해석한다. |

### 11. Ch16 작성 전 잠금 질문

1. 이 책의 기본 metric taxonomy를 success/safety/recovery/latency/smoothness/generalization으로 고정할 것인가?
2. VLA leaderboard를 본문에 넣을 것인가, 부록/source-watch로 둘 것인가?
3. BeTTER류 diagnostic benchmark를 “비판” 장으로 둘 것인가, evaluation 본문으로 통합할 것인가?
4. real robot evaluation minimum report template을 책의 부록으로 확장할 것인가?

---

# Chapter 19 Contract

## Chapter 19. Safety and Assurance

### 1. One-sentence Thesis

**VLA safety는 모델이 안전한 답을 생성하는 문제가 아니라, semantic filter, geometric constraint, dynamic controller, runtime monitor, recovery policy, human oversight, data governance가 함께 만드는 stack property이다.**

### 2. 이 장이 책 전체에서 맡는 역할

Ch19는 책의 deployment realism을 보장하는 장이다. VLA가 실제 물리 세계에 연결되면 오류의 비용이 텍스트 hallucination과 다르다. 잘못된 action은 물체 파손, 사람과의 충돌, 손가락 끼임, 과도한 힘, 미끄러짐, 열/전기/화학 위험, recovery failure로 이어질 수 있다. 따라서 safety를 모델 내부 alignment 문제로만 볼 수 없다.

이 장은 Ch1의 safety/assurance layer를 상세화하고, Ch13의 action representation이 safety filter와 어떻게 만나는지, Ch14의 unsafe/failure data가 어떻게 학습 위험을 만들 수 있는지, Ch16의 evaluation이 safety evidence를 어떻게 만들어야 하는지를 연결한다.

### 3. 이전 장에서 받아오는 개념

| 받는 개념 | 받는 장 | Ch19에서의 사용법 |
|---|---:|---|
| Real VLA stack | Ch1 | safety를 independent layer가 아니라 cross-cutting layer로 설명 |
| Control/contact | Ch3, Ch4 | force, compliance, saturation, collision avoidance, dynamic safety 설명 |
| Planning/TAMP | Ch5 | geometric feasibility, constraints, precondition/effect safety와 연결 |
| Action representation | Ch13 | safety shield가 해석할 수 있는 action 형태의 중요성 설명 |
| Data engine | Ch14 | unsafe demonstrations, failure data, negative examples, data governance 설명 |
| Evaluation | Ch16 | safety metric, intervention, benchmark validity와 연결 |
| Hierarchical ER+VLA | Ch17 | semantic safety filter와 action-producing policy의 책임 분리 설명 |
| Deployment latency | Ch18 | runtime monitor와 fail-safe timing 설명 |

### 4. 이후 장으로 넘겨주는 개념

| 넘겨주는 개념 | 받는 장 | 이유 |
|---|---:|---|
| Whole-body safety envelope | Ch20 | humanoid balance, bimanual contact, human proximity 문제로 확장 |
| Formal verification and assurance case | Ch21 | future direction의 핵심 open problem으로 연결 |
| Self-improving safety loops | Ch21 | deployment logs와 safety events를 학습 loop에 반영하는 문제로 연결 |

### 5. Section-level Outline and Core Claims

| Section | 제목 | 핵심 주장 | 대표 사례 |
|---:|---|---|---|
| 19.1 | Why Semantic Intelligence Does Not Guarantee Physical Safety | 명령을 이해하는 능력과 안전하게 실행하는 능력은 다르다. | unsafe command examples |
| 19.2 | A Taxonomy of VLA Safety | semantic, geometric, dynamic, system, data, cyber/operational safety를 분리한다. | safety taxonomy table |
| 19.3 | Semantic Safety and Instruction Filtering | 위험한 goal, ambiguous instruction, human-in-the-loop escalation을 다룬다. | ER model / policy filter |
| 19.4 | Geometric and Dynamic Safety | collision, workspace, force, torque, speed, impedance, control barrier 관점을 다룬다. | OSC/MPC/CBF/shield examples |
| 19.5 | Runtime Monitors, Shields, and Recovery | allow/modify/stop/retry/ask-human decision을 model output 뒤에 둔다. | runtime assurance stack |
| 19.6 | Safety in Data and Training | unsafe demonstrations, failure logs, negative examples, red-teaming data를 다룬다. | Ch14 link |
| 19.7 | Safety Evaluation and Benchmarks | ASIMOV류 semantic/physical safety benchmark를 Ch16의 evaluation frame과 연결한다. | ASIMOV, ASIMOV-2.0 |
| 19.8 | Assurance Cases for VLA Systems | “안전하다”가 아니라 “어떤 evidence로 어떤 hazard를 줄였는가”를 문서화한다. | deployment checklist |
| 19.9 | Anti-patterns | wrapper-only safety, demo-only validation, no recovery, hidden human intervention 등 피해야 할 패턴을 정리한다. | failure boxes |

### 6. 핵심 수식 / 알고리즘 / 표

| 유형 | 제목 | 설명 | 삽입 위치 |
|---|---|---|---|
| Equation | Safety set | \(x_t \in \mathcal{S}\), \(a_t \in \mathcal{A}_{safe}(x_t)\). VLA action은 safety set 안에서 해석되어야 한다. | 19.2 |
| Equation | Shielded action | \(a_t^{safe}=\operatorname{Shield}(a_t^{vla}, x_t, \mathcal{C})\). shield가 action을 allow/modify/stop할 수 있음을 표현한다. | 19.5 |
| Equation | CBF-style constraint | \(\dot h(x,u)+\alpha(h(x))\ge 0\). 자세한 증명보다 safety filter intuition 중심. | 19.4 |
| Table | VLA safety taxonomy | semantic/geometric/dynamic/system/data/cyber safety별 hazard, monitor, mitigation 비교 | 19.2 |
| Figure | Runtime assurance loop | VLA proposal -> safety monitor -> controller -> robot -> sensors -> recovery/human escalation | 19.5 |
| Box | Minimum safety report | robot, workspace, payload, max speed/force, E-stop, human proximity, failure recovery, unsafe task policy | 19.8 |

### 7. 반드시 다룰 references and systems

| 분류 | Reference / system | 이 장에서의 역할 |
|---|---|---|
| Embodied safety benchmark | ASIMOV, ASIMOV-2.0 | semantic and physical safety understanding benchmark 사례 |
| ER safety / orchestrator | Gemini Robotics-ER | high-level reasoning/safety judgement와 action-producing VLA 구분 사례 |
| Runtime assurance background | control barrier functions, reachability, MPC safety filters | VLA output을 physical safety layer와 연결하는 classical foundation |
| Robot interaction control | impedance/admittance, operational space control | force/contact safety의 control foundation |
| Evaluation bridge | vla-eval, BeTTER | benchmark validity와 reasoning/safety stress test 연결 |
| Deployment case studies | GR00T, humanoid VLA demos | humanoid/generalist robot의 safety envelope 확장 사례. 단, case study로만 다룬다. |

### 8. 빠지면 안 되는 failure modes

- **Semantic unsafe goal:** model이 위험한 task를 harmless하게 재해석하거나 실행 가능한 subgoal로 바꿀 수 있다.
- **Ambiguity under risk:** 모호한 명령을 확인 없이 실행하면 위험이 커진다.
- **Geometric collision:** VLA output이 obstacle/human/body self-collision을 고려하지 않을 수 있다.
- **Dynamic harm:** speed, torque, force, compliance가 안전 범위를 넘을 수 있다.
- **Recovery hazard:** 실패 후 복구 행동이 원래 실패보다 더 위험할 수 있다.
- **Overtrust:** 사람이 model capability를 과대평가해 unsafe operating envelope를 허용할 수 있다.
- **Data contamination:** unsafe demonstration과 hidden unsafe shortcuts이 policy behavior로 학습될 수 있다.
- **Monitor latency:** safety monitor가 action/control loop보다 느리면 개입이 늦을 수 있다.

### 9. Roboticist's Takeaway 초안

> **Safety cannot be delegated to the VLA. Safety is a property of the entire robot stack, from instruction filtering to physical control and recovery.**

한국어 본문에서는 다음 문장으로 사용한다.

> **Safety는 VLA가 대신 해결해주는 속성이 아니라, instruction filtering, geometric constraint, dynamic control, runtime monitor, recovery, human oversight가 함께 만드는 stack property이다.**

### 10. 조심해야 할 과장 / 오해

| 위험한 표현 | 수정 방향 |
|---|---|
| “safety filter를 붙이면 안전하다” | filter가 어떤 action/state/constraint를 보고 어떤 시간 안에 개입하는지 명시한다. |
| “LLM/VLM이 위험한 명령을 거절하면 충분하다” | semantic safety와 physical safety를 분리한다. |
| “benchmark safety score가 높으면 배치 가능하다” | deployment safety case와 hazard analysis가 별도 필요하다고 쓴다. |
| “human-in-the-loop이면 안전하다” | human reaction time, authority, interface design, alert fatigue를 고려해야 한다. |
| “모델이 더 똑똑해지면 safety 문제는 줄어든다” | capability increase는 new hazard도 만든다고 설명한다. |

### 11. Ch19 작성 전 잠금 질문

1. 이 책에서 safety standard family를 어느 정도까지 언급할 것인가? 실제 배치 가이드는 최신 표준 확인이 필요하다고 명시할 것인가?
2. CBF/reachability/MPC shield를 수식적으로 얼마나 깊게 들어갈 것인가?
3. ASIMOV류 benchmark를 semantic safety로 볼 것인가, physical safety benchmark로도 확장해 볼 것인가?
4. failure recovery를 safety 장에 둘 것인가, evaluation/deployment 장과 나눌 것인가?

---

# 5장 사이의 의존성 그래프

## 1. 개념 의존성

```text
             ┌────────────────────────────────────┐
             │ Ch1. What Is a Real VLA System?    │
             │ - stack                            │
             │ - layer responsibility             │
             │ - benchmark vs real VLA            │
             └───────────────┬────────────────────┘
                             │
          ┌──────────────────┼──────────────────┐
          │                  │                  │
          ▼                  ▼                  ▼
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│ Ch13. Action    │  │ Ch14. Data      │  │ Ch16. Evaluation │
│ Representation  │  │ Engines         │  │ and Benchmarking │
│ - action API    │  │ - evidence data │  │ - evidence test  │
│ - control bound │  │ - data loop     │  │ - protocol       │
└────────┬────────┘  └────────┬────────┘  └────────┬────────┘
         │                    │                    │
         └────────────┬───────┴───────────┬────────┘
                      ▼                   ▼
              ┌────────────────────────────────────┐
              │ Ch19. Safety and Assurance         │
              │ - semantic/geometric/dynamic safety │
              │ - runtime monitor / recovery       │
              │ - safety evidence                  │
              └────────────────────────────────────┘
```

## 2. 작업 의존성

| 먼저 고정해야 하는 것 | 그래야 가능한 것 |
|---|---|
| Ch1의 Real VLA stack | 모든 장의 layer terminology와 책임 경계 통일 |
| Ch13의 action API | Ch14의 action label/normalization, Ch16의 latency/smoothness metric, Ch19의 shield interface 정의 |
| Ch14의 data engine loop | Ch16의 evaluation validity, Ch19의 unsafe/failure data 논의 |
| Ch16의 evidence standard | Ch19의 safety evidence, Ch21의 future claim 절제 |
| Ch19의 safety taxonomy | Ch1의 stack 정의 보강, Ch18/20 deployment 장의 위험 분석 |

## 3. 다음 작업 순서 제안

### Immediate Next Tasks

1. **Ch1-Ch13 Interface Specification v0.1 작성**  
   Real VLA stack과 action representation이 서로 모순되지 않도록 observation, state, instruction, subgoal, action token, waypoint, delta pose, action chunk, trajectory, controller target, torque, whole-body action의 용어를 고정한다.

2. **Global Glossary v0.1 작성**  
   VLA, ER, VLM, action representation, action chunk, action token, action expert, data engine, evaluation protocol, safety shield, runtime monitor, recovery policy 등을 책 전체 용어로 고정한다.

3. **Figure/Table Inventory v0.1 작성**  
   Wave 1에서 반드시 필요한 figure/table/box를 한 문서에 모은다. 중복되는 diagram을 줄이고, chapter 간 cross-reference를 설계한다.

4. **Ch1 Section 1.1 원고 작성**  
   “Why Real VLA Is Not Just a Bigger VLM”을 첫 번째 본문 원고로 쓴다. 이 section은 책의 첫 페이지 수준의 anchor가 된다.

5. **Reviewer Critique Pass**  
   Wave 1 contracts를 control/robot learning/editor 세 관점에서 검토한 뒤, locked decision과 open issue를 분리한다.

### Suggested Prompt for Next Turn

```text
Wave 1 Chapter Contracts v0.1을 기준으로 Ch1-Ch13 Interface Specification v0.1을 작성해줘.

목표:
Real VLA stack과 action representation이 서로 모순되지 않도록 책 전체의 interface 용어를 고정하는 것.

반드시 포함:
1. observation, state, proprioception, memory의 정의
2. instruction, subgoal, plan, skill call의 정의
3. action token, continuous action, waypoint, delta pose, action chunk, trajectory target, torque, whole-body action의 정의
4. embodied reasoning layer와 VLA policy layer의 경계
5. VLA policy layer와 motion/control layer의 경계
6. safety layer가 어느 지점에서 action을 allow/modify/stop하는지
7. Ch1에서 먼저 설명할 것과 Ch13으로 넘길 것
8. Ch13에서 Ch1을 어떻게 참조할지
9. 용어 충돌 가능성과 해결안
10. 첫 번째 figure caption 초안

본문 원고는 쓰지 말고, interface specification 문서로 작성해줘.
md와 docx 둘 다 만들어줘.
```

---

# Open Issues

| Issue ID | 내용 | 현재 결정 | 영향 장 |
|---|---|---|---|
| OI-01 | Gemini Robotics-ER를 VLA로 부를 것인가? | 직접 action-producing VLA가 아니라 embodied reasoning/orchestrator layer로 다룬다. | Ch1, Ch17, Ch19 |
| OI-02 | action에 skill call을 포함할 것인가? | Ch1에서는 broad executable output으로 소개하되, Ch13에서는 robot control action 중심으로 제한한다. Skill call은 Ch17에서 hierarchy로 확장한다. | Ch1, Ch13, Ch17 |
| OI-03 | FAST는 action representation 장인가, fine-tuning 장인가? | Ch13에서는 action tokenizer로 다루고, Ch15에서는 practical adaptation recipe로 다시 참조한다. | Ch13, Ch15 |
| OI-04 | safety standard를 얼마나 자세히 다룰 것인가? | Ch19에서는 standard family를 언급하고, 실제 인증/규정 적용은 최신 표준 확인이 필요하다고 명시한다. | Ch19, Appendix 후보 |
| OI-05 | vla-eval은 benchmark 장의 중심인가? | Ch16에서 evaluation harness 대표 사례로 다루되, metric validity를 해결하는 만능 도구로 쓰지 않는다. | Ch16 |
| OI-06 | BeTTER류 연구를 얼마나 강하게 반영할 것인가? | Ch16에서 benchmark artifact와 embodied reasoning diagnostic의 핵심 사례로 다룬다. | Ch16, Ch17, Ch21 |
| OI-07 | failure data는 data 장인가 safety 장인가? | Ch14에서 data engine 구성요소로 먼저 정의하고, Ch19에서 safety-critical learning data로 다시 다룬다. | Ch14, Ch19 |

---

# Source Watch List for Wave 1

최신 시스템과 benchmark는 문서 작성 시점의 source-watch 항목으로 둔다. 본문 작성 직전에는 최신 release/version을 다시 확인한다.

| 항목 | 현재 사용 위치 | 확인할 것 |
|---|---|---|
| Gemini Robotics-ER 1.6 | Ch1, Ch17, Ch19 | ER layer, spatial reasoning, task planning, success detection, safety framing |
| NVIDIA Isaac GR00T N1.7 | Ch1, Ch20, Ch19 | humanoid/generalist VLA, embodiment/action space, open release status |
| OpenVLA-OFT | Ch13, Ch15 | continuous action, action chunking, parallel decoding, LIBERO/reported throughput |
| FAST / FAST+ | Ch13, Ch15 | action tokenizer, DCT/compression, high-frequency action sequence |
| vla-eval | Ch16 | benchmark harness, reproducibility audit, model-server/benchmark-server protocol |
| BeTTER | Ch16, Ch17, Ch21 | embodied reasoning diagnostic, causal intervention, benchmark artifact critique |
| ASIMOV / ASIMOV-2.0 | Ch19, Ch16 | semantic/physical safety benchmark, safety evaluation dimensions |
| VLA Foundry | Ch14, Ch15 | LLM/VLM/VLA training stack, data/model/action-expert integration |
