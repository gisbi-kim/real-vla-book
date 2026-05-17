## 총평

점수로 치면 **8.5/10** 정도야. 방향은 아주 좋고, 특히 “VLA는 고전 제어·계획·모션플래닝·로봇러닝·VLM/LLM이 embodied policy stack으로 재조립되는 흐름”이라는 중심 논지는 책의 spine으로 충분히 강해. 네 초안도 VLA를 단순히 “요즘 로봇 foundation model”로 보지 않고, 제어·계획·모션플래닝 위에 얹힌 semantic policy interface로 잡고 있어서 차별성이 있어.  

내가 보기엔 이 책의 killer positioning은 이거야.

> **Real VLA는 “VLA 논문 survey”가 아니라, 로봇을 실제로 움직여 본 사람이 VLA를 시스템 관점에서 재해석하는 책이어야 해.**

그래서 제목도 살짝 다듬는 게 좋아.
**Real VLA Book - Robotists Perspective**보다는 영어권 독자 기준으로는 아래가 더 자연스러워.

**Real VLA: A Roboticist’s Perspective**
부제는 이렇게 가면 좋아.

**From Control, Planning, and Robot Learning to Embodied Foundation Models**

---

## 제일 강한 점

네 초안에서 제일 좋은 건 **VLA를 controller replacement로 보지 않은 것**이야. “VLA는 로봇 제어이론의 대체물이 아니라 task semantics와 embodied perception을 action-generation으로 연결하는 새로운 policy interface”라는 논지는 책 전체를 관통하는 thesis로 매우 좋다. 이걸 서문, Chapter 1, 마지막 장에서 반복해서 박아야 해. 

두 번째 장점은 역사 구성이 좋아. Bellman/Kalman/LQR/MPC → STRIPS/PDDL/TAMP → visuomotor policy → VLM/LLM → RT-1/RT-2/OpenVLA/π0/Gemini/GR00T로 이어지는 흐름은 “로봇공학자가 보는 VLA 계보”로 설득력이 있어. 특히 Part VII에서 action token, chunking, diffusion, flow를 핵심 축으로 잡은 건 아주 맞는 판단이야. 지금 VLA에서 진짜 중요한 질문은 “VLM을 썼느냐?”보다 “action을 어떤 시간구조와 확률분포로 표현하느냐?”가 됐어. 

세 번째로, 데이터 엔진과 평가를 뒤쪽에 둔 것도 맞아. 2026년 기준으로 VLA는 모델 아키텍처만의 싸움이 아니라 data collection, curation, embodiment normalization, evaluation protocol 싸움으로 가고 있어. 최신 VLA survey도 향후 발전이 모델 구조보다 고품질 데이터 엔진과 구조화된 평가 프로토콜의 공동 설계에 더 의존할 거라고 정리하고 있어.  ([arXiv][1])

---

## 가장 크게 보완해야 할 점

가장 큰 약점은 **목차가 아직 “역사 + 논문 로드맵” 느낌이 강하고, “책의 수학적·시스템적 spine”이 약하다**는 거야. 지금 초안은 survey로는 훌륭한데, 교과서로 만들려면 각 장이 다음 공통 구조를 가져야 해.

**Problem → Classical formulation → Learning formulation → VLA formulation → System interface → Failure mode**

예를 들어 MPC 장은 그냥 MPC 설명으로 끝나면 안 돼. “왜 VLA action은 low-level controller 없이 직접 torque로 가기 어려운가?”, “VLA output을 receding-horizon controller의 reference로 쓰면 어떤 장점이 있는가?”, “semantic planner와 MPC safety filter를 어떻게 붙이는가?”까지 연결해야 해.

또 하나는 **Chapter 1 앞에 ‘What is a VLA system?’ 장이 먼저 있어야 해.** 지금은 Classical Foundations부터 시작하는데, 독자는 “그래서 이게 VLA랑 무슨 관계야?”라고 느낄 수 있어. 첫 장에서 전체 stack을 먼저 보여줘야 해.

내가 추천하는 Chapter 1은 이거야.

**Chapter 1. The VLA Stack: From Language to Motor Commands**

여기서 다음 interface를 명확히 정의하면 좋아.

| Layer                | Input                                           | Output                               | Typical model             |
| -------------------- | ----------------------------------------------- | ------------------------------------ | ------------------------- |
| Embodied reasoning   | image/video/audio + instruction + memory        | subgoal, plan, tool call             | VLM/LLM/ER model          |
| VLA policy           | observation + language/subgoal + proprioception | action chunk / waypoint / delta pose | RT/OpenVLA/π0/GR00T류      |
| Motion/control layer | target, constraints, robot state                | feasible trajectory / servo command  | MPC, OSC, impedance, WBC  |
| Safety layer         | command + state + environment                   | allow / modify / stop                | monitor, shield, verifier |

이 장 하나가 있으면 이후 classical control과 planning이 “배경지식”이 아니라 “VLA stack의 필수 부품”으로 읽혀.

---

## 최신 흐름 반영 업데이트

Gemini 쪽은 초안보다 한 단계 더 업데이트하는 게 좋아. 문서에는 Gemini Robotics / Gemini Robotics-ER / Gemini Robotics 1.5가 최신 흐름으로 정리돼 있는데, 현재 Google AI docs 기준으로는 **Gemini Robotics-ER 1.6 preview**가 공개되어 있고, 이 모델은 직접 action을 내는 VLA라기보다 spatial reasoning, task decomposition, tool/function calling, VLA 호출을 담당하는 VLM/ER 모델로 보는 게 정확해. Google 문서도 ER 1.6을 “physical world에서 advanced reasoning을 하며 visual data 해석, spatial reasoning, natural-language command 기반 action planning을 하는 VLM”으로 설명하고 있어. ([Google AI for Developers][2])

따라서 Part IX의 문장은 이렇게 바꾸면 좋아.

> **Gemini Robotics-ER류는 VLA 자체라기보다 VLA를 orchestrate하는 embodied reasoning layer다. 이 계층은 task planning, spatial reasoning, progress/success estimation, tool/function calling, VLA/controller invocation을 담당한다.**

GR00T도 최신화가 필요해. 초안은 GR00T N1 기준인데, NVIDIA의 공개 GitHub에는 **GR00T N1.7 Early Access**가 올라와 있고, 새로운 VLM backbone, pretrained weights, reference code, fine-tuning/inference stack, relative end-effector action space, human video pretraining 등을 강조하고 있어. 특히 architecture가 VLM foundation model + diffusion transformer head로 continuous action을 denoise하는 구조라고 설명돼. ([GitHub][3])

VLA Foundry는 그대로 넣어도 좋아. 다만 “대표 모델”이라기보다 **training stack / engineering stack**으로 분류해야 해. 2026년 4월 arXiv 기준으로 VLA Foundry는 LLM→VLM→VLA training을 하나의 코드베이스에서 통합하고, language pretraining부터 action-expert fine-tuning까지 end-to-end control을 제공한다고 설명돼. 이건 Chapter 15의 핵심 사례로 매우 적합해. ([arXiv][4])

---

## Action Representation 장은 더 키워야 해

현재 Chapter 13은 책의 중심 장 중 하나가 되어야 해. 네 초안에서도 이걸 잘 잡았는데, 나는 이 장을 더 기술적으로 밀고 가는 게 좋다고 봐. 

추천 구조는 이래.

1. **Action as token**
   RT-2, OpenVLA 계열. 장점은 VLM/LLM training pipeline과 잘 맞는 것. 단점은 고주파 continuous control, dexterous manipulation, latency.

2. **Action as chunk**
   ACT/ALOHA, OpenVLA-OFT. compounding error 감소, bimanual manipulation, high-frequency control과 연결.

3. **Action as distribution**
   Diffusion Policy, RDT, π0. multimodal action distribution, contact-rich manipulation에서 중요.

4. **Action as flow**
   π0류. π0는 pretrained VLM 위에 flow matching architecture를 얹고, action chunking과 flow matching으로 50Hz 수준의 dexterous control까지 다루는 방향을 제시했어. ([arXiv][5])

5. **Action as compressed sequence**
   FAST류. FAST는 per-dimension binning 대신 DCT 기반 compression tokenization을 쓰고, FAST+라는 universal robot action tokenizer를 1M real robot action trajectory로 학습했다고 보고해. π0와 결합했을 때 10k hours robot data 규모에서 diffusion VLA에 가까운 성능을 내면서 training time을 줄였다는 점도 책에서 다루기 좋아. ([arXiv][6])

6. **Action as fine-tuned interface**
   OpenVLA-OFT. OFT는 parallel decoding, action chunking, continuous action representation, L1 objective를 조합해서 OpenVLA의 inference speed와 success를 크게 개선했다고 보고해. 프로젝트 페이지 기준으로 25–50x speed improvement, LIBERO 97.1% average success, base OpenVLA 대비 26x faster action generation과 3x lower latency를 제시하고 있어. ([비전-언어-행동 모델 조정][7])

이 장의 결론은 이렇게 가면 좋아.

> **Action representation은 VLA의 output format 문제가 아니라, robot control boundary를 어디에 둘 것인가의 문제다.**

이 문장이 “roboticist perspective”를 잘 살려.

---

## Safety와 Evaluation은 마지막 한 장으로 부족해

Chapter 17은 지금보다 훨씬 커져야 해. Safety와 evaluation은 같은 장에 넣을 수는 있지만, 실제 책에서는 둘을 나누는 게 더 좋다.

**Chapter 17. Evaluation: Does the Robot Really Understand?**
**Chapter 18. Safety and Assurance: What Prevents Harm?**

왜냐하면 2026년 VLA의 가장 큰 논쟁은 “benchmark success가 진짜 embodied reasoning인가?”이기 때문이야. BeTTER 논문은 기존 VLA들이 standard benchmark에서는 좋아 보이지만 spatial layout shift, temporal extrapolation 같은 causal intervention에서 shortcut, behavioral inertia, semantic feature collapse를 보인다고 주장해. 이런 류의 비판을 마지막에 넣으면 책이 훨씬 날카로워져. ([arXiv][8])

평가 장에는 vla-eval 같은 harness도 넣으면 좋아. vla-eval은 여러 VLA 모델과 14개 simulation benchmark를 통합해 평가 비용과 재현성 문제를 줄이려는 framework로, LIBERO 평가를 14시간에서 약 18분으로 줄이는 parallel evaluation도 보고하고 있어. 이런 건 “평가도 engineering problem이다”라는 메시지에 잘 맞아. ([arXiv][9])

Safety 장에서는 semantic safety와 physical safety를 분리해야 해.

| Safety level     | 핵심 질문                       | 예시                        |
| ---------------- | --------------------------- | ------------------------- |
| Semantic safety  | 명령 자체가 위험한가?                | “뜨거운 컵을 아이에게 줘”           |
| Geometric safety | 경로가 충돌 없는가?                 | 사람 손과 gripper 충돌          |
| Dynamic safety   | 힘/속도/토크가 안전한가?              | 접촉력, 미끄러짐, overshoot      |
| System safety    | 실패 시 멈추거나 복구하는가?            | monitor, E-stop, recovery |
| Data safety      | unsafe behavior를 학습하지 않았는가? | bad demonstrations, bias  |

Google의 Gemini Robotics-ER 문서도 generative model은 실수할 수 있고 물리 로봇은 damage를 일으킬 수 있으므로 안전 환경 유지가 중요하다고 명시하고 있어. ASIMOV-2.0도 디지털 AI와 달리 physical-world AI는 직접적이고 즉각적인 physical harm 가능성이 있다는 문제의식에서 출발해, image/video 기반 safety understanding과 intervention 능력을 평가하려고 해. ([Google AI for Developers][2]) ([ASIMOV Benchmark][10])

---

## 목차는 이렇게 재구성하면 더 강해져

현재 목차는 좋지만 Part A가 너무 길게 앞에 나오면 VLA 독자가 초반에 이탈할 수 있어. 그래서 “VLA stack overview”를 먼저 두고, classical chapters는 계속 VLA와 연결해야 해.

### Part 0. Orientation

**Chapter 1. What Is a Real VLA System?**
VLA definition, robot stack, action interface, embodiment, closed-loop execution, failure modes.

### Part I. Physical Foundations for VLA

**Chapter 2. State, Dynamics, and Estimation**
state, observation, proprioception, Kalman filtering, latency, partial observability.

**Chapter 3. Control Interfaces**
joint position, velocity, torque, end-effector delta, impedance, operational space control.

**Chapter 4. Contact, Force, and Manipulation**
hybrid force/position, impedance/admittance, grasping, contact-rich tasks.

**Chapter 5. Planning, Motion Planning, and TAMP**
A*, STRIPS, PDDL, PRM/RRT, trajectory optimization, PDDLStream, feasibility.

### Part II. Learning Before VLA

**Chapter 6. Imitation Learning and Covariate Shift**
BC, DAgger, offline data, failure data.

**Chapter 7. RL, Optimal Control, and Control as Inference**
PILCO, GPS, QT-Opt, maximum entropy RL.

**Chapter 8. Visuomotor Policies**
image-to-action, recurrent policies, transformer policies, action parameterization.

### Part III. Semantic Foundations

**Chapter 9. Transformers, VLMs, and Grounding**
Transformer, ViT, CLIP, Flamingo, multimodal tokenization.

**Chapter 10. LLM/VLM as Robot Planner**
SayCan, Code as Policies, Inner Monologue, VoxPoser.

**Chapter 11. From Planner + Skills to VLA**
affordance, skill libraries, closed-loop feedback, why pure LLM planning fails.

### Part IV. VLA Core

**Chapter 12. Robotics Transformer Era**
BC-Z, Gato, RT-1, PaLM-E, RT-2, RoboCat.

**Chapter 13. Action Representation**
token, regression, chunk, diffusion, flow, FAST, action expert.

**Chapter 14. Data Engines**
Open X-Embodiment, BridgeData, DROID, ALOHA, human video, synthetic data, relabeling, failure data, curation.

**Chapter 15. Adaptation and Fine-Tuning**
OpenVLA, Octo, OpenVLA-OFT, LoRA/full fine-tuning, action normalization, embodiment adapters.

**Chapter 16. Evaluation and Benchmarking**
LIBERO, CALVIN, ManiSkill, Simpler, vla-eval, real robot protocol, benchmark artifacts.

### Part V. Real Deployment

**Chapter 17. Hierarchical VLA and Embodied Reasoning**
Gemini Robotics-ER, ER + VLA, VLA + TAMP, world model, tool use.

**Chapter 18. Real-Time and Hardware-Aware VLA**
on-device inference, latency, KV cache, XPU, control frequency, asynchronous execution.

**Chapter 19. Safety and Assurance**
semantic safety, physical safety, ASIMOV, runtime monitors, shielding, recovery.

**Chapter 20. Humanoids and Whole-Body VLA**
GR00T, Helix as case study, whole-body control, WBC, locomotion/manipulation coupling.

**Chapter 21. Future Directions**
world models, online learning, self-improving data loops, multi-embodiment transfer, formal verification.

---

## 필독 리스트도 약간 수정하면 좋아

현재 “필독 50편”은 좋은데 실제로는 50편이 아니라 51개야. 이건 사소하지만 책 proposal에서는 깔끔하게 맞추는 게 좋아. 

추가 후보는 아래 정도야.

| 추가 후보                                       | 넣는 이유                                        |
| ------------------------------------------- | -------------------------------------------- |
| **Diffusion Policy**                        | 이미 리스트에 있지만 Chapter 13의 중심 논문으로 격상           |
| **ACT / ALOHA**                             | action chunking과 bimanual teleoperation의 핵심  |
| **OpenVLA-OFT**                             | VLA adaptation과 practical fine-tuning의 대표 사례 |
| **FAST**                                    | action tokenization을 최신 관점에서 설명하기 좋음         |
| **VLA Foundry**                             | training stack / reproducible engineering 관점 |
| **ASIMOV / ASIMOV-2.0**                     | semantic safety benchmark                    |
| **vla-eval**                                | evaluation harness와 reproducibility          |
| **BeTTER / embodied reasoning stress test** | benchmark success 비판                         |
| **OXE-AugE 또는 최신 data augmentation 논문**     | embodiment augmentation과 data scaling 논의용    |
| **LeVERB / humanoid WBC 계열**                | humanoid VLA와 whole-body control 연결용         |

반대로 Figure Helix는 “필독 논문” 리스트에는 넣지 말고, **company case study box**로 넣는 게 좋아. 네 초안에서 이미 “회사 기술 공개 성격이 강하므로 case study로 다루자”고 한 판단이 맞아. 

---

## 책의 차별화 포인트를 더 선명하게 잡자

이 책이 다른 VLA survey와 달라지려면 각 장 끝에 반드시 **Roboticist’s Takeaway** 박스를 넣는 게 좋아.

예를 들면 Chapter 13 끝에는 이렇게.

> **Roboticist’s Takeaway**
> Action tokenization은 NLP-style modeling convenience이고, action chunking/diffusion/flow는 physical control convenience다. 실제 로봇에서는 latency, frequency, smoothness, contact recovery, controller compatibility가 architecture choice를 결정한다.

Chapter 16 끝에는 이렇게.

> **Roboticist’s Takeaway**
> A VLA benchmark score is not a robot capability. Real capability requires reproducible protocol, distribution shift tests, recovery evaluation, safety intervention, and hardware-aware latency measurement.

Chapter 19 끝에는 이렇게.

> **Roboticist’s Takeaway**
> Safety cannot be delegated to the VLA. Safety is a stack property: semantic filter, geometric constraint, dynamic controller, runtime monitor, human override가 함께 있어야 한다.

이런 박스가 들어가면 책 제목의 **Real VLA**와 잘 맞아.

---

## 최종 제안

지금 초안의 방향은 유지하되, 책의 중심을 이렇게 바꾸면 훨씬 강해져.

**Before:**
VLA의 역사와 주요 논문을 로봇공학 관점에서 정리한 책

**After:**
VLA를 실제 로봇 시스템으로 배치하기 위해 필요한 control interface, action representation, data engine, evaluation, safety를 설명하는 책

가장 중요한 한 문장은 이걸로 가면 돼.

> **A real VLA is not a model that replaces robotics; it is an interface that reorganizes control, planning, perception, language, data, and safety into one embodied system.**

이 문장을 서문 첫 페이지에 두면 책의 방향이 바로 살아날 거야.

[1]: https://arxiv.org/html/2604.23001v1 "Vision-Language-Action in Robotics: A Survey of Datasets, Benchmarks, and Data Engines"
[2]: https://ai.google.dev/gemini-api/docs/robotics-overview "Gemini Robotics-ER 1.6  |  Gemini API  |  Google AI for Developers"
[3]: https://github.com/NVIDIA/Isaac-GR00T "GitHub - NVIDIA/Isaac-GR00T: NVIDIA Isaac GR00T N1.7 -  A Foundation Model for Generalist Robots. · GitHub"
[4]: https://arxiv.org/abs/2604.19728 "[2604.19728] VLA Foundry: A Unified Framework for Training Vision-Language-Action Models"
[5]: https://arxiv.org/html/2410.24164v1 "₀: A Vision-Language-Action Flow Model for General Robot Control"
[6]: https://arxiv.org/abs/2501.09747 "[2501.09747] FAST: Efficient Action Tokenization for Vision-Language-Action Models"
[7]: https://openvla-oft.github.io/ "Fine-Tuning Vision-Language-Action Models: Optimizing Speed and Success"
[8]: https://arxiv.org/html/2604.18000v1 "Unmasking the Illusion of Embodied Reasoning in Vision-Language-Action Models"
[9]: https://arxiv.org/pdf/2603.13966 "vla-eval: A Unified Evaluation Harness for Vision-Language-Action Models"
[10]: https://asimov-benchmark.github.io/v2/ "ASIMOV Benchmark v2"
