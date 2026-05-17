Book Bible v0.1을 기준으로 Wave 1 핵심 장들의 Chapter Contract를 작성해줘.

대상:
- Chapter 1. What Is a Real VLA System?
- Chapter 13. Action Representation
- Chapter 14. Data Engines
- Chapter 16. Evaluation and Benchmarking
- Chapter 19. Safety and Assurance

각 장마다 다음 항목을 작성해:
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

마지막에는 다섯 장 사이의 의존성 그래프를 만들어줘.
본문 원고는 아직 쓰지 마.
출력은 markdown.

---
이제는 **본문을 바로 쓰기 시작하면 안 되고**, 이걸 “책 생산 시스템”으로 바꿔야 해. 지금 가진 건 꽤 좋아.

* v2 저술계획서: 책의 전체 구조
* Book Bible: 집필 규칙과 품질 기준
* source corpus: 인용/재료 창고
* chapter prologues: 각 장의 분위기와 문제의식
* 원래 역사 로드맵: VLA를 고전 제어·계획·모션플래닝·로봇러닝·VLM/LLM이 합쳐진 흐름으로 보는 중심 관점 

이제 해야 할 일은 **“원고 작성”이 아니라 “원고가 흔들리지 않게 고정할 핵심 장부터 생산”**하는 거야.

---

# 지금 바로 할 일

내 추천은 이 순서야.

```text
1. Wave 1 핵심 장들의 Chapter Contract 작성
2. Chapter 1과 Chapter 13을 먼저 상세화
3. Chapter 14, 16, 19를 이어서 상세화
4. 그다음 classical foundation 장으로 역방향 연결
5. 이후 robot learning / VLM / modern systems 확장
```

핵심은 이거야.

> **Ch1이 책의 세계관을 고정하고, Ch13이 action/control boundary를 고정하고, Ch14/16/19가 data·evaluation·safety 기준을 고정해야 해.**

이 다섯 장이 먼저 잡히면 나머지 장은 그 기준에 맞춰 쓰면 돼.

---

# 1순위: Wave 1 Chapter Contract 만들기

다음 턴에 바로 이걸 시키는 게 제일 좋아.

```text
Book Bible v0.1을 기준으로 Wave 1 핵심 장들의 Chapter Contract를 작성해줘.

대상:
- Chapter 1. What Is a Real VLA System?
- Chapter 13. Action Representation
- Chapter 14. Data Engines
- Chapter 16. Evaluation and Benchmarking
- Chapter 19. Safety and Assurance

각 장마다 다음 항목을 작성해:
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

마지막에는 다섯 장 사이의 의존성 그래프를 만들어줘.
본문 원고는 아직 쓰지 마.
출력은 markdown.
```

이게 다음 작업으로 제일 중요해. 왜냐하면 이 다섯 장이 책 전체의 **기준축**이기 때문이야.

---

# 왜 Chapter 1부터만 쓰면 안 되냐

보통은 “그럼 1장부터 써보자”라고 가기 쉬운데, 그건 약간 위험해.

Chapter 1만 먼저 길게 쓰면 세계관은 잡히지만, 실제 VLA의 핵심인 **action representation**, **data scaling**, **evaluation**, **safety** 기준이 아직 안 잡혀 있어서 나중에 다시 고쳐야 할 가능성이 커.

반대로 Chapter 13만 먼저 쓰면 기술적으로는 강해지지만, 독자가 “그래서 real VLA system이 뭔데?”를 놓칠 수 있어.

그래서 제일 좋은 건:

```text
Ch1 Contract
Ch13 Contract
Ch14 Contract
Ch16 Contract
Ch19 Contract
→ 다섯 장의 관계 정리
→ 그다음 Ch1 Section 1.1부터 작성
```

이 순서야.

---

# 2순위: Chapter 1과 Chapter 13을 쌍으로 고정

Wave 1 contract가 끝나면 바로 다음엔 **Chapter 1과 Chapter 13을 같이 다뤄야 해.**

왜냐하면 Chapter 1은 “Real VLA system이 무엇인가”를 정의하고, Chapter 13은 “VLA가 실제 로봇에 어떤 action interface로 연결되는가”를 정의해.

둘이 서로 맞아야 해.

예를 들어 Chapter 1에서 VLA output을 이렇게 말했는데,

```text
VLA policy outputs action chunks, waypoints, or low-level motor commands.
```

Chapter 13에서 action을 이렇게 말하면 안 돼.

```text
VLA primarily outputs discrete language-like action tokens.
```

이러면 책 전체가 흔들려. 그래서 두 장은 반드시 같이 고정해야 해.

다음다음 턴에는 이렇게 시키면 좋아.

```text
Wave 1 Chapter Contract를 기준으로 Chapter 1과 Chapter 13의 interface definitions를 고정해줘.

목표:
Real VLA stack과 action representation이 서로 모순되지 않도록 용어와 경계를 정리하는 것.

포함:
1. Real VLA stack diagram 설명
2. Embodied reasoning layer 정의
3. VLA policy layer 정의
4. Motion/control layer 정의
5. Safety/evaluation layer 정의
6. Data engine layer 정의
7. Action token, action chunk, waypoint, delta pose, torque, whole-body action의 정의
8. 어떤 용어를 책 전체에서 어떻게 쓸지 glossary 초안
9. Chapter 1에서 먼저 설명할 것과 Chapter 13으로 넘길 것
10. Chapter 13에서 Chapter 1을 어떻게 참조할지

본문 원고는 쓰지 말고, interface specification 문서로 작성해줘.
```

이건 사실상 책의 **API 문서**야. 이게 있으면 이후 장들이 훨씬 안정돼.

---

# 3순위: Chapter 1 Section 1.1부터 실제 원고 작성

그다음에야 본문을 써야 해.

첫 번째 본문은 무조건 Chapter 1의 첫 section이 좋아.

추천 section은 이거야.

```text
1.1 Why “Real VLA” Is Not Just a Bigger VLM
```

여기서 책의 중심 문장을 박아야 해.

> **A real VLA is not a model that replaces robotics; it is an interface that reorganizes control, planning, perception, language, data, and safety into one embodied system.**

이 문장은 책 전체의 기준 문장으로 계속 써도 좋아.

이때 지시는 이렇게 하면 돼.

```text
Book Bible v0.1과 Wave 1 Chapter Contract를 기준으로 Chapter 1 Section 1.1 “Why Real VLA Is Not Just a Bigger VLM”을 본문 원고로 작성해줘.

조건:
- 한국어 전문 원고체, ‘이다’체
- 길이 2500–3500자
- 논문 나열 금지
- VLA hype를 경계하는 톤
- Real VLA를 단일 모델이 아니라 embodied system interface로 정의할 것
- classical control, planning, robot learning, VLM/LLM, data, safety가 왜 동시에 필요한지 설명할 것
- 마지막에는 Section 1.2로 넘어가는 bridge 문단을 넣을 것
- 핵심 문장 1개를 bold로 표시할 것
```

---

# 전체 작업 로드맵은 이렇게 가면 돼

## Phase A. 구조 고정

```text
A1. Wave 1 Chapter Contract
A2. Ch1–Ch13 interface specification
A3. Global glossary v0.1
A4. Figure/table inventory v0.1
```

여기까지는 본문보다 설계야.

---

## Phase B. 핵심 장 초안

```text
B1. Chapter 1 본문
B2. Chapter 13 본문
B3. Chapter 14 본문
B4. Chapter 16 본문
B5. Chapter 19 본문
```

이 다섯 장이 책의 중심이야.

---

## Phase C. 기반 이론 장 확장

```text
C1. Chapter 2 State, Dynamics, and Estimation
C2. Chapter 3 Control Interfaces
C3. Chapter 4 Contact, Force, and Manipulation
C4. Chapter 5 Planning, Motion Planning, and TAMP
```

이 장들은 “옛날 이론 설명”이 아니라 “VLA system에서 왜 아직 필요한가”로 써야 해.

---

## Phase D. 역사적 bridge 장 확장

```text
D1. Chapter 6 Imitation Learning
D2. Chapter 7 RL and Optimal Control
D3. Chapter 8 Visuomotor Policies
D4. Chapter 9 Transformers and VLMs
D5. Chapter 10 LLM/VLM as Robot Planner
D6. Chapter 11 From Planner + Skills to VLA
D7. Chapter 12 Robotics Transformer Era
```

여기는 VLA가 갑자기 나온 게 아니라는 계보를 설명하는 파트야.

---

## Phase E. 최신 시스템 장 확장

```text
E1. Chapter 15 Adaptation and Fine-Tuning
E2. Chapter 17 Hierarchical VLA and Embodied Reasoning
E3. Chapter 18 Real-Time and Hardware-Aware VLA
E4. Chapter 20 Humanoids and Whole-Body VLA
E5. Chapter 21 Future Directions
```

여기는 최신 논문과 회사 시스템이 많으니까, 반드시 citation tier를 지켜야 해.

---

# 지금 네가 해야 할 가장 좋은 다음 지시

바로 다음 턴에는 이렇게 말하면 돼.

```text
좋아. Wave 1 Chapter Contract부터 만들어줘. 
대상은 Ch1, Ch13, Ch14, Ch16, Ch19야. 
Book Bible v0.1 기준으로 작성하고, 본문 원고는 아직 쓰지 마. 
각 장의 thesis, 역할, section outline, 핵심 주장, 주요 reference, failure mode, Roboticist’s Takeaway, 조심해야 할 오해를 정리해줘. 
마지막에는 다섯 장 사이의 의존성 그래프와 다음 작업 순서를 제안해줘. 
md와 docx 둘 다 만들어줘.
```

이게 지금 시점에서 제일 생산적인 작업이야.

---

# 한 줄로 정리하면

지금은 책을 쓰는 단계가 아니라, **책이 안 흔들리게 할 핵심 5개 장의 계약서를 만드는 단계**야.

**다음 산출물은 `Wave_1_Chapter_Contracts.md/docx`가 맞아.**
