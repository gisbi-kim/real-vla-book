# VLA 공부를 위한 역사 정리 및 교과서형 논문 로드맵

**Version:** 2026.05 기준  
**Topic:** Vision-Language-Action Models, Robot Learning, Classical Planning, Control Theory

---

## 0. 전체 관점

VLA 교과서를 쓰려면 그냥 “요즘 로봇 파운데이션 모델”로 잡으면 얕아진다. 좋은 역사 서사는 다음과 같다.

> **VLA는 고전 제어·계획·모션플래닝 위에, 딥러닝 기반 perception-to-action, VLM/LLM의 언어·상식 grounding, 대규모 로봇 데이터 스케일링이 합쳐진 흐름이다.**

2026년 5월 기준 VLA는 보통 “이미지 + 언어 → 로봇 액션” 모델을 뜻하지만, 실제 시스템은 단일 end-to-end 모델만으로 끝나지 않는다. 많은 최신 시스템은 **상위 reasoning/planning 모델 + 하위 action policy/controller**의 계층 구조로 간다.

---

## 1. 한 장짜리 역사 지도

| 시대 | 핵심 질문 | 대표 흐름 | 교과서에서의 역할 |
|---|---|---|---|
| **1950s–1980s** | 로봇을 어떻게 안정적으로 움직이나? | 동적계획법, 칼만필터, LQR/MPC, force/impedance/operational-space control | VLA의 최종 action이 결국 물리계에 들어가므로 안정성·제약·접촉·실시간성을 설명하는 기반 |
| **1960s–2000s** | 복잡한 목표를 어떻게 계획하나? | A\*, STRIPS, PDDL, GraphPlan, FF planner | 언어 명령을 subgoal/plan으로 바꾸는 상위 reasoning의 조상 |
| **1990s–2010s** | 장애물과 연속공간을 어떻게 다루나? | PRM, RRT/RRT\*, CHOMP, TrajOpt, TAMP | VLA가 내놓은 subgoal이나 affordance를 실제 궤적으로 바꾸는 계층 |
| **2010s** | 시각에서 바로 action을 배울 수 있나? | DAgger, PILCO, Guided Policy Search, visuomotor policy, QT-Opt | End-to-end robot learning의 시작점 |
| **2017–2021** | 언어·시각 표현을 대규모로 학습할 수 있나? | Transformer, ViT, CLIP, Flamingo | VLA backbone의 표현학습 기반 |
| **2022** | LLM을 planner로 쓸 수 있나? | SayCan, Code as Policies, Inner Monologue, LM-Nav | LLM/VLM이 고전 planner의 일부를 대체하거나 보조하기 시작 |
| **2022–2023** | 로봇 action도 transformer가 예측할 수 있나? | BC-Z, Gato, RT-1, PaLM-E, RT-2, RoboCat | VLA라는 이름과 구조가 본격화 |
| **2023–2024** | 로봇 데이터도 웹데이터처럼 스케일링되나? | Open X-Embodiment, RT-X, Octo, DROID, BridgeData V2, OpenVLA | 범용 로봇 정책의 데이터 스케일링 시대 |
| **2024–2025** | 토큰 action만으로 충분한가? | Diffusion Policy, ACT/ALOHA, RDT-1B, π0, π0.5, OpenVLA-OFT, FAST | Continuous action, diffusion/flow policy, action chunking이 핵심으로 부상 |
| **2025–2026.05** | 현실 로봇에 배치 가능한가? | Gemini Robotics, Gemini Robotics-ER, GR00T N1, Figure Helix, VLA Foundry, safety/eval/data-engine 논문들 | Embodied reasoning, real-time inference, 안전성, 데이터 엔진, 평가체계가 최신 쟁점 |

---

# Part I. 전통 제어이론과 로봇 제어

VLA 책에서 제어이론을 앞에 넣는 게 좋다. VLA가 아무리 멋진 action token을 내도, 실제 로봇은 **동역학, 안정성, 접촉, saturation, delay, uncertainty** 안에서 움직인다. 이걸 모르면 VLA가 왜 low-level controller와 분리되거나, diffusion/flow action head가 왜 중요한지 설명이 안 된다.

## 2.1 상태추정과 최적제어

| 대표 논문/책 | 왜 중요하냐 |
|---|---|
| **Bellman, Dynamic Programming** | 최적제어, MDP, RL의 원류다. VLA의 policy learning을 역사적으로 설명할 때 출발점이 된다. |
| **Kalman, “A New Approach to Linear Filtering and Prediction Problems,” 1960** | 센서 노이즈와 상태추정의 표준 출발점이다. 로봇은 observation이 곧 state가 아니기 때문에 VLA에서도 proprioception/vision fusion을 설명할 때 필요하다. |
| **Mayne et al., “Constrained Model Predictive Control,” 2000** | MPC는 매 시점 finite-horizon 최적화 문제를 풀어 제약을 만족하는 control을 구하는 구조다. 현재 VLA와 planner/controller 결합을 설명할 때 가장 중요한 고전 제어 프레임 중 하나다. |

## 2.2 로봇 조작 제어

| 대표 논문/책 | 왜 중요하냐 |
|---|---|
| **Raibert & Craig, Hybrid Position/Force Control, 1981** | 접촉 작업에서 어떤 방향은 위치제어, 어떤 방향은 힘제어를 해야 한다는 기본 관점을 세웠다. Manipulation VLA에서 contact-rich task를 설명할 때 필요하다. |
| **Hogan, Impedance Control, 1985** | 로봇이 환경과 상호작용할 때 단순 position/force 제어보다 동적 거동, 즉 impedance를 제어해야 한다는 관점이다. VLA가 내는 action이 safe interaction으로 이어지려면 이 개념이 중요하다. |
| **Khatib, Operational Space Control, 1987** | Joint space가 아니라 task/operational space에서 motion과 force를 제어하는 프레임이다. End-effector action, Cartesian delta action, 6-DoF control을 설명하는 데 핵심이다. |
| **Featherstone, Articulated-Body Algorithm, 1983** | 다관절 로봇의 동역학 계산을 효율적으로 하는 기반이다. Humanoid VLA나 whole-body control을 설명할 때 배경으로 넣으면 좋다. |
| **Murray, Li, Sastry, A Mathematical Introduction to Robotic Manipulation** | Kinematics, dynamics, motion generation, control을 한 권으로 잇는 고전 교과서다. VLA 교과서의 classical robotics appendix나 Part I 참고문헌으로 좋다. |

### Part I의 핵심 메시지

VLA는 controller를 없애는 기술이 아니라, controller 위에 올라가는 **semantic policy layer** 또는 controller와 함께 학습되는 **action-generation layer**로 보는 게 정확하다.

---

# Part II. 전통 AI 계획, 모션플래닝, TAMP

VLA가 “언어 명령을 이해한다”고 할 때, 그 뿌리는 symbolic planning이다. LLM이 나오기 전부터 AI planning은 “초기 상태, goal, action precondition/effect”를 명시적으로 다뤘다.

## 3.1 Symbolic Planning

| 대표 논문 | 핵심 |
|---|---|
| **Hart, Nilsson, Raphael, A\*, 1968** | Heuristic search의 고전. Goal-directed planning의 출발점으로 넣으면 좋다. |
| **Fikes & Nilsson, STRIPS, 1971** | 초기 world model을 goal world model로 바꾸기 위해 action operator와 means-ends analysis를 쓴 고전 planning 시스템이다. |
| **Blum & Furst, GraphPlan, 1997** | Planning graph를 이용해 planning을 효율화한 흐름이다. 후대 heuristic planner의 배경이 된다. |
| **McDermott et al., PDDL, 1998** | Planning domain을 표준 언어로 기술하려는 시도다. 로봇 task planning을 교과서적으로 설명할 때 좋다. |
| **Hoffmann & Nebel, FF Planner, 2001** | Relaxed planning graph와 delete-list relaxation heuristic을 이용한 고전 heuristic planning 대표작이다. |

## 3.2 Motion Planning

| 대표 논문 | 핵심 |
|---|---|
| **Kavraki et al., PRM, 1996** | High-dimensional configuration space에서 probabilistic roadmap을 만드는 고전 방식이다. |
| **LaValle, RRT, 1998** | Rapidly-exploring random tree로 kinodynamic/path planning을 다룬 대표 알고리즘이다. |
| **Karaman & Frazzoli, RRT\*/PRM\*, 2011** | Sampling-based planning에 asymptotic optimality 개념을 강하게 넣은 논문이다. |
| **Ratliff et al., CHOMP, 2009** | Trajectory optimization을 smoothness와 obstacle cost 관점에서 푸는 대표 방식이다. |
| **Schulman et al., TrajOpt, 2013** | Sequential convex optimization과 continuous-time collision checking으로 trajectory optimization을 푸는 대표작이다. |

## 3.3 Task and Motion Planning, TAMP

| 대표 논문 | 핵심 |
|---|---|
| **PDDLStream, 2018/2020** | PDDL에 black-box sampler를 붙여 symbolic planning과 continuous sampling을 연결하는 대표 TAMP 프레임이다. 로봇 조작에서 “무슨 행동을 할지”와 “어떤 grasp/pose/trajectory를 쓸지”를 같이 다룬다. |
| **Optimization-based TAMP Survey, 2024** | Task planning, trajectory optimization, temporal logic, action language, logic-optimization 결합을 정리한 최신 survey다. VLA 교과서에서 고전 TAMP와 neural VLA를 연결하는 다리로 쓰기 좋다. |

### Part II의 핵심 메시지

LLM/VLM/VLA가 planner처럼 보이더라도, 고전 planning의 장점인 **명시적 제약, 검증 가능성, 실패 복구, symbolic abstraction**은 여전히 살아 있다. 2026년 최신 흐름도 VLA를 단독 end-to-end 모델로 쓰기보다 reasoning model, world model, TAMP, controller와 결합하려는 쪽이 강해지고 있다.

---

# Part III. 로봇러닝: VLA 이전의 직접 조상

VLA의 직접 조상은 imitation learning, visuomotor policy, deep RL이다. 여기서 “이미지 → action” 구조가 먼저 만들어졌고, 나중에 언어와 VLM이 붙었다.

| 대표 논문 | 왜 중요하냐 |
|---|---|
| **DAgger, Ross et al., 2011** | Behavior cloning의 distribution shift 문제를 정면으로 다룬 논문이다. VLA fine-tuning에서도 covariate shift를 설명할 때 필요하다. |
| **PILCO, Deisenroth & Rasmussen, 2011** | Probabilistic dynamics model을 이용한 data-efficient model-based policy search다. 적은 real robot data로 학습하는 문제의 고전적 답변이다. |
| **Guided Policy Search, Levine & Koltun, 2013** | Trajectory optimization으로 policy learning을 guide하는 구조다. Trajectory optimizer와 neural policy를 연결한다는 점에서 현대 VLA + controller 결합의 선조로 볼 수 있다. |
| **End-to-End Training of Deep Visuomotor Policies, Levine et al., 2016** | Raw image observation에서 torque까지 직접 매핑하는 deep visuomotor policy 흐름을 대표한다. |
| **QT-Opt, Kalashnikov et al., 2018** | 대규모 real grasping data와 self-supervised visual RL을 쓴 대표작이다. 로봇 데이터 스케일링의 초기 가능성을 보여줬다. |
| **Control as Probabilistic Inference, Levine, 2018** | Maximum entropy RL과 optimal control을 probabilistic inference로 보는 관점이다. Diffusion/energy/action distribution을 설명할 때도 유용하다. |

---

# Part IV. Transformer, VLM, LLM: VLA의 표현학습 기반

VLA가 가능해진 결정적 배경은 로봇 쪽보다 오히려 **언어·시각 foundation model** 쪽이다.

| 대표 논문 | 핵심 |
|---|---|
| **Attention Is All You Need, 2017** | Transformer의 시작점. Sequence modeling, tokenization, scaling law 논의를 열었다. |
| **ViT, 2020** | 이미지를 patch token sequence로 보고 transformer를 적용한 대표작이다. VLA vision encoder의 핵심 배경이 된다. |
| **CLIP, 2021** | 대규모 image-text pair로 contrastive vision-language representation을 학습하고 zero-shot transfer를 보인 논문이다. Language-grounded perception의 핵심 출발점이다. |
| **Flamingo, 2022** | Interleaved image/video/text를 처리하는 few-shot VLM 흐름을 대표한다. VLA가 VLM backbone 위에 action head를 얹는 구조를 이해하는 데 좋다. |

---

# Part V. LLM/VLM을 로봇 Planner로 쓰던 시기

이 시기는 아직 “VLA”라기보다는 **LLM/VLM + 기존 robot skills/controller** 조합이다. 하지만 교과서 역사에서는 반드시 넣어야 한다. 현재의 hierarchical VLA, ER + VLA 구조가 여기서 나왔기 때문이다.

| 대표 논문 | 핵심 |
|---|---|
| **Language Models as Zero-Shot Planners, 2022** | LLM이 high-level task를 mid-level plan으로 쪼갤 수 있음을 보였지만, executability 문제가 있다는 점도 드러냈다. |
| **SayCan, 2022** | LLM의 world knowledge와 robot affordance/value function을 결합해 “말로는 가능해 보여도 로봇이 실제 할 수 있는가?”를 판단하게 했다. |
| **Inner Monologue, 2022** | LLM planner가 scene feedback, success detection, human feedback을 받아 closed-loop planning을 하도록 한 흐름이다. |
| **Code as Policies, 2022** | LLM이 robot policy code를 생성하고, 그 안에 waypoint control이나 impedance controller 같은 기존 control primitive를 호출하는 구조다. VLA와 classical control의 연결을 보여주는 좋은 예시다. |
| **LM-Nav, 2022** | ViNG, CLIP, GPT-3를 조합해 language-annotated robot data 없이 long-horizon outdoor navigation을 수행한 논문이다. |
| **VoxPoser, 2023** | LLM/VLM으로 3D value map을 만들고 model-based planning으로 closed-loop trajectory를 생성한다. “VLM이 직접 action을 내는가, 아니면 affordance/value field를 만들고 planner가 푸는가?”라는 중요한 축을 보여준다. |

### Part V의 핵심 메시지

이 시기의 핵심은 **LLM은 planner, classical controller는 executor**였다는 점이다. 이후 RT-2/OpenVLA/π0 계열은 이걸 더 end-to-end VLA로 밀고 가고, Gemini Robotics-ER/GR00T류는 다시 계층형 구조로 정리하고 있다.

---

# Part VI. VLA의 탄생: Robotics Transformer와 RT 계열

여기서부터 진짜 VLA 역사가 시작된다.

| 대표 논문 | 핵심 |
|---|---|
| **BC-Z, 2022** | 100개 이상의 조작 task에서 language/video-conditioned imitation learning을 하고, unseen task zero-shot generalization을 보인 초기 generalist robot policy 흐름이다. |
| **Gato, 2022** | 하나의 transformer가 dialogue, captioning, Atari, block stacking 등 여러 modality/task를 처리하는 generalist agent 아이디어를 제시했다. 로봇 VLA의 “single model, many tasks” 정서를 만든 중요한 논문이다. |
| **RT-1, 2022** | Robotics Transformer. Real robot data, task diversity, model scaling을 이용해 language-conditioned robot policy를 만든 대표작이다. |
| **PaLM-E, 2023** | Embodied multimodal language model. Visual/continuous state/text를 대형 언어모델에 넣어 embodied task를 수행하게 한 흐름이다. |
| **RT-2, 2023** | “Vision-Language-Action model”이라는 표현을 대중화한 핵심 논문이다. VLM을 web VQA data와 robot trajectory data에 함께 fine-tune하고, robot action을 text token처럼 다뤄 web knowledge가 robot action으로 전이될 수 있음을 보였다. |
| **RoboCat, 2023** | Multi-embodiment, multi-task, visual goal-conditioned decision transformer 계열로, zero/few-shot adaptation과 self-generated data loop를 강조했다. |

### Part VI의 핵심 메시지

RT-2의 핵심은 “action도 언어 token처럼 다룰 수 있다”는 관점이다. 하지만 이 접근은 continuous control, real-time latency, dexterous manipulation에서 한계가 생기고, 그래서 2024–2026년에 diffusion/flow/action-chunking 계열이 강해졌다.

---

# Part VII. Action Representation의 변화: Token, Chunk, Diffusion, Flow

VLA 교과서에서 제일 중요하게 설명해야 할 최신 축이다.

| 방식 | 대표 논문 | 설명 |
|---|---|---|
| **Discrete action token** | RT-2, OpenVLA | Action을 token처럼 예측해서 VLM/LLM 학습 파이프라인과 잘 맞춘다. 단점은 고주파 continuous control이나 dexterous action에서 표현력이 제한될 수 있다는 점이다. |
| **Action chunking** | ACT/ALOHA, Mobile ALOHA | 여러 step의 action chunk를 한 번에 예측해 compounding error를 줄이고, bimanual manipulation에 강하다. ALOHA는 저가형 bimanual system과 ACT로 세밀한 조작을 보였고, Mobile ALOHA는 whole-body mobile manipulation까지 확장했다. |
| **Diffusion policy** | Diffusion Policy, RDT-1B | Action distribution이 multimodal일 때 강하다. Diffusion Policy는 visuomotor policy를 conditional denoising diffusion으로 모델링했고, RDT-1B는 diffusion transformer 기반 대규모 robot foundation model을 제시했다. |
| **Flow matching VLA** | π0, π0.5 | Continuous action을 flow matching으로 생성하는 쪽이다. π0는 VLM 기반 VLA를 flow-matching action expert와 결합했고, π0.5는 open-world generalization과 high-level semantic prediction을 더 강조했다. |
| **Efficient tokenization/fine-tuning** | FAST, OpenVLA-OFT | FAST는 VLA를 위한 효율적 action tokenization을 다루고, OpenVLA-OFT는 OpenVLA의 fine-tuning 효율과 성능을 크게 개선하는 recipe를 제시했다. |

### Part VII의 핵심 메시지

VLA 아키텍처의 핵심 질문은 이제 “VLM을 쓰느냐”가 아니라, **action을 어떤 확률분포와 시간구조로 표현하느냐**다. 조작에서는 단일 step action보다 chunk/diffusion/flow가 점점 더 중요해지고 있다.

---

# Part VIII. 데이터 스케일링: Open X-Embodiment 이후

VLA는 모델도 중요하지만, 2026년 기준으로는 **데이터 엔진**이 거의 더 중요해졌다. 고품질 데이터 엔진과 구조화된 평가가 앞으로의 성능 향상에 핵심이다.

| 데이터셋/벤치마크 | 핵심 |
|---|---|
| **CALVIN, 2021** | Language-conditioned long-horizon manipulation benchmark. Simulated environment에서 긴 작업 수행을 평가하기 좋다. |
| **LIBERO, 2023** | Lifelong robot learning benchmark. 130개 task, procedural generation, knowledge transfer를 다룬다. |
| **BridgeData V2, 2023** | 60,096 trajectories, 24 environments, open-vocabulary language/goal-image conditioning을 제공하는 real robot dataset이다. |
| **ManiSkill2, 2023** | 20개 manipulation task family, 2000개 이상 object model, 400만+ demonstration frame을 제공하는 simulation benchmark다. |
| **Open X-Embodiment / RT-X, 2023** | 22개 robot embodiment, 527개 skill, 160k+ task를 모은 대규모 cross-embodiment dataset/model 흐름이다. |
| **Octo, 2024** | Open X-Embodiment 80만 trajectory로 학습한 open-source generalist robot policy다. Language와 goal image를 condition으로 쓰고, 새 sensor/action space에 빠르게 fine-tune할 수 있음을 보였다. |
| **DROID, 2024** | 50명 수집자가 전세계 564개 scene에서 350시간, 76k demonstration을 모은 대규모 in-the-wild robot manipulation dataset이다. |
| **OpenVLA, 2024** | 970k real robot demonstration으로 학습한 7B open-source VLA다. Llama 2, DINOv2, SigLIP 기반으로 만들었고, 여러 real robot task에서 강한 성능을 보고했다. |

### Part VIII의 핵심 메시지

VLA의 scaling law는 웹 LLM처럼 단순하지 않다. 로봇 데이터는 비싸고, embodiment가 다르고, action space가 다르고, success label이 모호하고, real-world distribution shift가 크다. 그래서 **data collection, teleoperation, simulation, synthetic data, evaluation protocol**이 한 장이 아니라 여러 장을 차지해야 한다.

---

# Part IX. 2025–2026 최신 흐름: ER + VLA, Humanoid, Deployment, Safety

2026년 5월 기준 최신 챕터는 이쪽이다. 일부는 peer-reviewed 논문이라기보다 arXiv preprint나 회사 기술 공개이므로, 교과서에서는 “최신 사례”와 “검증된 기반 논문”을 구분해서 쓰는 게 좋다.

## 9.1 ER + VLA 계층 구조

Google DeepMind의 **Gemini Robotics-ER** 계열은 high-level reasoning, visual/spatial understanding, task planning, success detection, tool/VLA 호출을 담당하는 모델로 공개됐다. Gemini Robotics 계열은 VLA 모델과 ER 모델을 짝지은 dual-model 접근을 강조한다.

### 책에서의 해석

이건 고전 AI planning의 부활이다. 단, PDDL planner가 아니라 VLM/LLM 기반 embodied reasoning model이 상위 planner 역할을 한다.

## 9.2 Humanoid VLA

| 시스템 | 핵심 |
|---|---|
| **NVIDIA GR00T N1, 2025** | Humanoid generalist foundation model. System 2 VLM이 instruction과 scene을 해석하고, System 1 diffusion transformer가 action을 생성하는 dual-system 구조를 제시했다. |
| **Figure Helix, 2025** | 회사 기술 공개 성격이 강하지만, humanoid full-upper-body control, wrist/torso/head/finger를 포함한 continuous control을 강조한 사례다. 논문보다는 case study로 다루는 게 좋다. |
| **Gemini Robotics, 2025–2026** | Gemini 기반 VLA에서 시작해, ER + VLA 계층, on-device VLA iteration, multiple embodiment, tool use 쪽으로 확장됐다. |

## 9.3 Open-source Training Stack

**VLA Foundry, 2026**는 language pretraining부터 action-expert fine-tuning까지 LLM/VLM/VLA 학습을 하나의 코드베이스에서 통합하려는 open-source framework다. 교과서의 실습 파트나 “modern VLA engineering” 장에 넣기 좋다.

## 9.4 Real-time, On-device, Hardware-aware VLA

2026년 들어서는 “성능 좋은 VLA”보다 “로봇 위에서 빠르고 싸고 안정적으로 도는 VLA”가 중요해졌다. VLA inference의 latency, energy, cost를 XPU별로 분석하는 연구와, long-horizon VLA에서 temporal KV caching으로 inference 효율을 올리려는 연구가 나오고 있다.

## 9.5 Safety와 Evaluation

VLA safety 흐름은 modular stack과 unified VLA 모두에 safety 문제가 있다고 본다. 또 2026년에는 “VLA가 정말 embodied reasoning을 하는가, 아니면 benchmark artifact를 푸는가?”를 비판적으로 보는 연구들도 나오고 있다.

### Part IX의 핵심 메시지

마지막 장은 “VLA의 한계”여야 한다. Hallucination, unsafe action, hidden state mismatch, embodiment gap, latency, benchmark overfitting, real-world recovery failure를 반드시 넣어야 한다.

---

# 10. 교과서 목차 초안

## Part A. Classical Foundations

### Chapter 1. Robot State, Dynamics, and Control

- State space
- Kalman filtering
- Robot dynamics
- Inverse dynamics
- Operational space control

### Chapter 2. Optimal Control and MPC

- Bellman optimality
- LQR
- Constrained MPC
- Receding horizon
- Safety constraints

### Chapter 3. Contact and Interaction Control

- Hybrid position/force control
- Impedance/admittance control
- Grasping
- Contact-rich manipulation

### Chapter 4. Symbolic Planning

- A\*
- STRIPS
- PDDL
- GraphPlan
- FF
- Planning as search

### Chapter 5. Motion Planning and TAMP

- PRM
- RRT
- RRT\*
- CHOMP
- TrajOpt
- PDDLStream
- Symbolic-continuous planning

---

## Part B. Robot Learning Before VLA

### Chapter 6. Imitation Learning and Dataset Aggregation

- Behavior cloning
- Covariate shift
- DAgger
- Offline learning

### Chapter 7. Reinforcement Learning and Model-Based Policy Search

- PILCO
- Guided policy search
- Control as inference
- QT-Opt

### Chapter 8. Visuomotor Policies

- Image-to-action
- CNN/RNN/Transformer policies
- Real robot grasping
- Action parameterization

---

## Part C. Language, Vision, and Planning

### Chapter 9. Transformer and Vision-Language Representation

- Transformer
- ViT
- CLIP
- Flamingo
- Multimodal tokenization

### Chapter 10. LLM/VLM as Robot Planner

- Zero-shot planners
- SayCan
- Inner Monologue
- Code as Policies
- LM-Nav
- VoxPoser

### Chapter 11. From Planner + Skills to VLA

- Why LLM planning alone fails
- Affordance grounding
- Skill library
- Closed-loop feedback

---

## Part D. Vision-Language-Action Models

### Chapter 12. Robotics Transformer Era

- BC-Z
- Gato
- RT-1
- PaLM-E
- RT-2
- RoboCat

### Chapter 13. Action Representation

- Discrete action token
- Continuous regression
- Action chunking
- Diffusion policy
- Flow matching
- Action expert

### Chapter 14. VLA Data Scaling

- Open X-Embodiment
- BridgeData
- DROID
- ALOHA
- LIBERO
- CALVIN
- ManiSkill
- Data engines

### Chapter 15. Open-source VLA Ecosystem

- Octo
- OpenVLA
- OpenVLA-OFT
- FAST
- VLA Foundry

### Chapter 16. Embodied Reasoning and Hierarchical VLA

- Gemini Robotics-ER
- GR00T N1
- ER + VLA
- VLA + TAMP
- VLA + world model

### Chapter 17. Deployment, Safety, and Evaluation

- Latency
- On-device inference
- XPU deployment
- Benchmark validity
- Safety
- Recovery
- Human oversight

### Chapter 18. Future Directions

- World models
- Online RL
- Self-improving data loops
- Multi-robot/multi-embodiment transfer
- Humanoid foundation models
- Formal verification

---

# 11. 필독 50편 압축 리스트

## Classical Control / Robotics

1. Bellman — **Dynamic Programming**
2. Kalman — **A New Approach to Linear Filtering and Prediction Problems**
3. Raibert & Craig — **Hybrid Position/Force Control**
4. Hogan — **Impedance Control**
5. Khatib — **Operational Space Control**
6. Featherstone — **Articulated-Body Algorithm**
7. Murray, Li, Sastry — **A Mathematical Introduction to Robotic Manipulation**
8. Mayne et al. — **Constrained Model Predictive Control**

## Planning / Motion Planning / TAMP

9. Hart, Nilsson, Raphael — **A\***
10. Fikes & Nilsson — **STRIPS**
11. Blum & Furst — **GraphPlan**
12. McDermott et al. — **PDDL**
13. Hoffmann & Nebel — **FF Planner**
14. Kavraki et al. — **PRM**
15. LaValle — **RRT**
16. Karaman & Frazzoli — **RRT\*/PRM\***
17. Ratliff et al. — **CHOMP**
18. Schulman et al. — **TrajOpt**
19. Garrett et al. — **PDDLStream**

## Robot Learning

20. Ross et al. — **DAgger**
21. Deisenroth & Rasmussen — **PILCO**
22. Levine & Koltun — **Guided Policy Search**
23. Levine et al. — **End-to-End Deep Visuomotor Policies**
24. Kalashnikov et al. — **QT-Opt**
25. Chi et al. — **Diffusion Policy**
26. Zhao et al. — **ALOHA / ACT**
27. Fu et al. — **Mobile ALOHA**

## VLM / LLM Backbone

28. Vaswani et al. — **Attention Is All You Need**
29. Dosovitskiy et al. — **Vision Transformer**
30. Radford et al. — **CLIP**
31. Alayrac et al. — **Flamingo**

## LLM/VLM Robotics Bridge

32. Huang et al. — **Language Models as Zero-Shot Planners**
33. Ahn et al. — **SayCan**
34. Huang et al. — **Inner Monologue**
35. Liang et al. — **Code as Policies**
36. Shah et al. — **LM-Nav**
37. Huang et al. — **VoxPoser**

## VLA Core

38. Jang et al. — **BC-Z**
39. Reed et al. — **Gato**
40. Brohan et al. — **RT-1**
41. Driess et al. — **PaLM-E**
42. Brohan et al. — **RT-2**
43. Bousmalis et al. — **RoboCat**
44. Open X-Embodiment Collaboration — **RT-X / Open X-Embodiment**
45. Octo Model Team — **Octo**
46. Kim et al. — **OpenVLA**
47. Black et al. — **π0**
48. Black et al. — **π0.5**
49. RDT Team — **RDT-1B**
50. NVIDIA — **GR00T N1**
51. Google DeepMind — **Gemini Robotics / Gemini Robotics-ER / Gemini Robotics 1.5**

---

# 12. 책의 중심 논지

교과서의 중심 thesis는 이렇게 잡으면 강하다.

> **VLA는 로봇 제어이론의 대체물이 아니라, task semantics와 embodied perception을 action-generation으로 연결하는 새로운 policy interface다.**
>
> 고전 제어는 안정성과 실시간성을, 고전 계획은 구조화된 목표분해와 제약추론을, 모션플래닝은 연속공간 feasibility를, 딥러닝은 perception-action mapping을, VLM/LLM은 언어·상식·시각 grounding을 제공한다.
>
> 2026년의 핵심 연구문제는 이 다섯 가지를 어떻게 하나의 안전하고 평가 가능한 embodied system으로 통합하느냐다.

---

# 13. 교과서 집필 전략 메모

## 13.1 단순 논문 나열이 아니라 “개념 계보”로 써야 한다

VLA를 설명할 때 논문 순서만 나열하면 독자가 큰 그림을 놓친다. 각 장은 다음 질문에 답하도록 구성하면 좋다.

1. 고전 이론은 어떤 문제를 풀었나?
2. 왜 그 문제는 VLA에서도 사라지지 않았나?
3. 딥러닝/VLM/LLM은 어떤 부분을 대체하거나 보완했나?
4. 최신 VLA 시스템은 이 문제를 어떻게 다시 formulation하고 있나?

## 13.2 고전 제어와 planning을 “배경”이 아니라 “현재형 도구”로 써야 한다

제어이론과 planning을 역사 파트에 묻어두면 책이 약해진다. VLA의 실제 deployment에서는 여전히 다음이 중요하다.

- Low-level servo control
- Operational space control
- Impedance/admittance control
- Contact safety
- Constraint satisfaction
- Motion feasibility
- Failure recovery
- Closed-loop replanning
- Long-horizon decomposition

## 13.3 최신 VLA의 핵심 비교축

최신 논문을 비교할 때는 다음 축을 쓰면 좋다.

| 비교축 | 질문 |
|---|---|
| **Backbone** | LLM 기반인가, VLM 기반인가, robot-specific transformer인가? |
| **Action representation** | Discrete token, continuous regression, diffusion, flow, action chunk 중 무엇인가? |
| **Temporal horizon** | Single-step인가, chunk인가, long-horizon planner와 결합하는가? |
| **Embodiment** | 단일 로봇인가, multi-embodiment인가, humanoid까지 가는가? |
| **Data source** | Teleoperation, autonomous collection, simulation, synthetic data, web data를 어떻게 섞는가? |
| **Control interface** | Joint position, end-effector delta, velocity, torque, whole-body action 중 무엇을 낸는가? |
| **Safety** | Constraint, verification, recovery, human intervention을 어떻게 다루는가? |
| **Deployment** | Real-time inference, on-device compute, latency, memory cost를 어떻게 해결하는가? |

---

# 14. 한 줄 결론

**VLA는 “LLM이 로봇을 움직인다”가 아니라, 고전 제어·계획·모션플래닝·로봇러닝·VLM/LLM이 하나의 embodied policy stack으로 재조립되는 흐름이다.**
