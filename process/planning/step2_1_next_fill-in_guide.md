내 생각엔 이 책은 **“장별로 순서대로 완성”**하면 품질이 떨어질 가능성이 커. 왜냐하면 초반 classical chapter를 먼저 길게 쓰면 보통 로봇제어 교과서처럼 흘러가고, 후반 VLA chapter를 먼저 쓰면 최신 논문 survey처럼 흘러가. 그래서 **책의 중심 interface를 먼저 고정하고, 그다음 각 장을 여러 번 얇게 덧칠하는 방식**이 좋아.

핵심 원칙은 이거야.

> **한 장을 완성하고 다음 장으로 넘어가지 말고, 전체 책의 spine을 먼저 고정한 뒤, 모든 장을 pass 단위로 점점 두껍게 만들어야 해.**

이 책의 spine은 이미 잡혀 있어. “VLA는 로봇 제어이론의 대체물이 아니라, task semantics와 embodied perception을 action-generation으로 연결하는 새로운 policy interface다”라는 중심 thesis, 그리고 고전 제어·고전 계획·모션플래닝·딥러닝·VLM/LLM을 하나의 안전하고 평가 가능한 embodied system으로 통합하는 문제라는 관점이야.  이걸 절대 흔들면 안 돼.

---

# 1. 전체 작성 순서

## 0단계. Book Bible부터 고정

본문을 더 쓰기 전에 먼저 **Book Bible**을 만들어야 해. 이건 5–10쪽짜리 내부 규격 문서야.

여기에 들어갈 것은 다음이야.

| 항목        | 고정해야 할 내용                                                                                                         |
| --------- | ----------------------------------------------------------------------------------------------------------------- |
| 책 제목      | Real VLA: A Roboticist’s Perspective                                                                              |
| 중심 thesis | VLA는 controller replacement가 아니라 embodied policy interface                                                        |
| 독자        | 로봇공학, AI, 제어, ML을 아는 대학원생/연구자                                                                                     |
| 문체        | 전문적이지만 survey paper보다 설명적인 교과서체                                                                                   |
| 장별 공통 구조  | Problem → Classical formulation → Learning formulation → VLA formulation → System interface → Failure mode        |
| 반복 금지 사항  | 논문 나열식 survey, generic control textbook화, hype성 VLA 소개                                                            |
| 핵심 비교축    | backbone, action representation, temporal horizon, embodiment, data source, control interface, safety, deployment |
| 용어 사전     | VLA, ER, action chunk, action token, action expert, TAMP, policy interface 등                                      |

원래 문서에서도 단순 논문 나열이 아니라 “개념 계보”로 써야 한다고 했고, 각 장이 “고전 이론은 어떤 문제를 풀었나 → 왜 VLA에서도 사라지지 않았나 → 최신 VLA는 어떻게 다시 formulation하나”에 답해야 한다고 정리했잖아.  이걸 Book Bible의 핵심 규칙으로 박아야 해.

---

## 1단계. Chapter 1을 먼저 확정

첫 번째로 써야 할 장은 무조건 **Chapter 1. What Is a Real VLA System?**이야.

이 장은 책 전체의 header file 같은 역할을 해. 여기서 다음을 고정해야 뒤 장들이 안 흔들려.

| Layer                    | 설명                                                                            |
| ------------------------ | ----------------------------------------------------------------------------- |
| Embodied reasoning layer | language, vision, memory, planning, tool/VLA 호출                               |
| VLA policy layer         | observation + instruction + proprioception → action chunk/waypoint/delta pose |
| Motion/control layer     | feasible trajectory, impedance, OSC, MPC, WBC                                 |
| Safety/evaluation layer  | monitor, shield, recovery, benchmark, distribution shift                      |
| Data engine layer        | demonstration, teleoperation, OXE/DROID류, synthetic/sim data, relabeling      |

이 장이 잘 잡히면 classical control 장도 “옛날 이론”이 아니라 “VLA stack의 하위 interface”로 읽히고, 최신 VLA 장도 “멋진 모델 소개”가 아니라 “시스템 설계 선택지”로 읽혀.

---

## 2단계. Chapter 13 Action Representation을 두 번째로 써야 해

많은 사람이 2장부터 순서대로 쓰려고 할 텐데, 나는 반대야. **Chapter 13. Action Representation**을 초기에 써야 해.

왜냐하면 이 책에서 가장 중요한 technical center가 “로봇 action을 어떻게 표현하느냐”이기 때문이야. 원래 청사진에서도 최신 흐름은 discrete action token, continuous regression, action chunking, diffusion, flow, action expert로 잡혀 있었고, 2024–2026년 VLA의 핵심축도 continuous action, diffusion/flow policy, action chunking으로 이동했다고 되어 있어. 

Chapter 13이 먼저 정리되면 나머지 장들이 훨씬 정확해져.

예를 들어:

| 이후 장       | Chapter 13이 미리 정해줘야 하는 것                                         |
| ---------- | ---------------------------------------------------------------- |
| 제어 장       | VLA output이 joint position인지, delta pose인지, torque인지, waypoint인지 |
| 데이터 장      | dataset의 action label을 어떻게 normalize할지                           |
| 평가 장       | success rate 외에 smoothness, latency, control frequency를 어떻게 볼지   |
| safety 장   | safety filter가 action token 뒤에 붙는지, continuous controller 앞에 붙는지 |
| humanoid 장 | whole-body action과 manipulation action의 차이를 어떻게 설명할지             |

즉, Chapter 13은 “중간 장”이 아니라 책 전체의 **action API 정의서**야.

---

## 3단계. Data, Evaluation, Safety를 초기에 같이 써야 해

Chapter 1과 Chapter 13 다음에는 바로 후반부의 세 장을 얇게라도 써야 해.

추천 순서는 이거야.

1. **Chapter 14. Data Engines**
2. **Chapter 16. Evaluation and Benchmarking**
3. **Chapter 19. Safety and Assurance**

이유는 간단해. VLA 책에서 어떤 모델이 좋다고 말하려면 항상 “어떤 데이터로 학습했는가, 어떤 benchmark에서 평가했는가, 실제 로봇에서 어떤 failure mode가 있는가”가 같이 따라와야 해. 원래 문서에서도 VLA scaling law는 웹 LLM처럼 단순하지 않고, 로봇 데이터는 비싸고 embodiment/action space/success label/distribution shift 문제가 크기 때문에 data collection, teleoperation, simulation, synthetic data, evaluation protocol이 핵심이라고 정리했어. 

그래서 최신 모델 장을 쓰기 전에 evaluation/safety 관점을 먼저 만들어둬야 hype를 막을 수 있어.

---

## 4단계. Classical Foundation은 나중에 “VLA로 역방향 연결”하면서 써야 해

그다음에 Chapter 2–5를 써야 해.

| 장                                   | 쓸 때의 기준                                                            |
| ----------------------------------- | ------------------------------------------------------------------ |
| Ch2 State, Dynamics, Estimation     | observation이 state가 아니라는 문제, proprioception/vision fusion, latency |
| Ch3 Control Interfaces              | joint/action/pose/torque/impedance/MPC를 VLA output boundary와 연결    |
| Ch4 Contact and Manipulation        | VLA가 접촉을 직접 이해하는가, 아니면 impedance/controller가 흡수하는가                 |
| Ch5 Planning, Motion Planning, TAMP | VLA subgoal, affordance, waypoint를 feasible trajectory로 바꾸는 문제     |

여기서 중요한 건 classical chapter를 **정석 교과서처럼 쓰면 안 된다는 것**이야. 원래 문서도 제어이론과 planning을 역사 파트에 묻어두면 약해지고, deployment에서는 low-level servo, OSC, impedance, contact safety, constraint satisfaction, motion feasibility, recovery, replanning이 여전히 중요하다고 했지. 

그러니까 각 classical chapter는 항상 이렇게 끝나야 해.

> 그래서 이 개념은 VLA stack에서 어느 interface에 들어가는가?

---

## 5단계. Robot Learning과 VLM/LLM bridge를 쓴다

그다음에 Chapter 6–12를 쓰면 돼.

추천 순서는 이렇게.

1. **Ch6 Imitation Learning and Covariate Shift**
2. **Ch8 Visuomotor Policies**
3. **Ch7 RL, Optimal Control, and Control as Inference**
4. **Ch9 Transformers, VLMs, and Grounding**
5. **Ch10 LLM/VLM as Robot Planner**
6. **Ch11 From Planner + Skills to VLA**
7. **Ch12 Robotics Transformer Era**

이 순서가 좋은 이유는, VLA의 직접 조상은 imitation learning, visuomotor policy, deep RL이고 여기서 “이미지 → action” 구조가 먼저 만들어진 뒤 언어와 VLM이 붙었다는 역사 흐름이 있기 때문이야.  또 LLM/VLM planner 시기는 아직 VLA라기보다 “LLM/VLM + 기존 robot skills/controller” 조합이지만, 현재 hierarchical VLA와 ER + VLA 구조의 조상이기 때문에 반드시 연결해서 써야 해. 

---

## 6단계. 최신 모델과 deployment 장을 마지막에 두껍게 만든다

마지막으로 다음 장들을 본격적으로 확장하면 돼.

| 장                                            | 역할                                                                        |
| -------------------------------------------- | ------------------------------------------------------------------------- |
| Ch15 Adaptation and Fine-Tuning              | OpenVLA, Octo, OpenVLA-OFT, FAST, VLA Foundry                             |
| Ch17 Hierarchical VLA and Embodied Reasoning | Gemini Robotics-ER류, ER + VLA, VLA + TAMP                                 |
| Ch18 Real-Time and Hardware-Aware VLA        | latency, on-device inference, cache, control frequency                    |
| Ch20 Humanoids and Whole-Body VLA            | GR00T, Helix case study, WBC, locomotion-manipulation coupling            |
| Ch21 Future Directions                       | world model, self-improving loop, verification, multi-embodiment transfer |

특히 최신 사례는 검증 수준이 다 달라. peer-reviewed 논문, arXiv preprint, company technical report, project page, GitHub release를 구분해야 해. 원래 문서에서도 Gemini Robotics-ER, GR00T, Figure Helix, VLA Foundry 같은 최신 흐름은 일부가 회사 기술 공개나 최신 사례이므로 “검증된 기반 논문”과 “case study”를 구분해서 쓰는 게 좋다고 했어. 

---

# 2. 추천하는 실제 증식 순서

내가 제일 추천하는 순서는 이거야.

```text
Pass 0. Book Bible 작성
Pass 1. 전체 21장 Chapter Contract 작성
Pass 2. Chapter 1 상세화
Pass 3. Chapter 13 상세화
Pass 4. Chapter 14, 16, 19 상세화
Pass 5. Chapter 2–5 classical foundation 상세화
Pass 6. Chapter 6–8 robot learning 상세화
Pass 7. Chapter 9–12 semantic/VLM/VLA history 상세화
Pass 8. Chapter 15, 17, 18, 20, 21 최신 시스템/배치 상세화
Pass 9. 전체 cross-reference 정리
Pass 10. 수식, 그림, 표, 박스, exercise 추가
Pass 11. citation audit + freshness audit
Pass 12. 문체 통일 + 최종 원고화
```

더 압축하면 이렇게야.

```text
Spine 먼저 → Action API → Data/Eval/Safety → Classical foundations → Learning history → Latest systems → Revision
```

---

# 3. 한 챕터를 불려나가는 내부 순서

각 챕터는 한 번에 본문을 쓰면 안 돼. 아래 7단계로 불려야 품질이 좋아져.

## Chapter Expansion Pass

| Pass | 산출물                   | 목적                              |
| ---- | --------------------- | ------------------------------- |
| 1    | Chapter Contract      | 이 장이 책에서 맡는 역할 고정               |
| 2    | Evidence Map          | 교과서, 논문, 시스템 사례, 반례 정리          |
| 3    | Argument Outline      | 단순 목차가 아니라 주장 흐름 정리             |
| 4    | Section Draft         | 1개 section씩 본문 작성               |
| 5    | Technical Deepening   | 수식, 알고리즘, 예제, 표, 그림 설명 추가       |
| 6    | Roboticist’s Takeaway | 실제 로봇 시스템 관점의 결론 박스             |
| 7    | Consistency Audit     | 앞뒤 장과 용어, claim, citation 충돌 검사 |

각 장의 Chapter Contract는 이런 형식이면 좋아.

```text
Chapter N. [Title]

1. One-sentence thesis
2. Why this chapter exists in a VLA book
3. Reader prerequisites
4. Concepts introduced
5. Concepts intentionally deferred
6. Core equations / algorithms
7. Core papers / textbooks
8. System interface explained in this chapter
9. Failure modes
10. Cross-links to previous and later chapters
11. Figures/tables needed
12. End-of-chapter Roboticist’s Takeaway
```

이걸 먼저 만들면 다음 턴들이 방향을 잃지 않아.

---

# 4. 다음 턴부터 이렇게 지시하면 좋아

## 4.1 Book Bible 만들 때

다음 턴에는 이렇게 지시하면 돼.

```text
지금까지 만든 Real VLA 책 청사진을 기준으로 Book Bible v0.1을 작성해줘.

목적은 이후 모든 챕터 작성의 고정 규격을 만드는 거야. 본문 원고를 쓰지 말고, 내부 편집 규칙 문서로 써줘.

반드시 포함:
1. 책의 중심 thesis
2. 대상 독자와 선수지식
3. 전체 21장 구조와 각 장의 역할
4. 장별 공통 서술 구조
5. 문체 규칙
6. 용어 정의 규칙
7. 수식/그림/표 사용 규칙
8. 최신 논문/회사 사례를 다루는 citation tier 규칙
9. hype를 막기 위한 금지 표현
10. 각 장 끝의 Roboticist’s Takeaway 템플릿

출력은 markdown으로.
```

이걸 먼저 만들고 나면 이후 모든 작업에서 “Book Bible v0.1을 기준으로”라고 지시하면 돼.

---

## 4.2 Chapter Contract 만들 때

```text
Book Bible v0.1을 기준으로 Chapter 13. Action Representation의 Chapter Contract를 작성해줘.

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
10. Roboticist’s Takeaway 초안
11. 이 장에서 조심해야 할 과장/오해
```

처음부터 “본문 써줘”라고 하면 문장이 먼저 생기고 구조가 뒤따라가. 반대로 Chapter Contract를 먼저 쓰면 구조가 문장을 제어해.

---

## 4.3 Evidence Map 만들 때

```text
Chapter 13. Action Representation의 Evidence Map을 작성해줘.

목표는 본문 작성 전에 이 장에서 인용하거나 재료로 삼을 문헌과 시스템을 정리하는 거야.

분류:
1. Discrete action token
2. Continuous regression
3. Action chunking
4. Diffusion policy
5. Flow matching
6. Action tokenizer / compression
7. Fine-tuning and action expert
8. Control-interface viewpoint

각 항목마다:
- 핵심 reference
- 이 reference가 답하는 질문
- 책에서 사용할 위치
- 장점
- 한계
- VLA system 관점의 해석

최신 논문은 웹으로 확인하고 출처를 붙여줘.
```

최신 논문이나 프로젝트가 들어가면 “웹으로 확인하고”를 꼭 넣는 게 좋아. 안 그러면 모델 기억 기반으로 틀릴 수 있어.

---

## 4.4 Section 하나씩 쓸 때

한 번에 chapter 전체를 쓰지 말고 section 하나씩 써야 해.

```text
이제 Chapter 13의 Section 13.1 “Why Action Representation Is the Control Boundary”를 본문 원고로 작성해줘.

조건:
- 한국어 전문 원고체, ‘이다’체
- 길이 1800–2500자
- 논문 나열 금지
- 수식은 꼭 필요한 것만
- classical control과 VLA를 연결할 것
- 마지막에는 5문장짜리 요약과 다음 section으로 넘어가는 bridge를 넣을 것
- 과장 표현 금지
- 독자가 기억해야 할 핵심 문장 1개를 bold로 표시
```

이 방식이 제일 안정적이야. 한 section이 잘 쓰이면 다음 section이 그 품질을 이어받아.

---

## 4.5 수식/그림/표를 추가할 때

본문 쓰기와 그림 설계를 분리하는 게 좋아.

```text
방금 쓴 Section 13.1에 들어갈 수식, 개념도, 표를 설계해줘.

조건:
1. 본문을 다시 쓰지 말 것
2. 수식은 notation 정의와 함께 제시
3. 그림은 실제 그림 파일이 아니라 figure caption과 구성 요소만 작성
4. 표는 chapter 내 비교표로 쓸 수 있게 작성
5. 각 수식/그림/표가 어떤 문단 뒤에 들어가야 하는지 표시
```

이렇게 해야 본문이 산만해지지 않아.

---

## 4.6 품질 평가를 시킬 때

각 장이 어느 정도 써지면 반드시 reviewer 모드로 돌려야 해.

```text
지금까지 작성한 Chapter 13 초안을 세 명의 reviewer 관점에서 평가해줘.

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

여기서 중요한 건 “전체 rewrite는 하지 마”야. 평가와 수정을 분리해야 원고가 덜 흔들려.

---

## 4.7 수정할 때

```text
방금 reviewer 평가에서 나온 patch plan만 반영해서 Chapter 13 Section 13.1–13.3을 수정해줘.

조건:
- 구조는 유지
- 새 section 추가 금지
- claim을 더 정확하게 만드는 방향
- 논문 나열식 문단으로 바꾸지 말 것
- 바뀐 부분만 보여주고, 각 변경 이유를 한 줄로 설명
```

이렇게 하면 수정이 폭주하지 않아.

---

# 5. 매 턴 앞에 붙이면 좋은 “작업 상태 블록”

incremental writing에서 제일 중요한 건 매 턴마다 context가 조금씩 흐려지는 걸 막는 거야. 그래서 다음처럼 prompt 앞에 붙이면 좋아.

```text
[Working State]

Book: Real VLA: A Roboticist’s Perspective
Core thesis: VLA is not a replacement for robotics control; it is a policy interface connecting task semantics and embodied perception to action generation.
Current phase: Chapter expansion
Current chapter: Chapter 13. Action Representation
Current deliverable: Section 13.2 draft
Locked decisions:
- Use Problem → Classical formulation → Learning formulation → VLA formulation → System interface → Failure mode.
- Avoid paper-list survey style.
- Always connect to real robot control interface.
- Treat latest company systems as case studies unless peer-reviewed.
- End each section with a bridge to the next section.
Do not change:
- Chapter title
- Overall book thesis
- Chapter sequence
```

이 블록을 매번 붙이면 내가 다음 내용을 채울 때 직전 턴의 방향을 더 잘 이어갈 수 있어.

---

# 6. 장별 작성 추천 순서

21장을 실제로 불려나갈 때는 이렇게 가는 게 좋아.

## Wave 1. Spine chapters

```text
Ch1. What Is a Real VLA System?
Ch13. Action Representation
Ch14. Data Engines
Ch16. Evaluation and Benchmarking
Ch19. Safety and Assurance
```

이 다섯 장이 책의 기준축이야. 이걸 먼저 쓰면 나머지 장은 이 기준축에 맞춰서 설명하면 돼.

## Wave 2. Classical-to-VLA bridge

```text
Ch2. State, Dynamics, and Estimation
Ch3. Control Interfaces
Ch4. Contact, Force, and Manipulation
Ch5. Planning, Motion Planning, and TAMP
```

이때는 절대 일반 제어/계획 교재처럼 쓰지 말고, 각 장 끝을 반드시 VLA와 연결해야 해.

## Wave 3. Learning history

```text
Ch6. Imitation Learning and Covariate Shift
Ch7. RL, Optimal Control, and Control as Inference
Ch8. Visuomotor Policies
```

여기는 VLA 이전의 직접 조상으로 써야 해.

## Wave 4. Semantic and transformer bridge

```text
Ch9. Transformers, VLMs, and Grounding
Ch10. LLM/VLM as Robot Planner
Ch11. From Planner + Skills to VLA
Ch12. Robotics Transformer Era
```

여기는 “LLM이 로봇을 움직인다”가 아니라 “언어/시각 표현이 robot policy interface에 들어오기 시작했다”는 식으로 써야 해.

## Wave 5. Modern system chapters

```text
Ch15. Adaptation and Fine-Tuning
Ch17. Hierarchical VLA and Embodied Reasoning
Ch18. Real-Time and Hardware-Aware VLA
Ch20. Humanoids and Whole-Body VLA
Ch21. Future Directions
```

여기는 최신 논문, project page, company report가 많이 섞이므로 citation tier와 freshness check가 중요해.

---

# 7. 피해야 할 지시 방식

아래 식으로 지시하면 결과 품질이 흔들릴 가능성이 커.

```text
1장 써줘.
13장 전체 써줘.
VLA 책 본문을 길게 써줘.
이 논문들 다 넣어서 정리해줘.
좀 더 자세히 써줘.
교과서처럼 써줘.
```

이런 지시는 너무 넓어. 그러면 모델이 generic textbook, 논문 survey, 블로그 글 중 하나로 미끄러질 수 있어.

대신 이렇게 해야 해.

```text
Chapter 13의 Section 13.2만 써줘.
이 section의 목적은 action tokenization과 continuous control의 tension을 설명하는 거야.
RT-2/OpenVLA는 예시로만 쓰고, 핵심은 control boundary로 잡아.
마지막에는 왜 action chunking으로 넘어가야 하는지 bridge를 넣어.
길이는 2000자.
```

이 정도로 좁히면 품질이 훨씬 좋아져.

---

# 8. 한 장을 완성하기 위한 이상적인 턴 구성

예를 들어 Chapter 13 하나를 완성하려면 다음 정도의 턴 구성이 좋아.

```text
Turn 1: Chapter Contract
Turn 2: Evidence Map
Turn 3: Detailed section outline
Turn 4: Section 13.1 draft
Turn 5: Section 13.2 draft
Turn 6: Section 13.3 draft
Turn 7: Section 13.4 draft
Turn 8: Section 13.5 draft
Turn 9: Figures/tables/equations
Turn 10: Roboticist’s Takeaway + exercises
Turn 11: Reviewer critique
Turn 12: Patch revision
Turn 13: Final integrated chapter
```

한 장당 10–15턴 정도는 쓰는 게 좋아. 책 전체를 제대로 쓰려면 빠른 초안은 가능하지만, “교과서급”으로 가려면 이 정도 밀도가 필요해.

---

# 9. 전체 원고가 누적될 때의 관리 방식

문서가 커지면 매번 전체를 다시 읽고 쓰는 게 비효율적이야. 그래서 각 장마다 아래 3개 파일/블록을 따로 관리하는 게 좋아.

```text
Chapter_N_contract.md
Chapter_N_draft.md
Chapter_N_revision_log.md
```

그리고 책 전체에는 다음 파일이 있어야 해.

```text
book_bible.md
global_glossary.md
citation_database.md
figure_table_inventory.md
open_issues.md
cross_reference_map.md
```

특히 `open_issues.md`가 중요해. 예를 들어:

```text
Open Issue #07:
Should Gemini Robotics-ER be described as VLA, ER model, or VLA orchestrator?
Current decision:
Describe it as embodied reasoning layer that may call VLA/controller.
Affected chapters:
Ch1, Ch17, Ch19, Ch21.
```

이런 식으로 관리해야 나중에 모순이 안 생겨.

---

# 10. 내가 다음 턴에 바로 추천하는 작업

바로 다음 턴에는 **Book Bible v0.1**을 만드는 게 좋아. 아직 본문을 더 쓰지 말고, 모든 이후 작업의 고정 규격을 세우는 게 맞아.

다음처럼 지시하면 돼.

```text
Real VLA 책의 Book Bible v0.1을 만들어줘.

지금까지 만든 v2 저술계획서, source corpus, chapter prologue의 방향을 반영해.
목적은 이후 모든 챕터를 incremental하게 작성하기 위한 고정 규격 문서를 만드는 거야.

반드시 포함:
1. Core thesis
2. Reader profile
3. Chapter architecture
4. Section-level template
5. Claim/citation policy
6. How to handle latest company systems
7. Mathematical notation policy
8. Figure/table policy
9. Roboticist’s Takeaway template
10. Quality checklist
11. Revision workflow
12. Prompt template for writing each section

출력은 markdown.
본문 원고는 쓰지 마.
```

그다음 턴은 이렇게 가면 돼.

```text
Book Bible v0.1을 기준으로 Chapter 1과 Chapter 13의 Chapter Contract를 각각 작성해줘.
두 장을 비교해서 어떤 용어와 interface 정의를 먼저 고정해야 하는지도 알려줘.
```

이 순서가 제일 안전해.

정리하면, **Ch1로 세계관을 고정하고, Ch13으로 action/control boundary를 고정하고, Ch14/16/19로 evidence·evaluation·safety 기준을 고정한 뒤, 나머지 장을 거기에 맞춰 역방향으로 키우는 방식**이 가장 좋아.
