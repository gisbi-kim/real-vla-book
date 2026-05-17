# Real VLA: Chapter 1 Detailed Outline v0.1

**Chapter:** Chapter 1. *What Is a Real VLA System?*  
**Document type:** Detailed Outline. 본문 원고 아님. 단순 목차 아님.  
**Version:** 2026.05.12 KST  
**Basis:** Book Bible v0.1, Wave 1 Chapter Contracts v0.1, Ch1-Ch13 Interface Specification + Global Glossary v0.1, Chapter 1 Evidence Map v0.1.  
**Purpose:** Chapter 1 본문 작성 직전에 section/subsection 단위의 논증 흐름, evidence placement, figure/table/box placement, scope boundary, writing order를 고정한다.

---

## 0. Working Rule for This Outline

이 문서는 Chapter 1을 쓰기 위한 **argument blueprint**이다. 따라서 아래 문서는 본문 문장으로 바로 옮기기 위한 원고가 아니라, 어떤 순서로 어떤 주장을 증명하고 무엇을 뒤 장으로 넘길지 고정하는 설계도이다.

- 본문 원고를 쓰지 않는다.
- 단순 bibliography를 만들지 않는다.
- 각 reference는 “어떤 claim을 지지하는가”로 배치한다.
- 최신 company system은 일반 법칙이 아니라 case study로만 사용한다.
- Chapter 1은 책의 definition layer이다. 자세한 알고리즘, 수식, dataset catalog, safety taxonomy는 뒤 장으로 넘긴다.

---

## 1. Chapter 1의 역할 재정의

### 1.1 이 장이 책 전체에서 맡는 기능

Chapter 1은 책 전체의 **header file**이다. 이 장은 독자에게 VLA를 단일 모델 이름이나 최신 논문 family로 이해하지 않도록, Real VLA를 다음과 같은 embodied system interface로 정의한다.

```text
language / task semantics
  -> embodied reasoning
  -> VLA policy-level action
  -> motion/control translation
  -> physical robot execution
  -> safety, data, evaluation feedback
```

이 장의 기능은 세 가지이다.

1. **Definition function:** VLA policy, Real VLA system, embodied reasoning, controller, safety, data/evaluation layer의 경계를 정의한다.
2. **Anti-hype function:** “큰 VLM이 로봇 제어를 대체한다”, “benchmark success가 곧 embodied intelligence다” 같은 약한 주장을 초반에 차단한다.
3. **Navigation function:** 이후 Ch13/Ch14/Ch16/Ch19가 왜 책의 핵심 장인지 독자에게 미리 알려준다.

### 1.2 독자가 이 장을 읽고 나면 알아야 하는 것

Chapter 1을 읽은 독자는 다음 질문에 답할 수 있어야 한다.

- Real VLA와 단순 VLA policy model은 어떻게 다른가?
- ER layer, VLA policy layer, motion/control layer, safety layer, data/evaluation layer는 각각 무엇을 책임지는가?
- `a_t`와 `u_t`, observation과 state, plan/subgoal과 action은 왜 구분되어야 하는가?
- 왜 action representation은 출력 포맷이 아니라 control boundary 문제인가?
- 왜 VLA 성능은 architecture만이 아니라 data, evaluation, safety, deployment evidence까지 포함해야 주장될 수 있는가?
- 최신 Gemini Robotics-ER, Gemini Robotics, GR00T, Helix 같은 사례를 왜 “settled science”가 아니라 system pattern case study로 읽어야 하는가?

### 1.3 뒤 장으로 넘길 핵심 개념

- **Ch13으로 넘길 것:** action token, continuous action, waypoint, delta pose, action chunk, diffusion/flow action, action expert, whole-body action, `a_t` vs `u_t`의 상세 trade-off.
- **Ch14로 넘길 것:** data engine, embodiment normalization, robot data curation, failure data, teleoperation, simulation/synthetic data, cross-embodiment transfer.
- **Ch16으로 넘길 것:** benchmark protocol, reproducibility, distribution shift test, reasoning stress test, simulation-to-real gap, latency-aware evaluation.
- **Ch19로 넘길 것:** semantic safety, geometric safety, dynamic/contact safety, runtime assurance, safety shield, human override, unsafe demonstration filtering.

---

## 2. Chapter 1 One-Sentence Thesis

### 2.1 English thesis for manuscript planning

**A real VLA system is not a larger VLM that directly replaces robotics; it is a layered embodied interface that connects task semantics, multimodal perception, robot state, action representation, control, data, evaluation, and safety into one executable physical system.**

### 2.2 한국어 본문용 thesis

**Real VLA는 로봇 제어를 대체하는 하나의 거대 모델이 아니라, 언어와 시각으로 표현된 task semantics를 실제 로봇의 제약 있는 action generation으로 연결하는 embodied system interface이다.**

### 2.3 Chapter 1에서 반복할 핵심 문장 후보

- **Real VLA의 핵심은 “더 똑똑한 VLM”이 아니라 “어디까지를 모델이 책임지고 어디부터를 로봇 시스템이 책임지는가”라는 interface 설계이다.**
- **VLA policy는 action을 제안하지만, Real VLA system은 그 action이 실행, 평가, 감시, 복구될 수 있게 만든다.**
- **Benchmark에서 성공한 VLA는 좋은 시작점이지만, 실제 로봇 능력은 controller, data, evaluation, safety, deployment loop까지 포함할 때만 주장될 수 있다.**

---

## 3. Chapter 1 전체 논증 흐름

Chapter 1의 논증은 아래 순서로 진행한다.

1. **도입:** “image + language -> action”이라는 표준 설명이 왜 유용하지만 불완전한지 보여준다.
2. **실행 경로:** 자연어 목표가 곧 motor command가 아니라, subgoal, policy-level action, controller target, safety decision을 거친다는 점을 설명한다.
3. **Stack 정의:** ER, VLA policy, motion/control, safety, data/evaluation layer를 정의한다.
4. **Interface 정의:** observation/state, plan/action, `a_t`/`u_t`, action/control boundary를 고정한다.
5. **역사적 수렴:** 고전 제어, planning/TAMP, robot learning, VLM/LLM이 각각 Real VLA stack 안에서 어떤 역할을 맡는지 연결한다.
6. **현대 시스템 pattern:** RT/RT-2/OpenVLA/pi0류, Gemini Robotics-ER/Gemini Robotics류, GR00T/Helix류를 system pattern으로만 짧게 배치한다.
7. **Data/evaluation/safety:** 모델 성능만으로는 Real VLA를 설명할 수 없음을 보이고, Ch14/Ch16/Ch19로 넘긴다.
8. **Reading protocol:** 이후 책과 VLA 논문을 어떤 질문으로 읽어야 하는지 정리한다.

---

## 4. Ch1 전체 opening example 선택

### 4.1 최우선 opening example

**Opening example:** “Put the mug on the drying rack, but do not knock over the glass.”

### 4.2 이 예제가 가장 적합한 이유

이 예제는 Chapter 1의 거의 모든 핵심 claim을 작은 장면 안에 담는다.

- VLM은 mug, drying rack, glass를 인식할 수 있다.
- ER layer는 “mug를 옮기되 glass를 피하라”는 constraint와 success condition을 해석해야 한다.
- VLA policy는 grasp, lift, move, place에 해당하는 policy-level action을 제안해야 한다.
- motion/control layer는 end-effector pose, collision avoidance, contact, force, timing을 처리해야 한다.
- safety layer는 glass와 사람, workspace, excessive force를 감시해야 한다.
- evaluation layer는 단순 “mug moved”가 아니라 “glass not knocked over”, “safe contact”, “recovery if slip occurs”를 함께 봐야 한다.

### 4.3 대체 opening example 후보

- **Clean the table after breakfast:** semantic categorization, ordering, partial completion, recovery를 보여주기에 좋다.
- **Sort household waste according to local rules:** ER + VLA + external knowledge/tool use를 보여주기에 좋다.
- **Humanoid room-level cleanup demo:** whole-body action과 deployment frontier를 보여주기에 좋지만, Ch1 첫 예제로 쓰면 company-demo 중심으로 보일 위험이 있다.

### 4.4 Opening example 사용 위치

- Section 1.1에서 예제를 제시한다.
- Section 1.2에서 이 예제를 stack flow로 분해한다.
- Section 1.7에서 이 예제의 evaluation/safety 항목을 다시 회수한다.
- Section 1.8에서 “이 예제를 보고 VLA paper를 어떻게 읽을 것인가”로 연결한다.

---

## 5. Section-Level and Subsection-Level Detailed Outline

---

## 1.1 Why “Real VLA” Is Not Just a Bigger VLM

### Section thesis

Real VLA는 더 큰 VLM이 아니며, vision-language representation을 physical action boundary에 연결하는 embodied system interface이다.

### 이 section에서 답하는 질문

- 왜 “image + language -> action”이라는 설명만으로는 충분하지 않은가?
- VLM의 semantic competence와 robot의 physical competence는 어떻게 다른가?
- Chapter 1에서 Real VLA를 model이 아니라 system interface로 정의해야 하는 이유는 무엇인가?

### 핵심 claim

- **Claim 1:** Real VLA system은 single monolithic model이 아니라 layered embodied system이다.
- **Claim 5:** VLM/LLM bridge system은 semantic grounding을 일부 해결했지만, embodiment-specific affordance가 여전히 병목이다.

### 사용할 evidence

- **Tier A:** A1-A4 for robotics stack vocabulary; A5-A6 for planning and goal/action distinction.
- **Tier B:** B18 SayCan, B19 Code as Policies, B20 PaLM-E, B21 RT-1, B22 RT-2.
- **Tier C:** B24 OpenVLA, C1 pi0, C5 VLA Foundry as examples of policy/training stack directions.
- **Tier D:** D1 Gemini Robotics-ER 1.6 as ER-layer case; D2 Gemini Robotics 1.5 as VLA case.

### 사용할 figure/table/box

- **Table 1.1:** VLM vs VLA Policy vs ER Model vs Real VLA System.
- **Box 1.1:** VLA is not a controller replacement.

### 들어가면 좋은 opening example 또는 mini case

“Put the mug on the drying rack, but do not knock over the glass.” 이 예제를 통해 VLM recognition, ER constraint interpretation, VLA action proposal, controller execution, safety monitoring을 분리한다.

### 피해야 할 오해 또는 hype

- “VLM이 장면을 이해하면 로봇 action도 해결된다.”
- “VLA는 기존 control stack을 지우는 end-to-end replacement이다.”
- “최신 company demo는 일반 physical intelligence의 증거이다.”

### 다음 section으로 넘어가는 bridge

이 section이 “VLA는 model-only 문제가 아니다”를 확정하면, 다음 section은 자연어 목표가 실제 motor command가 되기까지 어떤 중간 representation과 layer를 거치는지 보여준다.

### Subsection 1.1.1 The useful but incomplete abstraction: image + language -> action

- **핵심 내용:** VLA를 처음 설명할 때 “image + language -> action”은 유용한 shorthand이다. 그러나 이 shorthand는 physical execution, feedback, safety, controller, data/evaluation을 숨긴다. 이 subsection은 shorthand를 폐기하지 않고, 그것을 policy-layer abstraction으로 제한한다.
- **Reference/system case:** B21 RT-1, B22 RT-2, B24 OpenVLA.
- **도식/표:** Table 1.1의 첫 열에서 VLA policy의 input/output을 정의한다.
- **강조 문장 후보:** **“image + language -> action은 VLA policy의 입출력 요약이지, 실제 로봇 시스템의 전체 설명이 아니다.”**

### Subsection 1.1.2 Semantic understanding is not physical executability

- **핵심 내용:** VLM은 mug와 glass를 인식하고 instruction을 해석할 수 있지만, reachable pose, collision, contact force, timing, slipping, recovery를 자동으로 보장하지 않는다. 이 distinction이 Real VLA를 system 문제로 끌고 온다.
- **Reference/system case:** A1-A4, B4-B6, B18 SayCan.
- **도식/표:** Box 1.1에 “semantic success != physical success”를 넣는다.
- **강조 문장 후보:** **“장면을 말로 설명할 수 있다는 것과 그 장면 안에서 안전하게 움직일 수 있다는 것은 다른 능력이다.”**

### Subsection 1.1.3 Real VLA as an embodied system interface

- **핵심 내용:** 이 책의 Real VLA는 VLA policy만이 아니라 reasoning, control, safety, data/evaluation이 결합된 accountability stack이다. 모델이 여러 layer를 통합 구현할 수는 있지만 책임 경계는 여전히 구분되어야 한다.
- **Reference/system case:** B18, B19, B20, D1, D2.
- **도식/표:** 다음 section의 Figure 1.1을 예고한다.
- **강조 문장 후보:** **“구현이 통합되어도 책임은 통합되지 않는다.”**

### Subsection 1.1.4 What Chapter 1 will and will not do

- **핵심 내용:** Ch1은 모든 VLA 논문을 정리하지 않는다. 대신 전체 책에서 반복될 vocabulary와 claim boundary를 고정한다. action representation, data, evaluation, safety의 상세 논의는 각각 Ch13, Ch14, Ch16, Ch19로 넘긴다.
- **Reference/system case:** Book Bible core thesis; Wave 1 Contracts; Evidence Map Claim 1-10.
- **도식/표:** Claim-to-chapter handoff preview.
- **강조 문장 후보:** **“Chapter 1의 목적은 VLA model catalog가 아니라 Real VLA system의 정의를 잠그는 것이다.”**

---

## 1.2 From Language Goal to Motor Command

### Section thesis

자연어 instruction은 곧바로 torque나 velocity command가 되지 않으며, Real VLA system에서는 subgoal, policy-level action, safety decision, controller command의 단계로 물리화된다.

### 이 section에서 답하는 질문

- 하나의 자연어 명령은 robot stack 안에서 어떤 representation들로 변환되는가?
- ER layer와 VLA policy layer는 어떤 점에서 다른가?
- policy-level action과 low-level command의 차이는 왜 중요한가?

### 핵심 claim

- **Claim 1:** Real VLA system은 layered system이다.
- **Claim 3:** Action representation은 VLA의 control boundary이다.
- **Claim 4:** Planning/TAMP는 long-horizon structure, constraints, recovery 때문에 여전히 필요하다.
- **Claim 9:** Safety는 model property가 아니라 stack property이다.

### 사용할 evidence

- **Tier A:** A1-A6 for control/planning distinction.
- **Tier B:** B3 MPC, B4-B6 interaction/control, B10 PDDLStream, B18 SayCan, B19 Code as Policies.
- **Tier D:** D1 Gemini Robotics-ER as embodied reasoning layer case; D2/D3 as action-producing or humanoid stack cases.

### 사용할 figure/table/box

- **Figure 1.1:** Real VLA System Stack diagram.
- **Box 1.2:** ER layer vs VLA policy layer.

### 들어가면 좋은 opening example 또는 mini case

Opening example의 mug task를 다음 sequence로 분해한다.

```text
instruction -> subgoal/constraint -> action proposal -> safety check -> controller command -> execution feedback
```

### 피해야 할 오해 또는 hype

- “ER model이 action planning을 한다면 곧 VLA이다.”
- “VLA policy output은 곧 motor command이다.”
- “safety는 나중에 wrapper로 붙이면 된다.”

### 다음 section으로 넘어가는 bridge

이 section은 실행 경로를 보였지만, 각 layer의 책임을 아직 이름 붙이지 않았다. 다음 section은 이 경로를 다섯 개 layer의 stack으로 정식 정의한다.

### Subsection 1.2.1 Instruction, task semantics, and success condition

- **핵심 내용:** 자연어 instruction은 object, relation, constraint, success condition을 포함한다. “mug를 drying rack에 놓기”는 목표이고, “glass를 치지 않기”는 constraint이며, “놓였다”는 success condition이다.
- **Reference/system case:** A6 Automated Planning, B8 STRIPS, B9 PDDL, B18 SayCan.
- **도식/표:** Instruction decomposition mini-table.
- **강조 문장 후보:** **“언어 명령은 action이 아니라 action을 조직하는 task semantics이다.”**

### Subsection 1.2.2 Subgoal and action are different executable objects

- **핵심 내용:** Subgoal은 “무엇이 달라져야 하는가”를 말하고, action은 “어떤 interface로 로봇에게 무엇을 보낼 것인가”를 말한다. ER layer는 subgoal/constraint를 만들 수 있지만, VLA policy는 robot-executable action object를 제안한다.
- **Reference/system case:** B18 SayCan, B19 Code as Policies, D1 Gemini Robotics-ER.
- **도식/표:** Table 1.1에서 ER Model vs VLA Policy 비교.
- **강조 문장 후보:** **“Subgoal은 의도이고, action은 로봇 stack이 해석해야 하는 실행 객체이다.”**

### Subsection 1.2.3 Policy-level action, controller target, and motor command

- **핵심 내용:** VLA가 출력하는 `a_t`는 action token, waypoint, delta pose, chunk, distribution일 수 있다. 실제 actuator에 들어가는 `u_t`는 velocity, torque, impedance target, position command 등이다. 둘의 분리는 Ch13의 중심 문제로 넘긴다.
- **Reference/system case:** A1-A4, B3-B6, B14, B22, C1, C3.
- **도식/표:** Figure 1.2 Control Boundary: `a_t` vs `u_t`.
- **강조 문장 후보:** **“VLA가 action을 낸다는 말은 그 action이 곧 actuator command라는 뜻이 아니다.”**

### Subsection 1.2.4 Safety and feedback are part of the path, not afterthoughts

- **핵심 내용:** Execution path는 one-shot prediction이 아니라 feedback loop이다. Safety gate는 instruction, plan, `a_t`, `u_t`, state estimate를 보고 개입할 수 있으며, data/evaluation layer는 실패와 intervention을 기록한다.
- **Reference/system case:** B3 MPC, B5 impedance, C8 ASIMOV v2, C9 VLA safety survey.
- **도식/표:** Figure 1.1에서 safety/data wrapper를 강조한다.
- **강조 문장 후보:** **“Real VLA의 실행 경로는 prediction path가 아니라 monitored feedback path이다.”**

---

## 1.3 The Five-Layer Real VLA Stack

### Section thesis

Real VLA system은 embodied reasoning, VLA policy, motion/control, safety/assurance, data/evaluation이라는 다섯 responsibility layer로 읽어야 한다.

### 이 section에서 답하는 질문

- Real VLA stack의 각 layer는 무엇을 입력받고 무엇을 출력하는가?
- 각 layer가 책임지는 것과 책임지지 않는 것은 무엇인가?
- 실제 구현에서 layer가 합쳐져도 왜 개념적으로는 분리해야 하는가?

### 핵심 claim

- **Claim 1:** Real VLA는 layered embodied system이다.
- **Claim 2:** Observation은 state가 아니다.
- **Claim 6:** VLA scaling은 architecture만이 아니라 data engine 문제이다.
- **Claim 9:** Safety는 stack property이다.

### 사용할 evidence

- **Tier A:** A1-A8 for stack vocabulary from robotics/control/planning/learning.
- **Tier B:** B1-B6, B11-B14, B18-B24.
- **Tier C/D:** C5 VLA Foundry, C6 vla-eval, C8 ASIMOV v2, D1-D3.

### 사용할 figure/table/box

- **Figure 1.1:** Real VLA System Stack diagram.
- **Table 1.2:** Layer-by-layer input/output/responsibility table.
- **Box 1.2:** ER layer vs VLA policy layer.

### 들어가면 좋은 opening example 또는 mini case

Opening example을 layer별로 재배치한다. ER은 constraint, VLA는 pick/place action, controller는 trajectory/servo, safety는 glass collision monitor, data/evaluation은 success/failure log를 담당한다.

### 피해야 할 오해 또는 hype

- 모든 system이 반드시 이 다섯 layer를 별도 module로 구현한다는 인상.
- End-to-end model에는 safety나 controller responsibility가 없다는 인상.
- data/evaluation layer가 deployment 이후 문서화 단계일 뿐이라는 인상.

### 다음 section으로 넘어가는 bridge

Stack을 정의했다면, 이제 각 layer 사이의 interface를 더 엄밀하게 정의해야 한다. 특히 observation/state와 `a_t`/`u_t` 구분이 필요하다.

### Subsection 1.3.1 Embodied reasoning layer: deciding what should happen

- **핵심 내용:** ER layer는 scene understanding, task decomposition, constraint proposal, tool/VLA call, success/progress 판단을 담당한다. 이 layer는 physical execution guarantee가 아니라 “무엇을 해야 하는가”를 정리한다.
- **Reference/system case:** B18 SayCan, B19 Code as Policies, B20 PaLM-E, D1 Gemini Robotics-ER.
- **도식/표:** Table 1.2 row: Embodied Reasoning Layer.
- **강조 문장 후보:** **“ER layer는 motor command를 보장하는 layer가 아니라, action을 호출할 수 있게 task를 구조화하는 layer이다.”**

### Subsection 1.3.2 VLA policy layer: proposing policy-level action

- **핵심 내용:** VLA policy는 observation, language/subgoal, proprioception, short memory를 받아 action object를 제안한다. 이 장에서는 action taxonomy를 깊게 풀지 않고, type/rate/frame/horizon/controller metadata가 필요하다는 점만 고정한다.
- **Reference/system case:** B21 RT-1, B22 RT-2, B24 OpenVLA, C1 pi0.
- **도식/표:** Table 1.2 row: VLA Policy Layer.
- **강조 문장 후보:** **“VLA policy는 행동을 실행하는 모든 책임이 아니라, 실행 가능한 action proposal을 만드는 책임을 가진다.”**

### Subsection 1.3.3 Motion/control layer: translating action into physically trackable commands

- **핵심 내용:** Controller는 VLA output을 그대로 pass-through하는 executor가 아니다. IK, trajectory generation, impedance, OSC, MPC, WBC는 VLA action을 물리적 command로 해석한다.
- **Reference/system case:** A1-A4, B3-B6.
- **도식/표:** Table 1.2 row: Motion/Control Layer.
- **강조 문장 후보:** **“Controller는 learned policy의 하위 부품이 아니라, physical feasibility를 해석하는 별도의 책임 layer이다.”**

### Subsection 1.3.4 Safety and data/evaluation as cross-cutting layers

- **핵심 내용:** Safety와 data/evaluation은 pipeline 끝에 붙는 appendix가 아니라 stack 전체를 감싼다. Safety는 allow/modify/stop/recover 권한을 가져야 하고, data/evaluation은 claim의 evidence를 만들어야 한다.
- **Reference/system case:** C5 VLA Foundry, C6 vla-eval, C8 ASIMOV v2, C9 safety survey.
- **도식/표:** Figure 1.1의 wrapper arrows.
- **강조 문장 후보:** **“Real VLA에서 safety와 evaluation은 모델 이후의 행정 절차가 아니라 시스템 정의의 일부이다.”**

---

## 1.4 Interface Contracts: Observation, State, Action, and Control

### Section thesis

Real VLA stack이 작동하려면 observation, state, policy-level action, controller command, safety decision의 interface contract가 명확해야 한다.

### 이 section에서 답하는 질문

- `o_t`, `s_t`, `q_t`, `a_t`, `u_t`는 각각 무엇인가?
- 왜 observation과 state를 혼동하면 VLA를 과대평가하게 되는가?
- 왜 action representation이 control boundary가 되는가?

### 핵심 claim

- **Claim 2:** Observation is not state.
- **Claim 3:** Action representation is the control boundary.
- **Claim 7:** Modern VLA architecture is organized around temporal/action distribution choices.

### 사용할 evidence

- **Tier A:** A1-A4 for state/action/control vocabulary; A7-A8 for policy notation.
- **Tier B:** B1 Kalman, B3-B6, B11 DAgger, B14 Diffusion Policy, B22 RT-2.
- **Tier C:** C1 pi0, C3 FAST, C4 OpenVLA-OFT, C10 openpi.

### 사용할 figure/table/box

- **Figure 1.2:** Control Boundary: `a_t` vs `u_t`.
- **Table 1.3:** Action representation preview and handoff to Ch13.
- **Box 1.3:** Why action representation is a control boundary.

### 들어가면 좋은 opening example 또는 mini case

Mug task에서 camera image는 mug pose, glass stability, gripper force, current joint state, future collision risk를 완전히 알려주지 않는다. VLA가 delta pose를 출력하는지 waypoint를 출력하는지에 따라 controller burden이 달라진다.

### 피해야 할 오해 또는 hype

- “더 많은 camera와 더 큰 VLM이면 state estimation 문제가 사라진다.”
- “action token, waypoint, torque는 단지 다른 encoding일 뿐이다.”
- “continuous action이 항상 discrete token보다 우월하다.”

### 다음 section으로 넘어가는 bridge

Interface contract를 정의하면, 이제 왜 이런 문제들이 VLA 시대에 갑자기 생긴 것이 아니라 control, planning, robot learning, VLM/LLM의 역사적 수렴에서 나온 것인지 설명할 수 있다.

### Subsection 1.4.1 Observation, proprioception, state estimate, and memory

- **핵심 내용:** `o_t`는 camera/depth/tactile observation이고, `q_t`는 proprioception 또는 robot state vector이며, `s_t`는 실제 latent world state이다. VLA는 주로 observation-conditioned policy이지만, controller와 safety는 state estimate와 timing을 요구한다.
- **Reference/system case:** B1 Kalman, A1-A4, B12 visuomotor policy, B21 RT-1.
- **도식/표:** Small notation box: `o_t`, `q_t`, `s_t`, `m_t`.
- **강조 문장 후보:** **“로봇이 본다는 것은 로봇이 상태를 안다는 뜻이 아니다.”**

### Subsection 1.4.2 Policy-level action `a_t` and low-level command `u_t`

- **핵심 내용:** `a_t`는 VLA policy의 출력이고, `u_t`는 servo/actuator/controller command이다. `a_t`는 token, delta pose, waypoint, chunk, distribution일 수 있으며, `u_t`는 velocity, torque, position, impedance target일 수 있다.
- **Reference/system case:** B3-B6, B14, B22, C1, C3.
- **도식/표:** Figure 1.2.
- **강조 문장 후보:** **“책 전체에서 action이라는 단어는 반드시 level과 downstream controller를 함께 가져야 한다.”**

### Subsection 1.4.3 Frame, rate, horizon, and controller metadata

- **핵심 내용:** 같은 numeric vector라도 world frame, robot-base frame, end-effector frame, joint frame인지에 따라 완전히 다른 action이다. VLA rate와 controller rate가 다르고, action horizon과 chunk length가 다르면 latency와 stability 문제가 생긴다.
- **Reference/system case:** A1-A4, B3 MPC, C4 OpenVLA-OFT, C1 pi0.
- **도식/표:** Table 1.3의 columns: type, frame, rate, horizon, controller burden.
- **강조 문장 후보:** **“Action representation은 숫자의 모양이 아니라 frame, rate, horizon, controller contract까지 포함한 interface이다.”**

### Subsection 1.4.4 Action representation preview: token, chunk, diffusion, flow

- **핵심 내용:** Ch1은 action token, chunk, diffusion, flow를 자세히 비교하지 않는다. 대신 왜 이 taxonomy가 Ch13의 중심인지 예고한다. 핵심은 output format 선택이 physical control burden을 재배분한다는 점이다.
- **Reference/system case:** B22 RT-2, B14 Diffusion Policy, C1 pi0, C3 FAST, C4 OpenVLA-OFT.
- **도식/표:** Box 1.3.
- **강조 문장 후보:** **“Action representation은 VLA architecture 문제가 아니라 model과 controller 사이의 계약 문제이다.”**

---

## 1.5 Historical Convergence: Control, Planning, Robot Learning, and VLM/LLM

### Section thesis

VLA는 갑자기 등장한 model family가 아니라, control/estimation, planning/TAMP, robot learning, VLM/LLM, data/evaluation/safety가 하나의 embodied policy stack으로 수렴한 결과이다.

### 이 section에서 답하는 질문

- Classical control과 planning은 왜 VLA 책에서 “배경”이 아니라 현재형 tool인가?
- Robot learning과 visuomotor policy는 VLA의 어떤 직접 조상인가?
- VLM/LLM은 VLA stack에 무엇을 추가했고, 무엇을 해결하지 못했는가?

### 핵심 claim

- **Claim 4:** Classical planning/TAMP remains necessary.
- **Claim 5:** VLM/LLM bridge systems solved semantic grounding only partially.
- **Claim 6:** VLA scaling is data-engineering constrained.
- **Claim 7:** Action distribution choices became central.

### 사용할 evidence

- **Tier A:** A1-A8.
- **Tier B:** B1-B22, especially B11-B14 and B18-B22.
- **Tier C:** C1-C5 as emerging modern continuation.

### 사용할 figure/table/box

- **Figure 1.3:** Historical Convergence Map.
- **Table 1.4:** Historical ingredients and what they contribute to Real VLA.

### 들어가면 좋은 opening example 또는 mini case

Opening example의 각 요구를 historical ingredient에 매핑한다. Mug pose/control은 robotics/control, constraint는 planning, learned pick/place는 robot learning, object semantics는 VLM/LLM, success/failure log는 data/evaluation/safety가 담당한다.

### 피해야 할 오해 또는 hype

- “고전 제어/계획은 VLA 이전 시대의 낡은 배경이다.”
- “VLA는 LLM/VLM에서 자연스럽게 나온 field이다.”
- “robot learning은 단순히 VLM에 action head를 붙이면서 대체되었다.”

### 다음 section으로 넘어가는 bridge

역사적 수렴을 이해하면 현대 시스템들이 왜 서로 다른 architecture를 택하는지 더 정확히 읽을 수 있다. 다음 section은 최신 모델을 leaderboard가 아니라 system pattern으로 분류한다.

### Subsection 1.5.1 Control and estimation: stable execution and feedback

- **핵심 내용:** Kalman filtering, MPC, impedance, operational-space control은 VLA가 없애는 것이 아니라 VLA action이 물리계에 들어갈 때 필요한 언어이다. 이 subsection은 Ch2-Ch4로 이어지는 classical foundation의 필요성을 예고한다.
- **Reference/system case:** B1, B3-B6, A1-A4.
- **도식/표:** Figure 1.3 top-left branch.
- **강조 문장 후보:** **“VLA가 의미론을 추가해도 로봇은 여전히 추정, 제어, 접촉, 제약 안에서 움직인다.”**

### Subsection 1.5.2 Planning and TAMP: goal structure, constraints, and recovery

- **핵심 내용:** Long-horizon instruction은 precondition, sequencing, feasibility, recovery를 요구한다. LLM/VLM/ER가 planning function 일부를 흡수하더라도 task structure는 사라지지 않는다.
- **Reference/system case:** A5-A6, B7-B10, B18, B19.
- **도식/표:** Table 1.4 row: Planning/TAMP.
- **강조 문장 후보:** **“LLM planner가 등장해도 planning problem은 사라지지 않고 representation이 바뀐다.”**

### Subsection 1.5.3 Robot learning: perception-to-action before language grounding

- **핵심 내용:** VLA 이전에도 visuomotor policy, imitation learning, RL, large-scale grasping은 image-to-action learning의 기반을 만들었다. VLA는 여기에 language grounding과 foundation model representation을 결합한 흐름이다.
- **Reference/system case:** B11 DAgger, B12 visuomotor policy, B13 QT-Opt, B14 Diffusion Policy.
- **도식/표:** Figure 1.3 robot learning branch.
- **강조 문장 후보:** **“VLA의 직접 조상은 LLM만이 아니라 visuomotor robot learning이다.”**

### Subsection 1.5.4 VLM/LLM bridge: semantics, grounding, and affordance bottleneck

- **핵심 내용:** CLIP/Flamingo류 representation, SayCan/Code as Policies/PaLM-E류 bridge system은 semantics와 planning을 로봇에 연결했다. 그러나 embodiment-specific feasibility와 action execution은 별도 문제로 남았다.
- **Reference/system case:** B16, B17, B18, B19, B20, B22.
- **도식/표:** Table 1.4 row: VLM/LLM.
- **강조 문장 후보:** **“VLM/LLM은 로봇에게 의미를 주었지만, 그 의미를 물리적으로 실행 가능하게 만드는 문제를 끝내지는 않았다.”**

---

## 1.6 Modern System Patterns: Model-only VLA, ER + VLA, and Humanoid Deployment

### Section thesis

최신 VLA/ER/humanoid system은 모델 leaderboard가 아니라 system responsibility pattern으로 읽어야 하며, Ch1에서는 landscape를 보여주되 깊은 기술 판단은 뒤 장으로 넘긴다.

### 이 section에서 답하는 질문

- RT/RT-2/OpenVLA/pi0류는 어떤 VLA policy pattern을 보여주는가?
- Gemini Robotics-ER류는 왜 VLA policy라기보다 ER/orchestrator layer로 분류해야 하는가?
- GR00T/Helix류 humanoid case는 무엇을 보여주고, 무엇을 증명하지 못하는가?

### 핵심 claim

- **Claim 7:** Action representation과 temporal/action distribution choices가 현대 VLA의 중심축이다.
- **Claim 10:** 2025-2026 systems show ER+VLA+controller/humanoid trends but must be treated as case studies, not settled science.

### 사용할 evidence

- **Tier B:** B21 RT-1, B22 RT-2, B23 Open X-Embodiment/RT-X, B24 OpenVLA.
- **Tier C:** C1 pi0, C2 pi0.5, C3 FAST, C4 OpenVLA-OFT, C5 VLA Foundry, C10 openpi.
- **Tier D:** D1 Gemini Robotics-ER 1.6, D2 Gemini Robotics 1.5, D3-D4 GR00T N1.7, D5 Helix/Helix 02, D6 OpenVLA GitHub.

### 사용할 figure/table/box

- **Table 1.5:** Modern system pattern matrix.
- **Box 1.2:** ER layer vs VLA policy layer.
- **Box 1.3:** Why action representation is a control boundary.

### 들어가면 좋은 opening example 또는 mini case

Humanoid room cleanup demo를 짧게 언급하되, “무엇을 보여주는가”와 “무엇을 증명하지 않는가”를 분리한다. 이 예시는 Ch20으로 넘긴다.

### 피해야 할 오해 또는 hype

- “Gemini Robotics-ER는 곧 VLA이다.”
- “GR00T/Helix류 demo는 humanoid general intelligence를 증명한다.”
- “Open-source VLA는 곧 deployable robot system이다.”
- “최신성이 곧 신뢰도이다.”

### 다음 section으로 넘어가는 bridge

최신 system pattern을 보았으면, 이제 model architecture만으로 성능을 판단할 수 없다는 결론이 나온다. 다음 section은 data, evaluation, safety를 Real VLA의 core layer로 정의한다.

### Subsection 1.6.1 Robotics Transformer and VLA policy pattern

- **핵심 내용:** RT-1/RT-2/OpenVLA류는 language-conditioned robot action generation을 VLA policy로 볼 수 있는 대표 흐름이다. Ch1에서는 token/action prediction의 역사적 의미만 짚고, 모델 세부 구조는 Ch12/Ch15로 넘긴다.
- **Reference/system case:** B21, B22, B24, D6.
- **도식/표:** Table 1.5 row: VLA Policy Pattern.
- **강조 문장 후보:** **“Robotics Transformer 흐름의 전환점은 vision-language representation이 robot action prediction과 결합되었다는 점이다.”**

### Subsection 1.6.2 Action-distribution pattern: diffusion, flow, tokenization, fine-tuning

- **핵심 내용:** Diffusion/flow/action tokenization/fine-tuning 흐름은 VLA가 더 이상 backbone 크기만의 경쟁이 아님을 보여준다. Ch1에서는 이 흐름을 Ch13/Ch15로 넘기기 위한 preview로만 다룬다.
- **Reference/system case:** B14 Diffusion Policy, C1 pi0, C3 FAST, C4 OpenVLA-OFT, C10 openpi.
- **도식/표:** Table 1.3 action representation preview.
- **강조 문장 후보:** **“현대 VLA의 핵심 질문은 어떤 VLM을 쓰는가만이 아니라 어떤 시간 구조와 확률분포로 action을 생성하는가이다.”**

### Subsection 1.6.3 ER + VLA orchestration pattern

- **핵심 내용:** Gemini Robotics-ER류는 physical-world reasoning, spatial reasoning, task planning, tool/VLA invocation을 담당하는 ER layer로 분류하는 것이 안전하다. action-producing VLA와 ER/orchestrator를 혼동하면 Ch1의 stack boundary가 무너진다.
- **Reference/system case:** D1 Gemini Robotics-ER 1.6, D2 Gemini Robotics 1.5, B18 SayCan, B19 Code as Policies.
- **도식/표:** Box 1.2 ER layer vs VLA policy layer.
- **강조 문장 후보:** **“ER model은 무엇을 해야 하는지 구조화할 수 있지만, 그것만으로 motor-action policy가 되는 것은 아니다.”**

### Subsection 1.6.4 Humanoid and whole-body deployment as frontier, not proof

- **핵심 내용:** GR00T/Helix류 humanoid case는 whole-body action, controller integration, safety envelope, latency, data collection 문제를 극단적으로 드러낸다. 그러나 Ch1에서는 peer-reviewed conclusion이 아니라 deployment frontier case study로만 사용한다.
- **Reference/system case:** D3-D4 GR00T N1.7, D5 Helix/Helix 02, A1-A4 for whole-body/control background.
- **도식/표:** Table 1.5 row: Humanoid/Whole-body Pattern.
- **강조 문장 후보:** **“Humanoid VLA는 general robotics가 해결되었다는 증거가 아니라, action/control/safety/data 문제가 한꺼번에 커지는 frontier이다.”**

---

## 1.7 Data, Evaluation, and Safety as System Layers

### Section thesis

Real VLA의 능력은 architecture만으로 주장될 수 없고, 어떤 데이터로 학습했는지, 어떤 protocol로 평가했는지, 어떤 safety layer로 감시되는지와 함께 정의되어야 한다.

### 이 section에서 답하는 질문

- 왜 robot data는 web text/image data처럼 단순 scaling되지 않는가?
- 왜 benchmark success는 robot capability와 다를 수 있는가?
- 왜 safety는 모델 내부 속성이 아니라 stack property인가?

### 핵심 claim

- **Claim 6:** VLA scaling은 data-engineering constrained이다.
- **Claim 8:** Evaluation은 task success 이상을 테스트해야 한다.
- **Claim 9:** Safety is a stack property.

### 사용할 evidence

- **Tier A:** A7-A8 for policy/data/evaluation vocabulary; A4 for robotics safety context.
- **Tier B:** B11 DAgger, B13 QT-Opt, B23 Open X-Embodiment, B24 OpenVLA, B25 Octo, B26 DROID.
- **Tier C:** C5 VLA Foundry, C6 vla-eval, C7 BeTTER, C8 ASIMOV v2, C9 VLA safety survey.
- **Tier D:** D1-D5 only as case studies requiring safety/evaluation discipline.

### 사용할 figure/table/box

- **Table 1.6:** Model-only VLA vs Real VLA System.
- **Box 1.4:** Benchmark success is not robot capability.
- **Figure 1.4:** Failure Modes by Layer.

### 들어가면 좋은 opening example 또는 mini case

Opening mug task에서 success metric을 여러 층으로 분해한다: mug placed, glass untouched, no collision, force within safe bound, no human intervention, recovery after slip, reproducible under layout shift.

### 피해야 할 오해 또는 hype

- “더 큰 dataset이면 generalization이 해결된다.”
- “benchmark score가 높으면 실제 배치가 가능하다.”
- “semantic safety filter가 있으면 로봇 safety가 해결된다.”

### 다음 section으로 넘어가는 bridge

Data/evaluation/safety가 core layer라면, Chapter 1의 마지막은 독자가 이후 장과 논문을 읽을 때 사용할 질문 목록으로 마무리되어야 한다.

### Subsection 1.7.1 Data engine is not a dataset appendix

- **핵심 내용:** VLA data는 observation, language, robot state, action type, controller, success/failure, intervention, normalization metadata를 포함한다. 데이터 수량보다 embodiment coverage, label quality, failure coverage가 중요하다.
- **Reference/system case:** B23, B24, B25, B26, C5.
- **도식/표:** Data/evaluation layer row in Table 1.2.
- **강조 문장 후보:** **“Robot data는 텍스트 corpus가 아니라 controller와 embodiment가 묻어 있는 실행 기록이다.”**

### Subsection 1.7.2 Benchmark VLA vs Real VLA System

- **핵심 내용:** Benchmark는 비교를 가능하게 하지만, real robot capability를 완전히 대표하지 않는다. Protocol, distribution shift, reasoning stress, latency, recovery, safety intervention이 함께 평가되어야 한다.
- **Reference/system case:** C6 vla-eval, C7 BeTTER, B23-B26.
- **도식/표:** Table 1.6.
- **강조 문장 후보:** **“Benchmark success는 evidence이지 capability 그 자체가 아니다.”**

### Subsection 1.7.3 Safety as semantic, geometric, dynamic, runtime, and data responsibility

- **핵심 내용:** 위험한 명령을 거절하는 semantic safety와 충돌/힘/속도/접촉을 다루는 physical safety는 다르다. Safety layer는 instruction, plan, action, command, runtime state, data log에 모두 걸쳐야 한다.
- **Reference/system case:** B3 MPC, B5 impedance, C8 ASIMOV v2, C9 safety survey.
- **도식/표:** Figure 1.4 Failure Modes by Layer.
- **강조 문장 후보:** **“Safety는 VLA 모델의 성격이 아니라 시스템 전체의 개입 권한과 시간 제약의 문제이다.”**

### Subsection 1.7.4 Why Ch14, Ch16, and Ch19 are core chapters

- **핵심 내용:** 이 subsection은 Ch14/Ch16/Ch19가 부록이 아니라 Real VLA를 정의하는 핵심 장임을 명시한다. Data는 학습 근거, evaluation은 주장 근거, safety는 deployment 근거이다.
- **Reference/system case:** C5, C6, C8, C9.
- **도식/표:** Dependency map from Ch1 to Ch14/Ch16/Ch19.
- **강조 문장 후보:** **“Real VLA의 성능 주장은 model card가 아니라 data, evaluation, safety dossier를 요구한다.”**

---

## 1.8 Failure Modes and the Roboticist’s Reading Protocol

### Section thesis

Chapter 1은 독자가 이후 모든 VLA 논문과 시스템을 backbone보다 interface, action, data, evaluation, safety, deployment evidence로 읽도록 만드는 protocol로 끝나야 한다.

### 이 section에서 답하는 질문

- Real VLA system에서 대표 failure mode는 layer별로 어디에서 발생하는가?
- VLA paper를 roboticist 관점에서 읽을 때 던져야 할 질문은 무엇인가?
- Ch1이 이후 책 전체에 무엇을 lock하는가?

### 핵심 claim

- **Claim 1-10 전체를 요약.**
- 특히 Claim 8과 Claim 9를 마지막에 다시 강조한다.

### 사용할 evidence

- 새로운 source를 거의 추가하지 않는다.
- 앞 section에서 사용한 evidence를 reading protocol로 재조합한다.
- 단, failure-mode box에는 C6 vla-eval, C7 BeTTER, C8 ASIMOV v2, C9 VLA safety survey를 다시 연결한다.

### 사용할 figure/table/box

- **Figure 1.5:** Ch1 -> Ch13/14/16/19 dependency map.
- **Checklist 1.1:** Six questions for reading a VLA paper.
- **Table 1.7:** Failure mode by layer.

### 들어가면 좋은 opening example 또는 mini case

Opening mug task를 마지막에 다시 회수한다. “이 task를 수행했다”는 claim을 평가하려면 어떤 source of evidence가 필요한지 체크한다.

### 피해야 할 오해 또는 hype

- Ch1을 비관적 결론으로 끝내는 것.
- 실패 모드가 많으니 VLA가 쓸모없다는 인상.
- 반대로 checklist를 형식적 rubric처럼 만들어서 실제 system reasoning을 약화시키는 것.

### 다음 section으로 넘어가는 bridge

Chapter 1은 Real VLA의 stack과 vocabulary를 잠근다. Chapter 2는 이 중 observation과 state, estimation과 latency 문제를 더 엄밀하게 다룬다. Wave 1 집필 순서에서는 Chapter 13이 먼저 확장되어 action/control boundary를 자세히 분석한다.

### Subsection 1.8.1 Layer-by-layer failure modes

- **핵심 내용:** ER hallucination, state mismatch, action granularity mismatch, controller infeasibility, safety latency, dataset bias, benchmark artifact를 layer별로 정리한다. Failure mode는 pessimism이 아니라 robotics competence의 정의이다.
- **Reference/system case:** B1, B3-B6, B11, C6, C7, C8, C9.
- **도식/표:** Table 1.7.
- **강조 문장 후보:** **“VLA의 실패는 모델 내부에서만 발생하지 않고, layer 사이의 계약이 깨질 때 발생한다.”**

### Subsection 1.8.2 Six questions for reading a VLA paper

- **핵심 내용:** 독자가 이후 논문을 읽을 때 던질 질문을 제시한다: backbone, action representation, data source, control interface, evaluation protocol, safety/deployment evidence.
- **Reference/system case:** Book Bible comparison axes; Wave 1 contract.
- **도식/표:** Checklist 1.1.
- **강조 문장 후보:** **“VLA 논문을 읽을 때 첫 질문은 ‘몇 점인가’가 아니라 ‘어떤 interface를 바꾸었는가’이어야 한다.”**

### Subsection 1.8.3 What Chapter 1 locks for the rest of the book

- **핵심 내용:** Ch1이 고정한 vocabulary를 요약한다: Real VLA system, VLA policy, ER layer, action/control boundary, data/evaluation layer, safety as stack property. 그리고 Ch13/Ch14/Ch16/Ch19로 명시적으로 handoff한다.
- **Reference/system case:** no new reference.
- **도식/표:** Figure 1.5 dependency map.
- **강조 문장 후보:** **“이 책에서 Real VLA는 모델 이름이 아니라, 언어적 목표가 안전하게 실행 가능한 물리 action으로 바뀌는 전체 책임 구조의 이름이다.”**

---

## 6. Chapter 1에서 사용할 Figure/Table 후보

### Figure 1.1. Real VLA System Stack Diagram

**Placement:** Section 1.2 또는 1.3 시작부.  
**Purpose:** Real VLA가 단일 모델이 아니라 responsibility stack임을 시각화한다.

```text
Human instruction / task context
        ↓
Embodied Reasoning Layer
(scene understanding, task decomposition, memory, tool/VLA calls)
        ↓
VLA Policy Layer
(observation + language + proprioception -> policy-level action)
        ↓
Safety Gate / Assurance Monitor
(allow / modify / stop / recover / ask human)
        ↓
Motion / Control Layer
(trajectory, servo, impedance, OSC, MPC, WBC)
        ↓
Robot hardware + environment
        ↕
Sensors / logs / failures / interventions
        ↓
Data / Evaluation Layer
(training corpus, metrics, regression tests, evidence)
```

**Supported sections:** 1.2, 1.3, 1.7.  
**Warning:** “모든 시스템이 이 exact pipeline을 구현한다”는 뜻으로 보이지 않게 caption에 “conceptual accountability stack”이라고 명시한다.

### Figure 1.2. Control Boundary: `a_t` vs `u_t`

**Placement:** Section 1.4.  
**Purpose:** policy-level action과 low-level command의 차이를 잠근다.

```text
o_t, q_t, language/subgoal
        ↓
VLA policy
        ↓
a_t: token | waypoint | delta_pose | chunk | distribution | skill_call
        ↓
planner/controller/safety translation
        ↓
u_t: velocity | torque | position target | impedance target
        ↓
robot
```

**Supported sections:** 1.2, 1.4, 1.6.  
**Handoff:** Ch13.

### Figure 1.3. Historical Convergence Map

**Placement:** Section 1.5.  
**Purpose:** VLA를 paper chronology가 아니라 concept lineage로 설명한다.

```text
Control/Estimation -> stable execution, feedback, constraints
Planning/TAMP -> goals, sequencing, feasibility, recovery
Robot Learning -> perception-to-action, imitation/RL, data-driven policy
VLM/LLM -> semantics, instruction following, grounding, tool use
Data/Eval/Safety -> scaling evidence, benchmark validity, assurance
          ↓
      Real VLA System
```

### Figure 1.4. Failure Modes by Layer

**Placement:** Section 1.7 또는 1.8.  
**Purpose:** failure가 model 내부가 아니라 layer/interface 전체에서 생긴다는 점을 보여준다.

### Figure 1.5. Ch1-to-Wave-1 Dependency Map

**Placement:** Section 1.8.  
**Purpose:** Ch1이 Ch13/14/16/19로 어떤 개념을 넘기는지 보여준다.

```text
Ch1 Real VLA definition
  -> Ch13 Action Representation: action/control boundary
  -> Ch14 Data Engines: data/evaluation metadata and embodiment gap
  -> Ch16 Evaluation: benchmark vs capability
  -> Ch19 Safety: semantic/geometric/dynamic/runtime safety
```

### Table 1.1. VLM vs ER Model vs VLA Policy vs Real VLA System

**Placement:** Section 1.1 or 1.2.  
**Purpose:** VLM, ER model, VLA policy, Real VLA system을 혼동하지 않게 한다.  
**Recommended format:** Word 본문에서는 넓은 6-column table 대신 아래 bullet matrix를 사용한다.

- **VLM**
  - Typical input: image/video + text.
  - Typical output: description, answer, reasoning text.
  - Physical responsibility: none by default.
  - Example use in Ch1: semantic perception.
  - Cannot guarantee alone: feasible action.
- **ER model**
  - Typical input: observation + instruction + memory.
  - Typical output: subgoal, plan, tool/VLA call.
  - Physical responsibility: task-level reasoning.
  - Example use in Ch1: Gemini Robotics-ER style case.
  - Cannot guarantee alone: low-level control.
- **VLA policy**
  - Typical input: observation + language/subgoal + proprioception.
  - Typical output: policy-level action.
  - Physical responsibility: action proposal.
  - Example use in Ch1: RT/RT-2/OpenVLA/pi0 style case.
  - Cannot guarantee alone: full safety/feasibility.
- **Real VLA system**
  - Typical input: full stack inputs.
  - Typical output: executed, monitored, evaluated behavior.
  - Physical responsibility: stack-level responsibility.
  - Example use in Ch1: book's main object.
  - Cannot guarantee alone: universal guarantee.

### Table 1.2. Layer별 Input/Output/Responsibility Table

**Placement:** Section 1.3.  
**Purpose:** Real VLA stack의 각 layer가 무엇을 받고 무엇을 내보내는지 고정한다.  
**Recommended format:** Word 본문에서는 row-wise bullet table로 사용한다.

- **Embodied reasoning layer**
  - Input: observation, instruction, memory.
  - Output: subgoal, plan, constraint, VLA call.
  - Responsibility: what should happen.
  - Handoff chapter: Ch17.
- **VLA policy layer**
  - Input: observation, proprioception, language/subgoal.
  - Output: `a_t`, action chunk, distribution, waypoint.
  - Responsibility: action proposal.
  - Handoff chapter: Ch13.
- **Motion/control layer**
  - Input: `a_t`, robot state, constraints.
  - Output: trajectory, `u_t`, controller target.
  - Responsibility: physical execution.
  - Handoff chapter: Ch3/Ch4.
- **Safety/assurance layer**
  - Input: instruction, plan, action, state, monitor.
  - Output: allow, modify, stop, recover.
  - Responsibility: risk intervention.
  - Handoff chapter: Ch19.
- **Data/evaluation layer**
  - Input: trajectories, failures, logs, protocols.
  - Output: dataset, metrics, evidence.
  - Responsibility: claim support.
  - Handoff chapter: Ch14/Ch16.

### Table 1.3. Action Representation Preview

**Placement:** Section 1.4.  
**Purpose:** Ch13으로 넘길 action taxonomy를 Ch1에서 preview한다.  
**Recommended format:** Word 본문에서는 action type별 bullet block으로 사용한다.

- **Action token**
  - Ch1 role: introduce as VLM-compatible interface.
  - Controller burden: high translation burden.
  - Main risk: quantization, latency.
  - Detailed chapter: Ch13.
- **Delta pose**
  - Ch1 role: introduce as common manipulation interface.
  - Controller burden: medium.
  - Main risk: frame/scaling mismatch.
  - Detailed chapter: Ch13/Ch3.
- **Waypoint**
  - Ch1 role: introduce as planner/controller target.
  - Controller burden: medium-high.
  - Main risk: infeasible waypoint.
  - Detailed chapter: Ch13/Ch5.
- **Action chunk**
  - Ch1 role: introduce as temporal abstraction.
  - Controller burden: depends on controller.
  - Main risk: stale chunk, recovery delay.
  - Detailed chapter: Ch13.
- **Diffusion/flow action**
  - Ch1 role: introduce as action distribution.
  - Controller burden: depends on frequency.
  - Main risk: sampling latency, safety.
  - Detailed chapter: Ch13.
- **Torque/velocity command**
  - Ch1 role: mention as low-level command.
  - Controller burden: lower translation burden but higher safety burden.
  - Main risk: instability, force risk.
  - Detailed chapter: Ch3/Ch4/Ch19.
- **Whole-body action**
  - Ch1 role: mention as humanoid frontier.
  - Controller burden: very high.
  - Main risk: coupled dynamics, safety envelope.
  - Detailed chapter: Ch20.

### Table 1.4. Historical Ingredients and Their VLA Contribution

**Placement:** Section 1.5.  
**Purpose:** VLA를 chronology가 아니라 contribution map으로 설명한다.  
**Recommended format:** Word 본문에서는 ingredient별 bullet block으로 사용한다.

- **Control/estimation**
  - Contributes: feedback, stability, constraints.
  - Does not solve alone: semantics and task decomposition.
  - Ch1 placement: 1.5.1.
- **Planning/TAMP**
  - Contributes: goals, preconditions, feasibility, recovery.
  - Does not solve alone: learned perception-action under uncertainty.
  - Ch1 placement: 1.5.2.
- **Robot learning**
  - Contributes: perception-to-action and data-driven policy.
  - Does not solve alone: language/common sense/general task semantics.
  - Ch1 placement: 1.5.3.
- **VLM/LLM**
  - Contributes: semantics, instruction following, tool use.
  - Does not solve alone: embodiment-specific control and safety.
  - Ch1 placement: 1.5.4.
- **Data/eval/safety**
  - Contributes: evidence, validation, deployment discipline.
  - Does not solve alone: model architecture by itself.
  - Ch1 placement: 1.7.

### Table 1.5. Modern System Pattern Matrix

**Placement:** Section 1.6.  
**Purpose:** 최신 system을 leaderboard가 아니라 pattern으로 분류한다.  
**Recommended format:** Word 본문에서는 pattern별 bullet block으로 사용한다.

- **VLA policy model**
  - Representative cases: RT-1, RT-2, OpenVLA, pi0.
  - Ch1 use: show action-producing policy layer.
  - Defer to: Ch12/Ch13/Ch15.
- **Action-distribution VLA**
  - Representative cases: Diffusion Policy, pi0, OpenVLA-OFT, FAST.
  - Ch1 use: preview action/control boundary.
  - Defer to: Ch13.
- **ER + VLA orchestrator**
  - Representative cases: Gemini Robotics-ER + VLA style systems.
  - Ch1 use: show hierarchical reasoning/action split.
  - Defer to: Ch17.
- **Humanoid/whole-body VLA**
  - Representative cases: GR00T, Helix.
  - Ch1 use: show deployment frontier.
  - Defer to: Ch20.
- **Training/evaluation stack**
  - Representative cases: VLA Foundry, vla-eval.
  - Ch1 use: show evidence and reproducibility layers.
  - Defer to: Ch14/Ch16.

### Table 1.6. Model-only VLA vs Real VLA System

**Placement:** Section 1.7.  
**Purpose:** benchmark model과 deployable system의 차이를 설명한다.  
**Recommended format:** Word 본문에서는 axis별 bullet comparison으로 사용한다.

- **Object of analysis**
  - Model-only VLA: neural policy/model.
  - Real VLA System: full embodied stack.
- **Main metric**
  - Model-only VLA: benchmark success.
  - Real VLA System: task success + safety + recovery + reproducibility.
- **Action**
  - Model-only VLA: model output.
  - Real VLA System: controller-compatible executable object.
- **Failure handling**
  - Model-only VLA: failed episode.
  - Real VLA System: stop, recover, replan, ask human, log failure.
- **Evidence**
  - Model-only VLA: model paper and benchmark.
  - Real VLA System: data, evaluation, deployment, safety dossier.
- **Safety**
  - Model-only VLA: often external.
  - Real VLA System: cross-layer design property.

### Table 1.7. Failure Mode by Layer

**Placement:** Section 1.8.  
**Purpose:** failure가 model 내부가 아니라 layer/interface 전체에서 생긴다는 점을 보여준다.  
**Recommended format:** Word 본문에서는 layer별 bullet block으로 사용한다.

- **ER layer**
  - Representative failure: hallucinated subgoal, infeasible plan.
  - Ch1 interpretation: semantics without feasibility.
  - Defer to: Ch17.
- **VLA policy layer**
  - Representative failure: wrong action type, mode averaging, stale chunk.
  - Ch1 interpretation: action/control boundary failure.
  - Defer to: Ch13.
- **Control layer**
  - Representative failure: IK failure, force overshoot, timing jitter.
  - Ch1 interpretation: physical feasibility failure.
  - Defer to: Ch3/Ch4.
- **Data layer**
  - Representative failure: embodiment mismatch, success-only bias.
  - Ch1 interpretation: training evidence failure.
  - Defer to: Ch14.
- **Evaluation layer**
  - Representative failure: benchmark artifact, shift blindness.
  - Ch1 interpretation: capability evidence failure.
  - Defer to: Ch16.
- **Safety layer**
  - Representative failure: monitor latency, unsafe recovery.
  - Ch1 interpretation: assurance failure.
  - Defer to: Ch19.

---

## 7. Chapter 1에서 사용할 Box 후보

### Box 1.1. VLA is not a controller replacement

**Placement:** Section 1.1 or 1.2.  
**Purpose:** 책의 anti-hype message를 초반에 고정한다.  
**Contents:** VLA가 semantic policy interface이며, controller는 dynamics, timing, contact, constraints를 책임진다는 점을 짧게 정리한다.

### Box 1.2. ER layer vs VLA policy layer

**Placement:** Section 1.3 or 1.6.  
**Purpose:** Gemini Robotics-ER류를 VLA policy와 혼동하지 않도록 한다.  
**Contents:** ER output은 subgoal/plan/tool-call이고, VLA policy output은 robot action object라는 점을 비교한다.

### Box 1.3. Why action representation is a control boundary

**Placement:** Section 1.4.  
**Purpose:** Ch13으로 가는 핵심 bridge를 만든다.  
**Contents:** token, delta pose, waypoint, chunk, diffusion/flow, torque가 downstream controller burden을 어떻게 바꾸는지 5-6줄로 요약한다.

### Box 1.4. Benchmark success is not robot capability

**Placement:** Section 1.7.  
**Purpose:** Ch16의 핵심 메시지를 Ch1에서 미리 잠근다.  
**Contents:** success rate, distribution shift, latency, recovery, safety intervention, hidden assumptions를 구분한다.

### Box 1.5. Company demos as case studies, not settled science

**Placement:** Section 1.6.  
**Purpose:** 최신 ER/humanoid 사례를 균형 있게 다룬다.  
**Contents:** Tier D source는 landscape/case study로 쓰되, 일반 원리나 검증된 benchmark conclusion으로 쓰지 않는다는 원칙을 명시한다.

---

## 8. Citation Placement Plan

### Section 1.1 citation plan

- **Tier A:** A1-A4는 robotics/control vocabulary의 foundation으로 짧게 배치한다.
- **Tier B:** B18-B22로 VLM/LLM bridge와 early VLA policy의 전환을 설명한다.
- **Tier D:** D1/D2는 ER model과 VLA case를 구분하는 사례로만 사용한다.
- **주의:** Ch1 초반에 source가 너무 많아지면 survey처럼 보인다. Opening example -> claim -> representative sources 순서로 배치한다.

### Section 1.2 citation plan

- **Tier A:** A5-A6 planning, A1-A4 control references로 goal/action/control command distinction을 지지한다.
- **Tier B:** B3-B6, B10, B18, B19를 사용한다.
- **Tier D:** D1-D3는 stack pattern의 최신 사례로만 배치한다.

### Section 1.3 citation plan

- **Tier A:** A1-A8로 layer vocabulary를 지지한다.
- **Tier B/C:** B21-B24, C5-C8로 VLA policy, data/eval/safety layer의 최신 relevance를 보여준다.
- **주의:** Figure 1.1이 주된 설명 장치이고, citation은 footnote-style로 과하지 않게 둔다.

### Section 1.4 citation plan

- **Tier A/B:** B1, B3-B6, A1-A4로 observation-state/action-control distinction을 지지한다.
- **Tier B/C:** B14, B22, C1, C3, C4로 action taxonomy preview를 배치한다.
- **주의:** 수식 유도는 금지한다. `o_t`, `q_t`, `a_t`, `u_t` notation만 도입한다.

### Section 1.5 citation plan

- **Tier A/B 중심:** A1-A8, B1-B22를 사용해서 historical convergence를 만든다.
- **Tier C 제한:** C1-C5는 현대 흐름으로 넘어가는 bridge에만 사용한다.
- **주의:** chronology table이 아니라 contribution table로 쓴다.

### Section 1.6 citation plan

- **Tier B/C:** RT-1, RT-2, OpenVLA, pi0, FAST, OpenVLA-OFT, VLA Foundry를 representative system pattern으로 배치한다.
- **Tier D:** Gemini Robotics-ER, Gemini Robotics, GR00T, Helix를 case study로 배치한다.
- **주의:** 최신 시스템에 대해서는 “reported/presented as” 또는 “case study” 표현을 사용한다.

### Section 1.7 citation plan

- **Tier B/C 중심:** Open X-Embodiment, OpenVLA, Octo, DROID, VLA Foundry, vla-eval, BeTTER, ASIMOV v2, VLA safety survey.
- **Tier D:** 회사 시스템은 evaluation/safety가 필요한 deployment frontier의 예로만 사용한다.
- **주의:** safety claim은 semantic safety와 physical safety를 반드시 분리한다.

### Section 1.8 citation plan

- 새 citation을 늘리지 않는다.
- 앞 section에서 사용한 sources를 reading protocol로 재구성한다.
- Checklist 1.1은 citation보다 책의 internal framework에 의존한다.

---

## 9. Scope Control: Chapter 1에서 자세히 설명하지 말 것

### 9.1 Ch13으로 넘길 내용

- action token, continuous regression, action chunk, diffusion, flow, FAST, action expert의 상세 비교.
- action distribution의 수식적 설명.
- control frequency와 chunk horizon trade-off의 정량 분석.
- whole-body action representation의 상세 taxonomy.

**Ch1에서 할 일:** action/control boundary가 중요하다는 것만 정의한다.

### 9.2 Ch14로 넘길 내용

- Open X-Embodiment, BridgeData, DROID, ALOHA, human video, synthetic/sim data의 상세 catalog.
- embodiment normalization과 action-space alignment 방법.
- data curation, relabeling, failure data, intervention logs의 상세 pipeline.

**Ch1에서 할 일:** data engine이 Real VLA system layer라는 것만 선언한다.

### 9.3 Ch16으로 넘길 내용

- CALVIN, LIBERO, ManiSkill, Simpler, vla-eval 등의 상세 benchmark protocol.
- benchmark reproducibility, statistical uncertainty, failure taxonomy.
- real robot evaluation protocol 설계.

**Ch1에서 할 일:** benchmark score와 robot capability를 분리한다.

### 9.4 Ch19로 넘길 내용

- semantic/geometric/dynamic/system/data safety의 full taxonomy.
- runtime monitor, shield, formal verification, safety benchmark, human override의 상세 설계.
- standards나 regulation 관련 논의.

**Ch1에서 할 일:** safety가 model property가 아니라 stack property라고 선언한다.

### 9.5 Ch17/Ch18/Ch20으로 넘길 내용

- Gemini Robotics-ER류의 detailed architecture와 tool/VLA orchestration.
- real-time/on-device deployment, latency, compute, XPU, cache.
- GR00T/Helix류 humanoid/whole-body action과 WBC 상세 분석.

**Ch1에서 할 일:** 최신 system pattern을 landscape로만 소개한다.

---

## 10. Writing Order Recommendation

### 10.1 문서상 독자에게 보일 section 순서

본문의 최종 section 순서는 다음이 좋다.

1. 1.1 Why “Real VLA” Is Not Just a Bigger VLM
2. 1.2 From Language Goal to Motor Command
3. 1.3 The Five-Layer Real VLA Stack
4. 1.4 Interface Contracts: Observation, State, Action, and Control
5. 1.5 Historical Convergence: Control, Planning, Robot Learning, and VLM/LLM
6. 1.6 Modern System Patterns: Model-only VLA, ER + VLA, and Humanoid Deployment
7. 1.7 Data, Evaluation, and Safety as System Layers
8. 1.8 Failure Modes and the Roboticist’s Reading Protocol

### 10.2 실제 draft 작성 순서

실제 원고를 쓸 때는 독자 순서대로 쓰지 않는 것이 좋다. 추천 작성 순서는 다음이다.

1. **1.3 The Five-Layer Real VLA Stack**  
   이유: stack 정의가 먼저 안정되어야 1.1과 1.2의 opening이 흔들리지 않는다.
2. **1.4 Interface Contracts**  
   이유: `o_t`, `q_t`, `a_t`, `u_t` notation을 먼저 잠가야 모든 section이 같은 vocabulary를 쓴다.
3. **1.7 Data, Evaluation, and Safety as System Layers**  
   이유: hype를 막는 기준을 먼저 세워야 최신 system section이 균형을 잃지 않는다.
4. **1.1 Why Real VLA Is Not Just a Bigger VLM**  
   이유: opening section은 책의 tone을 결정하므로, 내부 정의가 잠긴 뒤 쓰는 게 좋다.
5. **1.2 From Language Goal to Motor Command**  
   이유: 1.1의 example을 stack flow로 자연스럽게 풀 수 있다.
6. **1.5 Historical Convergence**  
   이유: 이미 잠긴 stack을 기준으로 역사를 재배치하면 chronology survey로 흐르지 않는다.
7. **1.6 Modern System Patterns**  
   이유: 최신 사례는 stack/evaluation/safety 기준이 있어야 case study로 통제된다.
8. **1.8 Failure Modes and Reading Protocol**  
   이유: 마지막 section은 앞 section의 vocabulary를 모두 회수해야 한다.

### 10.3 첫 draft 작성 시 권장 산출물 단위

- Turn 1: Section 1.3 본문 draft.
- Turn 2: Section 1.4 본문 draft.
- Turn 3: Section 1.7 본문 draft.
- Turn 4: Section 1.1 본문 draft.
- Turn 5: Section 1.2 본문 draft.
- Turn 6: Section 1.5 본문 draft.
- Turn 7: Section 1.6 본문 draft.
- Turn 8: Section 1.8 본문 draft.
- Turn 9: figure/table/box insertion pass.
- Turn 10: Ch1 reviewer critique and patch plan.

---

## 11. Section 1.1 본문 작성을 위한 Next-Step Prompt

```text
Chapter 1 Detailed Outline v0.1을 기준으로
Section 1.1 “Why Real VLA Is Not Just a Bigger VLM”을 본문 원고로 작성해줘.

조건:
- 한국어 전문 원고체, ‘이다’체.
- 길이 2500-3500자.
- 본문 opening은 “Put the mug on the drying rack, but do not knock over the glass” 예제로 시작해.
- 논문 나열 금지.
- Real VLA를 단일 모델이 아니라 embodied system interface로 정의할 것.
- VLM의 semantic competence와 robot의 physical competence를 분리할 것.
- VLA hype를 경계하되, 비관적으로 쓰지는 말 것.
- 최소한 다음 reference group을 자연스럽게 녹여줘:
  - VLM/LLM bridge: SayCan, Code as Policies, PaLM-E.
  - VLA policy examples: RT-1, RT-2, OpenVLA, pi0.
  - 최신 case distinction: Gemini Robotics-ER는 ER layer, Gemini Robotics는 VLA case.
- citation은 section draft 마지막에 “Citation placeholders”로 source ID만 제시하고, 본문 중에는 과도하게 citation을 넣지 마.
- 마지막에는 Section 1.2 “From Language Goal to Motor Command”로 넘어가는 bridge 문단을 넣어.
- 핵심 문장 1개를 bold로 표시해.
```

---

## 12. Compact Reminder for Future Writing Turns

```text
Chapter 1 must define Real VLA as a system interface, not introduce every VLA paper.
It locks the stack, the action/control boundary, the data/evaluation/safety layers, and the handoff to Ch13/Ch14/Ch16/Ch19.
Do not write a survey. Write the definition layer of the book.
```
