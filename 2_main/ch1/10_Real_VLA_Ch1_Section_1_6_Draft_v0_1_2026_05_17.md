# Chapter 1. What Is a Real VLA System? - Section Draft v0.1

## 1.6 Modern System Patterns: Model-only VLA, ER + VLA, and Humanoid Deployment

Section 1.5에서는 VLA를 역사적 수렴으로 보았다. 이제 같은 렌즈로 최신 시스템을 읽어보자. Chapter 1에서 최신 VLA/ER/humanoid system을 다루는 목적은 leaderboard를 정리하는 것이 아니다. 목적은 현대 시스템들이 Real VLA stack의 책임을 어떤 방식으로 나누고 합치는지 보여주는 것이다. 최신성은 중요하지만, 최신성이 곧 신뢰도나 일반성을 뜻하지는 않는다.

2026년 5월 기준으로 최신 시스템은 대략 네 가지 pattern으로 읽을 수 있다. 첫째, Robotics Transformer와 OpenVLA류의 VLA policy pattern이다. 둘째, diffusion, flow, tokenization, action expert, fine-tuning을 중심으로 하는 action-distribution pattern이다. 셋째, Gemini Robotics-ER와 Gemini Robotics처럼 high-level embodied reasoning과 action-producing VLA를 분리하는 ER + VLA orchestration pattern이다. 넷째, GR00T와 Helix 02처럼 humanoid whole-body deployment를 전면에 놓는 pattern이다.

### Table 1.3. Modern System Pattern Matrix

| Pattern | What it emphasizes | Stack interpretation | What it shows | What it does not prove |
| --- | --- | --- | --- | --- |
| VLA policy pattern | vision/language-conditioned robot action prediction | VLA policy layer 중심 | semantic input이 robot action proposal로 연결될 수 있음 | controller, safety, data/eval 문제가 사라짐 |
| Action-distribution pattern | token, chunk, diffusion, flow, action expert | VLA policy와 control boundary 사이 | output format이 control burden을 바꿈 | 특정 representation이 항상 우월함 |
| ER + VLA orchestration | high-level physical reasoning + action policy | ER layer와 VLA policy layer 분리 | planning, success detection, tool/VLA call이 중요함 | ER model 자체가 motor-action policy임 |
| Humanoid / whole-body pattern | full-body action, locomotion, manipulation, balance | VLA, WBC, safety, data가 강하게 결합 | whole-body autonomy가 중요한 frontier임 | humanoid general intelligence가 검증됨 |
| Open-source training stack | data/model/action-expert/fine-tuning workflow | data/evaluation layer와 adaptation layer | reproducible engineering surface가 넓어짐 | local deployment capability가 자동 보장됨 |

Robotics Transformer와 OpenVLA류는 VLA policy pattern을 대표한다. 이 흐름의 전환점은 vision-language representation이 robot action prediction과 결합되었다는 점이다. RT-1은 language-conditioned robot policy와 real robot data scaling을 보여주었고, RT-2는 web-scale VLM knowledge와 robot trajectory data를 결합해 action을 token처럼 다룰 수 있음을 제시했다. OpenVLA는 open-source VLA policy 흐름을 만들었다. Ch1에서 이 흐름을 자세한 architecture 비교로 확장하지는 않는다. 여기서 중요한 것은 VLA policy layer가 observation, language, proprioception을 받아 policy-level action을 제안하는 역할을 맡는다는 점이다. [CITATION: RT-1; RT-2; OpenVLA]

Action-distribution pattern은 현대 VLA의 중심축이 backbone 크기만이 아니라는 점을 보여준다. Diffusion Policy, ACT/ALOHA, pi0, FAST, OpenVLA-OFT 같은 흐름은 "어떤 VLM을 쓰는가"보다 "어떤 시간 구조와 확률분포로 action을 생성하는가"가 중요해졌음을 보여준다. Token action은 VLM/LLM pipeline과 잘 맞지만 고주파 continuous control에는 부담을 줄 수 있다. Action chunk는 temporal consistency를 제공하지만 빠른 recovery를 어렵게 할 수 있다. Diffusion과 flow는 multimodal action distribution을 표현하지만 sampling, latency, safety projection을 함께 고려해야 한다. Fine-tuning recipe와 action tokenizer는 deployment engineering을 쉽게 만들 수 있지만, controller compatibility와 evaluation protocol을 대체하지는 않는다. [CITATION: Diffusion Policy; ACT; pi0; FAST; OpenVLA-OFT; openpi]

ER + VLA orchestration pattern은 Section 1.3의 stack boundary를 가장 직접적으로 보여준다. Google DeepMind의 공식 설명은 Gemini Robotics-ER 1.6을 physical-world reasoning, spatial reasoning, task planning, success detection을 위한 embodied reasoning model로 제시한다. 반면 Gemini Robotics 1.5는 visual information과 instruction을 motor command로 연결하는 VLA model로 제시된다. 따라서 Ch1에서는 Gemini Robotics-ER류를 기본적으로 action-producing VLA policy가 아니라 ER/orchestrator layer로 분류하는 것이 안전하다. ER model은 무엇을 해야 하는지 구조화할 수 있지만, 그것만으로 motor-action policy가 되는 것은 아니다. [CITATION: Gemini Robotics-ER 1.6 official; Gemini Robotics official]

이 구분은 용어 문제 이상이다. ER model과 VLA policy를 혼동하면 "reasoning을 잘한다"와 "action을 안전하게 실행한다"가 섞인다. 한 시스템이 success detection, spatial pointing, task planning을 잘한다는 사실은 중요하지만, 그것이 controller rate, contact safety, recovery policy, action label normalization을 자동으로 해결했다는 뜻은 아니다. 반대로 action-producing VLA가 좋은 manipulation success를 보였다고 해서 high-level reasoning, progress estimation, tool use, safety escalation을 충분히 수행한다는 뜻도 아니다. Real VLA system은 이 둘을 어떤 boundary로 연결하는지가 핵심이다.

Humanoid / whole-body pattern은 Real VLA의 어려움이 가장 크게 드러나는 frontier이다. NVIDIA Isaac GR00T N1.7은 humanoid/generalist robot skills를 위한 open VLA model stack으로 제시되며, vision-language foundation model과 diffusion transformer action head, fine-tuning/inference workflow를 강조한다. Figure Helix 02는 full-body autonomy와 loco-manipulation을 회사 case study로 제시하며, semantic reasoning, visuomotor policy, learned whole-body control의 hierarchy를 강조한다. 이런 사례들은 VLA가 arm-only tabletop manipulation을 넘어 whole-body action, locomotion, balance, tactile sensing, latency, safety envelope, data collection 문제와 만난다는 점을 보여준다. [CITATION: NVIDIA Isaac GR00T N1.7 official; Figure Helix 02 official]

그러나 humanoid case는 조심해서 읽어야 한다. 멋진 whole-body demo는 중요한 engineering signal이지만, 곧바로 general robotics가 해결되었다는 증거는 아니다. 어떤 task distribution에서 수집했는지, failure case는 무엇인지, reset과 human intervention은 어떻게 처리했는지, safety monitor와 controller가 무엇인지, evaluation protocol이 재현 가능한지, distribution shift에서 어떻게 무너지는지 봐야 한다. Ch1에서 GR00T와 Helix류 사례는 peer-reviewed conclusion이 아니라 deployment frontier case study로 사용한다. 자세한 whole-body control과 humanoid safety 문제는 Ch20과 Ch19에서 다시 다룬다.

Open-source training stack과 evaluation stack도 현대 pattern의 일부이다. VLA Foundry, OpenVLA-OFT, FAST, openpi, vla-eval 같은 흐름은 VLA 연구가 단일 model paper에서 engineering workflow로 확장되고 있음을 보여준다. 하지만 open-source stack이 있다고 해서 곧바로 deployable Real VLA system이 생기는 것은 아니다. Training code, pretrained weights, fine-tuning recipe, benchmark harness는 중요한 infrastructure이지만, 실제 robot deployment에는 robot-specific calibration, controller integration, safety envelope, latency measurement, failure logging이 필요하다.

이 section의 핵심은 최신 시스템을 "누가 SOTA인가"로 읽지 않는 것이다. Real VLA 관점에서는 더 나은 질문이 있다. 이 시스템은 ER layer와 VLA policy layer를 어떻게 나누는가? Action representation은 무엇이고 controller는 무엇을 맡는가? Data engine은 어떤 embodiment와 failure를 포함하는가? Evaluation은 success rate뿐 아니라 latency, recovery, safety intervention을 보여주는가? Safety는 instruction, action, command, runtime 중 어디에 붙는가?

Section 1.6은 최신 system landscape를 보여주었다. 다음 Section 1.7에서는 여기서 나온 결론을 더 엄격하게 만든다. Model architecture만으로 Real VLA의 성능을 판단할 수 없다. Data, evaluation, and safety는 appendix가 아니라 Real VLA system을 정의하는 core layer이다.

## Freshness Notes

- 2026-05-17 KST 기준 공식 Google DeepMind 자료는 Gemini Robotics-ER 1.6을 high-level embodied reasoning model로, Gemini Robotics 1.5를 VLA model로 구분한다.
- 2026-05-17 KST 기준 NVIDIA Isaac GR00T GitHub 자료는 GR00T N1.7을 humanoid/generalist robot skills를 위한 open VLA model stack으로 설명한다.
- 2026-05-17 KST 기준 Figure Helix 02 공식 글은 full-body autonomy와 room-scale humanoid loco-manipulation을 강조한다.
- 위 최신 시스템들은 Chapter 1에서 case study로만 사용한다. 일반 원리나 검증된 benchmark conclusion으로 쓰지 않는다.

## Citation Placeholders for Later Integration

- **[C1.6-1] RT-1; RT-2; OpenVLA** - VLA policy pattern.
- **[C1.6-2] Diffusion Policy; ACT/ALOHA; pi0; FAST; OpenVLA-OFT; openpi** - action-distribution and adaptation pattern.
- **[C1.6-3] Gemini Robotics-ER 1.6 official; Gemini Robotics 1.5 official; SayCan; Code as Policies** - ER + VLA orchestration pattern.
- **[C1.6-4] NVIDIA Isaac GR00T N1.7 official; Figure Helix 02 official** - humanoid / whole-body deployment case study.
- **[C1.6-5] VLA Foundry; vla-eval; BeTTER; ASIMOV** - open-source stack, evaluation, and safety infrastructure.

## Revision Notes

- This is the first draft of Section 1.6 based on Section 1.5.
- Official latest-system sources were checked before drafting.
- Latest systems are treated as case studies, not settled science.
- It bridges to Section 1.7 data/evaluation/safety layers.
