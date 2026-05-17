이제 바로 다음은 **Ch1–Ch13 Interface Specification + Global Glossary v0.1** 만드는 게 제일 좋아.

지금까지 만든 것들은 이렇게 역할이 나뉘어 있어.

| 산출물                      | 역할         |
| ------------------------ | ---------- |
| v2 저술계획서                 | 책 전체 구조    |
| Book Bible               | 집필 규칙      |
| Wave 1 Chapter Contracts | 핵심 장들의 계약서 |
| Source Corpus            | 인용/재료 창고   |
| Prologues                | 장별 문제의식    |

이제 남은 핵심 문제는 이거야.

> **책 전체에서 “VLA가 무엇을 입력받고, 무엇을 출력하고, 어느 계층까지 책임지는가”를 고정해야 해.**

이걸 안 하고 바로 본문 쓰면 나중에 Ch1에서는 VLA를 system이라고 부르고, Ch13에서는 model이라고 부르고, Ch17에서는 embodied reasoning layer랑 VLA layer가 섞이고, Ch19에서는 safety boundary가 애매해질 수 있어.

원래 청사진의 핵심도 VLA를 단순 “이미지+언어→액션 모델”로 보지 않고, 고전 제어·계획·모션플래닝·로봇러닝·VLM/LLM이 합쳐진 embodied stack으로 보는 거였잖아.  그러니까 다음 단계는 이 stack의 **API 정의서**를 만드는 거야.

---

# 다음 산출물

파일명은 이렇게 가면 돼.

```text
Real_VLA_Interface_Spec_and_Global_Glossary_v0_1_2026_05.md
Real_VLA_Interface_Spec_and_Global_Glossary_v0_1_2026_05.docx
```

내용은 크게 두 덩어리야.

## 1. Interface Specification

여기서는 아래 계층을 정확히 정의해야 해.

| Layer                    | 정의해야 할 것                                                                 |
| ------------------------ | ------------------------------------------------------------------------ |
| Embodied Reasoning Layer | instruction, scene, memory, task decomposition, tool/VLA/controller call |
| VLA Policy Layer         | observation + language + proprioception → action representation          |
| Motion/Control Layer     | waypoint/action을 feasible trajectory 또는 servo command로 변환                |
| Safety Layer             | semantic, geometric, dynamic, runtime safety boundary                    |
| Data Engine Layer        | demonstration, relabeling, embodiment normalization, evaluation feedback |

특히 Ch1과 Ch13 사이의 경계를 고정해야 해.

```text
Ch1: Real VLA system 전체 stack 정의
Ch13: VLA policy output인 action representation 정의
```

즉, Ch1은 “전체 시스템이 어떻게 생겼는가”를 말하고, Ch13은 “그 시스템 안에서 action이 어떤 형태로 표현되는가”를 말하는 장이 되는 거야.

---

## 2. Global Glossary

책 전체에서 반복될 용어를 고정해야 해.

예를 들면:

| 용어                      | 고정해야 할 의미                                                     |
| ----------------------- | ------------------------------------------------------------- |
| VLA                     | vision-language-action model 또는 policy layer                  |
| Real VLA System         | VLA + controller + safety + data/eval stack                   |
| ER / Embodied Reasoning | physical world에서 reasoning, planning, tool/VLA 호출을 담당하는 상위 계층 |
| Action Token            | discrete token으로 표현된 action                                   |
| Action Chunk            | 여러 time step의 action sequence                                 |
| Waypoint                | controller/planner에 넘기는 중간 목표                                 |
| Delta Pose              | 현재 end-effector pose 기준 상대 pose command                       |
| Control Boundary        | learned policy와 classical controller가 만나는 경계                  |
| Embodiment Gap          | robot morphology/action/sensor 차이로 생기는 mismatch               |
| Safety Shield           | VLA command를 허용/수정/차단하는 runtime safety layer                  |

이 glossary가 생기면 이후 챕터 쓸 때 매번 용어가 흔들리지 않아.

---

# 지금 하면 안 좋은 것

지금 바로 이렇게 가면 안 좋아.

```text
Chapter 1 본문 써줘
Chapter 13 본문 써줘
Wave 1 전체 본문 써줘
```

아직 용어와 interface boundary가 완전히 잠기지 않았기 때문에, 본문부터 쓰면 나중에 고칠 양이 커져.

지금은 본문 작성 직전의 마지막 설계 단계야.

---

# 다음에 그대로 지시하면 좋은 프롬프트

다음 턴에는 이렇게 말하면 돼.

```text
Book Bible v0.1과 Wave 1 Chapter Contracts v0.1을 기준으로 
Ch1–Ch13 Interface Specification + Global Glossary v0.1을 만들어줘.

목표는 이후 본문 작성에서 용어, 계층, action/control boundary가 흔들리지 않게 하는 거야.

반드시 포함:
1. Real VLA system의 전체 stack 정의
2. Embodied Reasoning Layer 정의
3. VLA Policy Layer 정의
4. Motion/Control Layer 정의
5. Safety/Evaluation Layer 정의
6. Data Engine Layer 정의
7. Ch1에서 설명할 것과 Ch13으로 넘길 것
8. Ch13에서 정의할 action representation taxonomy
9. action token, action chunk, waypoint, delta pose, torque, whole-body action의 구분
10. VLA, ER, controller, planner, policy, skill, affordance, world model 용어 정의
11. 책 전체에서 금지하거나 조심해야 할 애매한 표현
12. Ch14, Ch16, Ch19가 이 interface spec을 어떻게 참조해야 하는지
13. 최소 2개의 stack diagram 설명
14. Global Glossary table
15. Open issues

본문 원고는 아직 쓰지 마.
출력은 md와 docx 둘 다 만들어줘.
```

---

# 그다음 순서

이걸 만들고 나면 다음 순서는 이렇게 가면 돼.

```text
1. Ch1–Ch13 Interface Specification + Global Glossary
2. Chapter 1 Evidence Map
3. Chapter 13 Evidence Map
4. Chapter 1 detailed outline
5. Chapter 1 Section 1.1 본문 작성
6. Chapter 1 Section 1.2 본문 작성
7. Chapter 1 전체 초안
8. Chapter 13 detailed outline
9. Chapter 13 section-by-section 작성
```

즉, 다음 큰 흐름은 이거야.

> **용어/계층 고정 → Ch1 근거 지도 → Ch1 본문 → Ch13 근거 지도 → Ch13 본문**

한 줄로 말하면, 지금 다음 작업은 **책의 API 문서 만들기**야.
그걸 해야 이후 본문이 논문 survey나 일반 제어 교과서로 미끄러지지 않고, “Real VLA: A Roboticist’s Perspective”의 방향을 계속 유지할 수 있어.
