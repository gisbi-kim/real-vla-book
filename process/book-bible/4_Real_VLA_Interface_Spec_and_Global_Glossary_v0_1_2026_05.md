# Real VLA: A Roboticist's Perspective

## Ch1-Ch13 Interface Specification + Global Glossary v0.1

**문서 목적:** Chapter 1과 Chapter 13 사이의 용어, layer boundary, action/control interface를 고정해서 이후 모든 본문 작성이 같은 API 위에서 진행되게 한다.  
**버전:** 2026.05.12  
**상태:** Working specification. 본문 원고가 아니라 원고 생성을 제어하기 위한 내부 규격 문서이다.  
**기반 산출물:** Book Bible v0.1, Wave 1 Chapter Contracts v0.1, v2 저술계획서, source corpus, chapter prologues, 초기 역사/커리큘럼 문서.

---

## 0. 이 문서가 잠그는 것

이 문서는 책 전체에서 가장 자주 흔들릴 수 있는 네 가지 경계를 고정한다.

1. **VLA policy와 Real VLA system의 경계.** VLA policy는 action-producing model/layer이고, Real VLA system은 VLA policy, reasoning, control, safety, data/evaluation이 결합된 stack이다.
2. **Embodied reasoning과 action generation의 경계.** 상위 model이 task를 쪼개고 tool/VLA를 호출할 수 있지만, 이것이 곧 low-level robot action 생성은 아니다.
3. **Policy-level action과 low-level control command의 경계.** 책 전체에서 $a_t$와 $u_t$를 분리한다.
4. **Benchmark evidence와 deployment evidence의 경계.** benchmark score는 특정 protocol의 evidence이지 robot capability 그 자체가 아니다.

### 0.1 Locked Core Thesis

> **A real VLA is not a model that replaces robotics; it is a policy interface that reorganizes control, planning, perception, language, data, and safety into one embodied system.**

한국어 본문에서는 다음 문장을 반복 thesis로 사용한다.

> **VLA는 로봇 제어이론의 대체물이 아니라, task semantics와 embodied perception을 action-generation으로 연결하는 새로운 policy interface이다.**

### 0.2 Fundamental Distinctions

| 구분 | 고정 정의 | 집필 규칙 |
| --- | --- | --- |
| VLA policy와 Real VLA system | VLA policy는 action-producing model/layer이다. Real VLA system은 VLA policy와 controller, safety, data/evaluation을 포함한 stack이다. | Ch1에서 전체 stack을 정의하고, Ch13에서는 policy output을 분석한다. |
| $a_t$와 $u_t$ | $a_t$는 policy-level action이다. $u_t$는 actuator 또는 servo-level control command이다. | “action”이라는 단어만 쓰지 말고 어떤 level의 action인지 명시한다. |
| $o_t$와 $s_t$ | $o_t$는 관측이고 $s_t$는 latent/true state이다. VLA는 주로 observation을 받지만 controller와 safety는 state estimate를 요구할 수 있다. | Ch2에서 observation-state gap을 상세화한다. |
| plan/subgoal과 action | plan이나 subgoal은 실행 의도이고, action은 특정 controller/API에 전달되는 executable object이다. | ER layer와 VLA policy layer를 구분한다. |
| benchmark score와 robot capability | score는 특정 protocol에서 생성된 evidence이다. 실제 배치 능력은 recovery, latency, safety, shift를 함께 봐야 한다. | Ch16에서 평가 기준으로 확장한다. |
| semantic safety와 physical safety | 위험한 명령을 거절하는 능력과 collision/force/latency를 제어하는 능력은 다르다. | Ch19에서 safety taxonomy로 확장한다. |



### 0.3 Minimal Operating Rule

이 문서 이후 어떤 section을 쓰더라도 다음 세 질문에 답해야 한다.

1. 이 내용은 Real VLA stack의 어느 interface를 설명하는가?
2. 이 내용에서 말하는 action은 어떤 action type인가?
3. 이 claim은 data/evaluation/safety layer에서 어떻게 검증되거나 실패하는가?

---

## 1. Real VLA System Stack Specification

### 1.1 Stack Definition

Real VLA system은 단일 neural network가 아니라, 언어적 목표가 물리적 실행으로 변환되는 stack이다. 이 stack은 실제 구현에서 하나의 모델이나 하나의 코드베이스에 합쳐질 수 있지만, 책에서는 책임 경계를 분리해서 설명한다. 구현이 통합되어도 책임은 통합되지 않는다.

| Layer | Input | Output | Responsibility Boundary |
| --- | --- | --- | --- |
| Embodied Reasoning Layer | observation, instruction, memory, scene context | subgoal, plan, constraint, tool/VLA call | 무엇을 해야 하는가를 결정한다. 직접 motor command를 보장하지 않는다. |
| VLA Policy Layer | observation, proprioception, instruction/subgoal, short memory | policy-level action object: token, vector, waypoint, chunk, distribution | 무슨 action을 제안할지 결정한다. 물리 feasibility와 safety guarantee를 단독 책임지지 않는다. |
| Motion/Control Layer | policy-level action, robot state, constraints | trajectory, servo command, torque/velocity/position target | 제안된 action을 로봇이 추적 가능한 물리 명령으로 변환한다. |
| Safety/Assurance Layer | instruction, plan, action, state, environment, monitor signal | allow, modify, stop, recover, ask human | semantic, geometric, dynamic, runtime safety를 stack property로 관리한다. |
| Data/Evaluation Layer | trajectories, failures, labels, logs, protocols | dataset, metrics, regression tests, evidence | 성능 주장의 근거와 다음 학습/수정 loop를 만든다. |



### 1.2 Layer-Merging Rule

현대 시스템은 ER, VLA policy, controller wrapper, safety filter를 하나의 service로 묶을 수 있다. 그래도 원고에서는 다음 규칙을 따른다.

- 하나의 모델이 여러 layer를 구현할 수는 있다.
- 하지만 한 layer의 success가 다른 layer의 guarantee를 의미하지 않는다.
- 모델이 action을 직접 출력하더라도 controller, monitor, safety envelope의 책임은 사라지지 않는다.
- 회사 시스템이나 demo를 설명할 때는 “어떤 layer까지 직접 구현했는가”와 “어떤 layer는 external wrapper나 robot stack에 맡겼는가”를 분리한다.

### 1.3 Stack Flow

기본 실행 loop는 다음과 같이 서술한다.

```text
observation + instruction
    -> embodied reasoning: task state, subgoal, plan, constraints
    -> VLA policy: policy-level action proposal
    -> safety gate: allow / modify / stop / ask human
    -> motion/control: trajectory or servo-level command
    -> robot/environment: physical execution
    -> sensors/logs: feedback, failure, intervention, evaluation evidence
    -> data engine: curation, retraining, regression test
```

이 flow는 반드시 순차 pipeline일 필요는 없다. 실제 구현에서는 asynchronous execution, parallel monitoring, hierarchical feedback이 존재한다. 그러나 책의 설명에서는 이 flow를 기본 mental model로 사용한다.

---

## 2. Layer-by-Layer Interface Contract

### 2.1 Embodied Reasoning Layer

**Operational definition.** Embodied reasoning layer는 scene, instruction, memory, task history를 이용해 무엇을 해야 하는지 결정하고, 필요한 경우 subgoal, plan, tool call, VLA call, controller call을 만든다. 이 layer는 language/world knowledge를 물리 task structure로 바꾸는 역할을 한다.

**Canonical input.** $o_t$, $l$, $m_t$, optional scene graph, optional state estimate $\hat{s}_t$, task history.  
**Canonical output.** $g_t$, $P_t$, skill call $\kappa_i(args)$, VLA call, constraint set $\mathcal{C}_t$, progress/success estimate.

**Responsible for:**

- task decomposition과 subgoal proposal.
- scene relation과 object affordance에 대한 semantic/spatial reasoning.
- tool, skill, VLA, controller를 언제 호출할지 결정.
- unsafe/ambiguous instruction을 감지하고 clarification 또는 escalation을 제안.

**Not responsible for:**

- low-level stability guarantee.
- collision-free trajectory guarantee.
- torque/force/speed bound enforcement.
- benchmark score를 robot capability로 해석하는 일.

**Interface contract.** ER layer가 VLA policy layer에 넘기는 것은 “do something”이 아니라, 가능한 한 explicit한 subgoal/context/constraint bundle이어야 한다.

```text
ER output bundle:
  subgoal: semantic or spatial target
  constraints: forbidden regions, object constraints, human proximity constraints
  success condition: how to judge progress
  allowed tools/policies: VLA, skill, planner, controller
  uncertainty: unknowns or clarification needs
```

**Common failures.** semantic hallucination, infeasible subgoal, missing precondition, unsafe ambiguity, overconfident success detection.

### 2.2 VLA Policy Layer

**Operational definition.** VLA policy layer는 observation, language/subgoal, proprioception, short memory를 받아 robot-executable action object를 제안하는 learned policy layer이다. 이 layer는 책에서 “VLA”라는 단어가 가장 좁은 의미로 쓰이는 위치이다.

**Canonical input.** $o_t$, $q_t$ 또는 $x_t$, $l$ 또는 $g_t$, $m_t$, optional constraints.  
**Canonical output.** $a_t$, $A_t^{(H)}$, waypoint, delta pose, action token, action distribution, action expert output.

**Responsible for:**

- visual/language-conditioned action proposal.
- task semantics를 robot action interface로 변환.
- short-horizon temporal consistency 또는 action chunk generation.
- learned affordance/action prior 제공.

**Not responsible for:**

- 모든 geometric feasibility 보장.
- 모든 dynamic safety 보장.
- high-frequency servo loop 대체.
- failure recovery 전체 설계.

**Interface contract.** VLA policy output은 반드시 action type, frame convention, frequency, horizon, scaling, downstream controller를 명시해야 한다.

```text
VLA action object:
  type: token | vector | waypoint | delta_pose | chunk | distribution | skill_call
  frame: world | robot_base | end_effector | joint | normalized
  rate: f_VLA
  horizon: H if chunked
  controller: expected downstream controller
  validity: confidence, constraints, mask, uncertainty if available
```

**Common failures.** action granularity mismatch, quantization loss, mode averaging, controller mismatch, latency-control mismatch, embodiment mismatch.

### 2.3 Motion/Control Layer

**Operational definition.** Motion/control layer는 policy-level action이나 target을 물리적으로 추적 가능한 trajectory, servo command, torque/velocity/position command로 변환한다. classical robotics가 이 layer의 중심이다.

**Canonical input.** $a_t$ 또는 $A_t^{(H)}$, controller reference $r_t$, robot state $x_t$, constraints $\mathcal{C}_t$.  
**Canonical output.** trajectory $\tau$, controller reference sequence $r_{t:t+H}$, low-level command $u_t$.

**Responsible for:**

- kinematic/dynamic feasibility.
- trajectory tracking, impedance, operational space control, MPC, WBC.
- control frequency와 actuator interface 처리.
- local constraint satisfaction과 saturation handling.

**Not responsible for:**

- instruction semantics 이해.
- task-level goal decomposition.
- dataset/evaluation claim의 정당화.
- model hallucination 자체의 해결.

**Interface contract.** controller는 VLA output을 그대로 실행하는 executor가 아니라, robot state와 constraints를 보고 action proposal을 물리적으로 해석하는 layer이다.

```text
control translation:
  r_t = Interpret(a_t, x_t, robot_model, frame_convention)
  u_t = Controller(r_t, x_t, constraints, gains, limits)
```

**Common failures.** infeasible waypoint, IK failure, force overshoot, unexpected contact, timing jitter, action scaling mismatch.

### 2.4 Safety/Assurance Layer

**Operational definition.** Safety/assurance layer는 instruction, plan, policy output, controller command, runtime state, data log 전반에 걸쳐 위험을 감지하고 allow/modify/stop/recover/ask-human 결정을 내리는 cross-cutting layer이다.

**Canonical input.** $l$, $P_t$, $g_t$, $a_t$, $u_t$, $x_t$, $o_t$, monitor signal $M_t$, constraints $\mathcal{C}_t$.  
**Canonical output.** allow, modified action $\tilde{a}_t$, modified command $\tilde{u}_t$, stop, recovery action, human escalation, safety log.

**Responsible for:**

- semantic safety: unsafe/ambiguous instruction filtering.
- geometric safety: collision, workspace, self-collision, human proximity.
- dynamic safety: force, speed, torque, stability, contact.
- runtime assurance: anomaly monitoring, recovery, E-stop.
- data safety: unsafe demonstration filtering, failure event logging.

**Not responsible for:**

- 모델 성능을 대신 만드는 일.
- benchmark score를 자동으로 높이는 일.
- 모든 hazard를 single wrapper로 해결하는 일.

**Interface contract.** safety layer는 여러 위치에 붙을 수 있다. 중요한 것은 “어디에 붙는가”보다 “무엇을 보고 어느 시간 안에 어떤 권한으로 개입하는가”이다.

```text
shielded action:
  \tilde a_t = Shield(a_t, x_t, o_t, C_t, monitor_state)
  decision in {allow, modify, stop, recover, ask_human}
```

**Common failures.** semantic filtering만 하고 physical safety를 놓침, monitor latency, safety shield가 action type을 해석하지 못함, recovery behavior가 더 위험함, human oversight 과신.

### 2.5 Data/Evaluation Layer

**Operational definition.** Data/evaluation layer는 VLA system이 무엇을 학습했고 무엇을 증명했는지 만드는 evidence layer이다. 이 layer는 dataset, labels, logs, benchmark protocol, metric, regression test, deployment evidence를 포함한다.

**Canonical input.** demonstrations, failures, intervention logs, sim logs, robot metadata, action labels, evaluation protocols.  
**Canonical output.** curated dataset $\mathcal{D}$, normalization statistics, benchmark reports, safety/evaluation evidence, regression tests.

**Responsible for:**

- data collection, relabeling, filtering, normalization.
- train/evaluation split과 contamination 관리.
- protocol documentation과 metric definition.
- deployment logs를 다음 data/fine-tuning loop로 연결.

**Not responsible for:**

- poor action interface를 자동으로 해결하는 일.
- hidden controller/safety wrapper를 무시한 model comparison.
- benchmark score를 실제 deployment guarantee로 바꾸는 일.

**Interface contract.** data/evaluation layer는 action representation과 controller boundary를 metadata로 보존해야 한다.

```text
data record:
  observation, instruction, robot_state, action_type, action_value,
  controller_type, control_rate, VLA_rate, success/failure,
  intervention, safety_event, normalization_stats
```

**Common failures.** dataset-size illusion, action normalization leakage, success-only bias, hidden human intervention, protocol under-specification.

---

## 3. Ch1-Ch13 Boundary Specification

### 3.1 Division of Responsibility

Ch1은 “Real VLA system이 무엇인가”를 정의한다. Ch13은 “그 system 안에서 VLA policy output이 어떤 action representation으로 motion/control layer와 만나는가”를 정의한다. 같은 용어를 반복하더라도 depth가 다르다.

| 주제 | Ch1에서 할 일 | Ch13에서 할 일 |
| --- | --- | --- |
| VLA의 정의 | Real VLA system과 VLA policy layer를 구분해서 정의한다. | 정의된 VLA policy layer의 output taxonomy를 상세화한다. |
| Stack diagram | ER -> VLA -> Control -> Safety -> Robot -> Data loop를 보여준다. | stack 중 VLA-Control boundary를 확대한다. |
| Action이라는 단어 | 넓은 의미의 executable output으로 소개하되 모호함을 경고한다. | action token/vector/waypoint/chunk/distribution 등으로 분해한다. |
| Controller | VLA가 controller를 대체하지 않는다고 선언한다. | 어떤 action representation이 어떤 controller와 맞는지 분석한다. |
| Safety | safety는 stack property라고 선언한다. | safety shield가 해석할 수 있는 action type을 분석한다. |
| Data/evaluation | data와 evaluation이 system layer임을 소개한다. | action label, frequency, normalization이 data/eval에 미치는 영향을 넘겨준다. |



### 3.2 Ch1에서 먼저 설명할 것

Ch1은 다음을 첫 정의로 고정한다.

- Real VLA system vs VLA policy layer.
- ER layer, VLA policy layer, motion/control layer, safety/assurance layer, data/evaluation layer.
- observation/state/action/controller/evaluation/safety라는 기본 vocabulary.
- benchmark VLA와 real VLA의 차이.
- VLA paper를 읽는 여섯 질문: backbone, action, data, control interface, evaluation, safety.

Ch1은 action token, diffusion, flow, FAST, OpenVLA-OFT 같은 세부 action representation을 깊게 설명하지 않는다. 그것들은 Ch13으로 넘긴다.

### 3.3 Ch13에서 Ch1을 참조하는 방식

Ch13은 첫 section에서 Ch1의 stack diagram을 다시 불러오고, 그중 VLA policy layer와 motion/control layer 사이를 확대한다. Ch13의 첫 문장은 다음 방향이어야 한다.

> Ch1이 Real VLA system의 전체 stack을 정의했다면, 이 장은 그 stack에서 가장 중요한 API인 action representation을 정의한다.

Ch13은 모든 action type을 다음 질문으로 평가한다.

1. 이 action은 어떤 controller가 해석할 수 있는가?
2. 이 action은 어떤 frequency와 horizon을 갖는가?
3. 이 action은 어떤 data label과 normalization을 요구하는가?
4. 이 action은 safety shield가 해석할 수 있는가?
5. 이 action은 recovery와 evaluation을 쉽게 하는가, 어렵게 하는가?

---

## 4. Notation and Variable Discipline

### 4.1 Core Notation Table

| Symbol | Name | Operational Meaning | Primary Chapters |
| --- | --- | --- | --- |
| $t$ | time index | 모든 closed-loop 변수의 시간 index이다. | 전체 |
| $o_t$ | observation | image, depth, tactile, audio, proprioceptive reading 등 센서 관측이다. state와 동일시하지 않는다. | Ch1, Ch2, Ch13 |
| $s_t$ | latent/true state | 환경과 로봇의 실제 상태이다. 대개 직접 관측되지 않는다. | Ch2 |
| $\hat{s}_t$ 또는 $b_t$ | state estimate / belief | estimator가 만든 상태 추정 또는 belief이다. safety/control layer가 필요로 한다. | Ch2, Ch19 |
| $x_t$ | robot state vector | joint position/velocity, base pose, end-effector pose 등 robot-centric state이다. | Ch2, Ch3 |
| $q_t$ | configuration / proprioception | joint configuration 또는 proprioceptive vector이다. | Ch2, Ch13 |
| $l$ | language instruction | 사용자 명령 또는 task text이다. | Ch1, Ch9, Ch10 |
| $g_t$ | goal or subgoal | ER/planning layer가 VLA policy나 controller에 전달하는 목표 상태 또는 semantic target이다. | Ch1, Ch17 |
| $P_t$ | plan | subgoal 또는 skill sequence이다. 직접 motor command가 아니다. | Ch5, Ch10, Ch17 |
| $m_t$ | memory | short-term history, episodic state, task progress, tool state를 포함한다. | Ch1, Ch17 |
| $c_t$ 또는 $\mathcal{C}_t$ | constraints | workspace, collision, speed, force, task precondition 등 제약이다. | Ch5, Ch19 |
| $a_t$ | policy-level action | VLA policy가 내는 executable proposal이다. token, vector, waypoint, delta pose, chunk member가 될 수 있다. | Ch13 |
| $A_t^{(H)}$ | action chunk | $H$ step action sequence이다. $A_t^{(H)}=(a_t, ..., a_{t+H-1})$로 쓴다. | Ch13 |
| $y_t$ | raw model output | logits, tokens, normalized vector 등 decoding 전후의 모델 출력이다. 필요한 경우만 사용한다. | Ch13, Ch15 |
| $r_t$ | controller reference | controller가 추적할 target이다. waypoint, pose, trajectory segment가 될 수 있다. | Ch3, Ch13 |
| $\tau$ | trajectory | state-action sequence 또는 path/trajectory이다. action chunk와 혼동하지 않는다. | Ch5, Ch13 |
| $u_t$ | low-level control input | torque, velocity command, position target, motor command이다. | Ch3, Ch18 |
| $\pi_\theta$ | learned policy | VLA policy 또는 lower-level learned policy이다. | Ch6-Ch15 |
| $\mathcal{D}$ | dataset | demonstration, sim, failure, deployment logs를 포함한다. | Ch14 |
| $\mathcal{S}$ | safety set | 허용되는 state/action 영역이다. | Ch19 |
| $M_t$ | monitor signal | runtime monitor가 만든 risk, anomaly, intervention signal이다. | Ch19 |



### 4.2 Canonical Equations for the Book

이 책의 수식은 증명보다 interface를 명확히 하기 위해 사용한다. 아래 수식들은 각 장에서 변형될 수 있지만 notation discipline은 유지한다.

**Embodied reasoning interface.**

```text
(g_t, P_t, C_t) = ER(o_{<=t}, l, m_t, optional belief/state)
```

이 식은 ER layer가 직접 torque를 내는 것이 아니라 subgoal, plan, constraint를 만든다는 점을 보이기 위한 식이다.

**VLA policy interface.**

```text
a_t ~ pi_theta(. | o_{<=t}, q_{<=t}, l or g_t, m_t)
```

여기서 $a_t$는 low-level command가 아니라 policy-level action object이다. Ch13에서는 이 $a_t$의 type을 상세히 분해한다.

**Action chunk interface.**

```text
A_t^(H) = (a_t, a_{t+1}, ..., a_{t+H-1}) ~ pi_theta(. | o_{<=t}, l or g_t)
```

$H$는 action horizon이고, $f_{VLA}$와 $f_{ctrl}$을 구분해서 써야 한다.

**Control translation.**

```text
r_t = Interpret(a_t, x_t, robot_model, frame)
u_t = Controller(r_t, x_t, C_t, limits)
```

이 식은 VLA action과 actuator command 사이에 controller interpretation이 있음을 강조한다.

**Runtime shielding.**

```text
\tilde a_t = Shield(a_t, x_t, o_t, C_t, M_t)
decision in {allow, modify, stop, recover, ask_human}
```

shield가 항상 action-level에만 붙는 것은 아니다. instruction, plan, controller command, data log에도 붙을 수 있다.

### 4.3 Naming Rules

- $a_t$는 policy-level action으로 예약한다.
- $u_t$는 low-level command로 예약한다.
- $r_t$는 controller reference로 예약한다.
- $A_t^{(H)}$는 action chunk로 예약한다.
- “trajectory”는 $\tau$ 또는 $r_{t:t+H}$로 쓰고, action chunk와 혼동하지 않는다.
- “state”를 말할 때는 true state $s_t$, state estimate $\hat{s}_t$, robot state $x_t$, observation $o_t$ 중 무엇인지 명시한다.
- “policy”는 VLA policy, skill policy, controller policy 중 무엇인지 명시한다.

---

## 5. Ch13 Action Representation Taxonomy

### 5.1 Taxonomy Table

| Type | Definition | Notation | Downstream Interface | Strength | Main Failure |
| --- | --- | --- | --- | --- | --- |
| Action token | discrete token 또는 token sequence로 표현한 action | $a_t \in V$ | RT-style VLM/LLM pipeline, token decoding | VLM pretraining과 잘 맞음 | quantization, latency, 고주파 제어 한계 |
| Continuous action vector | 실수 벡터로 표현한 position/velocity/delta command | $a_t \in \mathbb{R}^d$ | servo, OSC, impedance, action wrapper | controller와 직접 연결하기 쉬움 | scale/normalization, mode averaging, saturation |
| Waypoint | controller/planner가 향해야 할 중간 목표 | $r_t=(p,R)$ 또는 pose target | IK, motion planner, MPC | feasibility check와 결합 쉬움 | waypoint가 곧 trajectory는 아님 |
| Delta pose | 현재 end-effector pose 기준 상대 pose command | $\Delta T_t$ | Cartesian servo, OSC, impedance | manipulation에서 흔한 interface | frame convention 오류, 누적 drift |
| Trajectory target | 짧은 path/trajectory segment 또는 reference sequence | $r_{t:t+H}$ | MPC, trajectory tracker | smoothness/constraint 반영 가능 | planning cost와 latency 증가 |
| Action chunk | 여러 step action을 한 번에 예측한 sequence | $A_t^{(H)}$ | chunk executor, low-level tracker | temporal consistency, compounding error 완화 | recovery granularity 저하, chunk inertia |
| Action distribution | single action이 아니라 확률분포로 표현한 output | $p_\theta(A\|o,l)$ | sampling, diffusion/flow head | multimodal behavior 표현 가능 | sampling cost, safety 검증 난이도 |
| Action tokenizer / compression | continuous trajectory를 discrete/compact token으로 압축 | $z=\mathrm{Tok}(A)$ | VLA token decoder, post-decoder | LLM-style 학습과 sequence 효율성 | physical frequency structure 손실 가능 |
| Action expert | VLM backbone과 분리된 continuous action 생성 head | $A=f_\phi(h_{vlm},o,q)$ | flow/diffusion/expert decoder | semantic backbone과 motor head 분리 | head-controller mismatch, fine-tuning burden |
| Skill call | 미리 정의된 skill/policy/tool을 호출하는 symbolic executable | $\kappa_i(args)$ | skill library, planner, ER orchestrator | long-horizon 구조화에 유리 | Ch13 핵심 action보다는 Ch17 hierarchy에 가깝다 |
| Torque/velocity/position command | actuator 또는 servo-level command | $u_t$ | motor controller, robot driver | low-level precision | VLA가 직접 내면 safety/latency/stability 부담이 큼 |
| Whole-body action | base, torso, arms, head, hands, balance를 포함하는 고차원 action | $a_t^{wb}$ | WBC, humanoid controller | humanoid/generalist policy에 필요 | balance, contact, self-collision, safety envelope 복잡 |



### 5.2 Inclusion Rule for Skill Calls

Skill call은 넓은 의미의 executable output이므로 Ch1에서는 VLA/ER stack의 가능한 output으로 소개할 수 있다. 그러나 Ch13의 중심은 robot control action representation이다. 따라서 skill call은 다음과 같이 처리한다.

- Ch1: broad executable output의 한 예로 언급한다.
- Ch13: action taxonomy의 boundary case로 짧게 다룬다.
- Ch17: ER + VLA + skill library hierarchy의 핵심으로 상세화한다.

### 5.3 Direct Torque Output Rule

VLA가 torque를 직접 출력하는 형태는 이론적으로 action representation에 포함된다. 그러나 책에서는 이를 기본값으로 두지 않는다. direct torque VLA는 다음 조건이 충족될 때만 serious deployment option으로 논의한다.

- inference latency가 control loop 요구사항과 맞는다.
- dynamic safety filter 또는 low-level stabilizing controller가 존재한다.
- force/torque limit, contact, saturation, emergency stop이 명확하다.
- training data가 torque-level behavior를 충분히 설명한다.

그렇지 않으면 torque output은 Ch13에서 “가능하지만 매우 높은 assurance burden을 갖는 interface”로 다룬다.

### 5.4 Action Representation Spectrum

Ch13의 기본 conceptual spectrum은 다음 순서이다.

```text
symbolic/semantic output
  -> skill call
  -> waypoint / object target
  -> end-effector delta pose
  -> continuous action vector
  -> action chunk
  -> action distribution via diffusion/flow
  -> low-level velocity/torque command
  -> whole-body action
```

이 spectrum은 “왼쪽이 좋고 오른쪽이 나쁘다”는 순위가 아니다. 왼쪽으로 갈수록 semantic abstraction이 크고, 오른쪽으로 갈수록 physical responsibility가 커진다. 좋은 interface는 task, robot, data, controller, latency, safety envelope에 따라 달라진다.

---

## 6. Control Boundary Decision Rules

### 6.1 Choosing the Boundary

Action representation을 고르는 것은 model architecture 선택이 아니라 control boundary 선택이다. 다음 질문에 답한 뒤 action type을 정한다.

1. robot이 이미 안정적인 controller를 갖고 있는가?
2. task가 contact-rich인가, free-space motion 중심인가?
3. VLA inference frequency가 control frequency보다 얼마나 느린가?
4. 실패했을 때 바로 interrupt/recover해야 하는가?
5. dataset action label은 어떤 control mode로 기록되어 있는가?
6. safety shield가 어떤 action type을 해석할 수 있는가?
7. multi-embodiment transfer가 필요한가?

### 6.2 Design Matrix

| Task / Embodiment | Preferred Representation | Downstream Control | Safety/Evaluation Focus |
| --- | --- | --- | --- |
| Tabletop pick-and-place | delta pose, waypoint, short action chunk | OSC, impedance, IK, motion planner | collision, grasp failure, pose tracking, recovery |
| Bimanual manipulation | action chunk, continuous vector, diffusion/flow distribution | dual-arm controller, impedance, synchronized execution | coordination, chunk interruption, contact force |
| Dexterous/contact-rich manipulation | diffusion/flow action distribution, tactile-conditioned chunk | impedance/admittance, contact monitor | force, slip, multimodal action, latency |
| Mobile manipulation | subgoal + waypoint + local action chunk | navigation stack, MPC, arm controller | base-arm coordination, obstacle/human proximity |
| Humanoid whole-body task | whole-body reference/action, skill hierarchy, WBC target | WBC, balance controller, locomotion controller | fall, self-collision, human proximity, recovery |
| High-risk human-proximity task | conservative waypoint/skill call with strong shield | verified planner/controller, low speed/force limits | intervention, E-stop, safety case, audit log |



### 6.3 Boundary Anti-patterns

- **Semantic shortcut:** VLA가 object와 instruction을 잘 해석했으므로 physical action도 안전할 것이라고 가정한다.
- **Controller invisibility:** paper/system description에서 controller type, gains, rate, wrapper가 빠진다.
- **Action ambiguity:** “continuous action”이라고만 쓰고 pose, velocity, joint target, normalized vector 중 무엇인지 말하지 않는다.
- **Frequency collapse:** VLA update rate와 control loop rate를 같은 것으로 취급한다.
- **Safety-afterthought:** safety filter가 어떤 variable을 보고 어떤 시간 안에 개입하는지 명시하지 않는다.

---

## 7. Safety and Evaluation Attachment Points

### 7.1 Safety Gates

| Gate | Input | Risk Checked | Possible Decision | Primary Chapters |
| --- | --- | --- | --- | --- |
| Instruction gate | 사용자 명령 $l$ | 위험한 goal, 금지 task, 모호한 요청 | reject, clarify, escalate | Ch1, Ch19 |
| Planning gate | plan/subgoal $P_t, g_t$ | 실행 불가능한 순서, precondition 위반, 위험한 subgoal | replan, constrain, ask human | Ch5, Ch17, Ch19 |
| Policy-output gate | VLA action $a_t$ 또는 $A_t^{(H)}$ | workspace violation, speed/force risk, invalid action type | clip, project, stop | Ch13, Ch19 |
| Control gate | controller reference $r_t$ 또는 command $u_t$ | joint limit, collision, torque/speed saturation | MPC/CBF/shield, impedance limit | Ch3, Ch4, Ch19 |
| Runtime monitor | execution trace, sensor feedback | unexpected contact, slip, loss of tracking, anomaly | pause, recover, E-stop | Ch18, Ch19 |
| Data gate | trajectory/failure logs | unsafe demonstration, hidden shortcut, privacy risk | filter, relabel, quarantine | Ch14, Ch19 |



### 7.2 Evaluation Metrics by Action Type

| Action Type | Minimum Additional Metrics | Interpretation Caution |
| --- | --- | --- |
| Action token | decoding latency, invalid token rate, action discretization granularity, success/failure taxonomy | token confidence만으로 safety를 주장하지 않는다. |
| Continuous vector | scale/normalization report, control frequency, saturation rate, smoothness, tracking error | mean action error만으로 task success를 대체하지 않는다. |
| Waypoint/delta pose | IK feasibility, collision-free rate, pose tracking error, recovery after infeasible target | waypoint가 motion plan을 보장하지 않는다. |
| Action chunk | chunk horizon $H$, update frequency, interruption/recovery latency, chunk smoothness | long chunk success와 fast recovery는 trade-off가 있다. |
| Diffusion/flow distribution | sampling count/time, multimodality, mode collapse, action variance, safety projection rate | sampling diversity가 안전성을 의미하지 않는다. |
| Whole-body action | balance, self-collision, contact stability, human proximity, fall/recovery metric | manipulation success만으로 humanoid safety를 말하지 않는다. |



### 7.3 Evaluation Reporting Rule

VLA 논문 또는 시스템을 책에서 설명할 때, 다음 항목 중 누락된 것이 있으면 “reported capability”를 약하게 표현한다.

```text
Minimum action/evaluation report:
  robot embodiment
  action representation
  action frequency / VLA inference frequency
  downstream controller
  normalization statistics or wrapper
  safety shield or intervention rule
  trial count and randomization
  failure taxonomy
  human intervention and reset policy
```

---

## 8. How Ch14, Ch16, and Ch19 Must Use This Spec

### 8.1 Chapter 14 Data Engines

Ch14는 이 spec을 사용해 dataset을 단순 trajectory 묶음이 아니라 action/control/evaluation metadata가 붙은 system evidence로 설명한다.

| Reference Point | Ch14 Writing Rule | Target Section |
| --- | --- | --- |
| Action label typing | dataset card에는 action이 token/vector/waypoint/chunk/torque 중 무엇인지 명시한다. | Ch14.3, Ch14.7 |
| Embodiment-aware normalization | robot, gripper, action channel별 normalization statistic을 분리한다. | Ch14.3 |
| Control frequency metadata | demonstration sampling rate와 controller loop rate를 함께 기록한다. | Ch14.2, Ch14.8 |
| Failure and intervention labels | failed rollout, near miss, human intervention, recovery action을 별도 label로 남긴다. | Ch14.6 |
| Language-action alignment | instruction이 action label과 어떤 temporal segment에 대응하는지 기록한다. | Ch14.4 |



### 8.2 Chapter 16 Evaluation and Benchmarking

Ch16은 action representation이 evaluation protocol을 어떻게 바꾸는지 보여줘야 한다. success rate만 쓰면 Ch13의 action API가 사라진다.

| Reference Point | Ch16 Writing Rule | Target Section |
| --- | --- | --- |
| Minimum reporting | robot, controller, action representation, VLA inference rate, control rate, trial count를 보고한다. | Ch16.7 |
| Metric dependency | success rate 외에 action-type별 metric을 붙인다. | Ch16.4 |
| Protocol variables | reset, object placement, camera pose, prompt, termination condition을 명시한다. | Ch16.3 |
| Reproducibility | normalization, wrapper, safety shield, human intervention rule을 공개한다. | Ch16.5 |
| Diagnostic shift | spatial layout, distractor, temporal extrapolation, causal intervention을 별도 평가한다. | Ch16.6 |



### 8.3 Chapter 19 Safety and Assurance

Ch19는 safety를 VLA model property가 아니라 action/state/control interface를 감시하는 stack property로 설명한다.

| Reference Point | Ch19 Writing Rule | Target Section |
| --- | --- | --- |
| Safety shield input | shield가 해석할 수 있는 action type과 state estimate를 먼저 정의한다. | Ch19.5 |
| Semantic vs physical safety | ER의 instruction filtering과 controller-level safety를 분리한다. | Ch19.2-Ch19.4 |
| Runtime timing | monitor latency가 VLA inference/control frequency보다 충분히 빠른지 보고한다. | Ch19.5 |
| Recovery policy | stop/retry/replan/ask human 중 어떤 권한이 어디에 있는지 정의한다. | Ch19.5, Ch19.8 |
| Safety data loop | unsafe/failure event가 data engine에 어떻게 들어가는지 정의한다. | Ch19.6 |



---

## 9. Figure and Table Specifications

### 9.1 Figure 1: Real VLA System Stack

**Purpose.** 책 전체의 첫 conceptual figure. Ch1에서 사용하고 이후 모든 Wave 1 장이 참조한다.

**Visual structure.** 왼쪽에서 오른쪽으로 instruction/observation이 들어오고, ER layer가 subgoal/plan/constraints를 만든다. VLA policy layer는 policy-level action을 제안한다. Motion/control layer는 trajectory 또는 low-level command를 만든다. Robot/environment가 실행하고 sensor feedback이 다시 들어온다. Safety/assurance layer는 instruction, plan, action, control, runtime 모두에 걸쳐 cross-cutting guard로 표시한다. Data/evaluation layer는 아래쪽 loop로 collect-curate-train-evaluate-deploy-log를 형성한다.

**Caption draft.**  
*A real VLA system separates semantic reasoning, action generation, physical control, safety assurance, and data/evaluation evidence, even when some layers are implemented by a single model or service.*

### 9.2 Figure 2: Action Interface Spectrum

**Purpose.** Ch13의 첫 figure. action representation을 model output format이 아니라 control boundary spectrum으로 보여준다.

**Visual structure.** 왼쪽에는 semantic output/skill call, 중간에는 waypoint/delta pose/continuous vector/action chunk, 오른쪽에는 diffusion/flow distribution, low-level command, whole-body action을 배치한다. 아래에는 abstraction, controller burden, safety burden, latency sensitivity가 어떻게 변하는지 표시한다.

**Caption draft.**  
*Action representation is the contract between semantic policy learning and physical control; moving along the spectrum changes not only the output format but also the burden placed on controllers, safety shields, data labels, and evaluation protocols.*

### 9.3 Figure 3: Runtime Assurance Gates

**Purpose.** Ch19에서 사용하되 Ch1에서 간단히 예고한다.

**Visual structure.** instruction gate, planning gate, policy-output gate, control gate, runtime monitor, data gate를 순서대로 배치한다. 각 gate는 reject/modify/stop/recover/ask-human 권한을 가진다.

**Caption draft.**  
*Safety cannot be delegated to a single model output filter; runtime assurance requires multiple gates attached to instruction, plan, action, control, execution, and data loops.*

### 9.4 Required Tables

| Table ID | Title | Primary Chapter | Reuse Chapters |
| --- | --- | --- | --- |
| T1 | Real VLA stack layer table | Ch1 | Ch13, Ch14, Ch16, Ch19 |
| T2 | Ch1 vs Ch13 responsibility boundary | Ch1 / Ch13 | Book Bible updates |
| T3 | Action representation taxonomy | Ch13 | Ch3, Ch14, Ch16, Ch19, Ch20 |
| T4 | Safety gates by interface point | Ch19 | Ch1, Ch13, Ch16 |
| T5 | Evaluation metrics by action type | Ch16 | Ch13, Ch18, Ch20 |
| T6 | Global glossary | Book-level appendix | All chapters |



---

## 10. Ambiguous Expressions and Replacement Rules

| Avoid | Use Instead | Reason |
| --- | --- | --- |
| “VLA가 로봇을 직접 제어한다” | “VLA policy가 [action type]을 제안하고, [controller]가 이를 추적한다” | controller boundary를 보이지 않게 만든다. |
| “ER 모델은 VLA다” | “ER model은 embodied reasoning/orchestration layer이고, action-producing VLA와 구분한다” | reasoning과 action generation을 혼동한다. |
| “action을 출력한다” | “action token / delta pose / waypoint / action chunk / torque command를 출력한다” | action level이 모호하다. |
| “모델이 scene을 이해한다” | “모델이 특정 benchmark/protocol에서 scene relation을 추론했다” | understanding claim을 과장한다. |
| “안전한 VLA” | “특정 safety layer와 protocol 아래에서 hazard를 줄인 VLA system” | safety를 model attribute로 과잉 단순화한다. |
| “SOTA라서 중요하다” | “이 시스템은 [interface/action/data/eval/safety] 관점에서 중요한 설계 선택을 보인다” | 책의 conceptual lens가 사라진다. |



### 10.1 Hype Filter for Interface Claims

- “generalist”를 쓸 때는 task/embodiment/evaluation scope를 함께 쓴다.
- “embodied reasoning”을 쓸 때는 action generation과 구분한다.
- “real-time”을 쓸 때는 VLA inference frequency와 controller frequency를 분리한다.
- “safe”를 쓸 때는 semantic/geometric/dynamic/system/data safety 중 무엇인지 명시한다.
- “open-source”를 쓸 때는 code, weights, dataset, evaluation script 중 무엇이 공개되었는지 구분한다.

---

## 11. Global Glossary v0.1

이 glossary는 책 전체의 첫 working version이다. 이후 각 장을 쓰면서 term을 추가하되, 아래 정의와 충돌하면 Interface Spec 또는 Book Bible을 업데이트해야 한다.

| Term | Definition in This Book | Distinguish From | First Definition |
| --- | --- | --- | --- |
| Real VLA System | VLA policy, controller, safety, data/evaluation layer가 함께 묶인 실제 로봇 시스템 | VLA policy 단독과 구분 | Ch1 |
| VLA | vision-language-action model 또는 policy layer. 시각/언어 조건에서 robot-executable output을 낸다. | pure VLM, pure planner와 구분 | Ch1, Ch13 |
| VLA Policy Layer | observation/instruction/proprioception을 받아 policy-level action을 제안하는 layer | motion/control layer와 구분 | Ch1 |
| VLM | vision-language representation model. action을 내지 않아도 된다. | VLA와 구분 | Ch9 |
| Embodied Reasoning / ER | 물리 세계의 task decomposition, spatial reasoning, tool/VLA call을 담당하는 상위 reasoning layer | action-producing VLA와 구분 | Ch1, Ch17 |
| Robot Policy | robot observation/state에서 action을 내는 learned or programmed mapping | VLA는 language-conditioned robot policy의 한 유형 | Ch6, Ch13 |
| Skill | 특정 subtask를 수행하는 reusable policy/function/controller primitive | low-level action과 구분 | Ch10, Ch17 |
| Skill Library | planner/ER가 호출할 수 있는 skill 집합 | VLA policy 자체와 구분 | Ch10, Ch17 |
| Planner | goal을 subgoal/action/trajectory sequence로 분해하는 module | VLA policy와 역할이 겹칠 수 있으나 동일하지 않음 | Ch5, Ch10 |
| Task Planner | symbolic 또는 semantic task sequence를 만드는 planner | motion planner와 구분 | Ch5 |
| Motion Planner | configuration/continuous space에서 feasible path를 찾는 planner | task planner와 구분 | Ch5 |
| TAMP | task and motion planning. symbolic task와 continuous motion feasibility를 함께 다룬다. | pure LLM planning과 구분 | Ch5, Ch17 |
| World Model | 환경 동역학, task progress, object relation을 예측/표현하는 model | 단순 scene description과 구분 | Ch17, Ch21 |
| Affordance | 현재 상태에서 로봇이 수행할 수 있는 action possibility | 언어적 가능성과 물리적 가능성 구분 | Ch10, Ch11 |
| Grounding | 언어/시각 표현이 물리 object, action, constraint와 연결되는 과정 | captioning과 구분 | Ch9-Ch11 |
| Observation | sensor가 제공하는 입력 $o_t$ | state와 구분 | Ch1, Ch2 |
| State | robot/environment의 실제 또는 추정 상태 $s_t, \hat{s}_t$ | observation과 구분 | Ch2 |
| Belief State | partial observability에서 가능한 state에 대한 추정/분포 | 단일 observation과 구분 | Ch2 |
| Proprioception | joint position/velocity/force 등 robot 내부 감각 | external vision과 구분 | Ch2, Ch13 |
| Memory | task history, previous observations, progress, tool state를 담는 context | state estimator와 구분 가능 | Ch1, Ch17 |
| Scene Graph | object, relation, spatial layout을 그래프 형태로 표현한 scene representation | raw image와 구분 | Ch17 |
| Instruction | 사용자 또는 task source가 제공하는 language command $l$ | subgoal/plan과 구분 | Ch1 |
| Goal | 달성해야 하는 최종 task condition | subgoal과 구분 | Ch5, Ch10 |
| Subgoal | long-horizon task를 나눈 중간 목표 $g_t$ | controller target과 구분 | Ch1, Ch17 |
| Plan | subgoal, skill, action sequence의 구조화된 의도 $P_t$ | trajectory와 구분 | Ch5, Ch10 |
| Constraint | workspace, collision, force, speed, task precondition 등 제한 조건 $\mathcal{C}$ | preference/cost와 구분 | Ch5, Ch19 |
| Action | 문맥에 따라 다의적이다. 본문에서는 항상 action type을 명시한다. | naked action 사용 금지 | Ch1, Ch13 |
| Policy-level Action | VLA policy가 내는 executable proposal $a_t$ | low-level command $u_t$와 구분 | Ch13 |
| Action Token | discrete vocabulary token으로 표현된 action | continuous command와 구분 | Ch13 |
| Continuous Action | 실수 벡터 action. pose delta, velocity, joint target 등이 될 수 있다. | token과 구분 | Ch13 |
| Action Chunk | 여러 time step의 action sequence $A_t^{(H)}$ | single-step action과 구분 | Ch13 |
| Action Horizon | chunk 또는 planning window 길이 $H$ | episode horizon과 구분 | Ch13, Ch18 |
| Action Distribution | 단일 action 대신 가능한 action의 분포 | mean regression과 구분 | Ch13 |
| Action Expert | semantic backbone과 분리된 continuous action generation head | VLM backbone과 구분 | Ch13, Ch15 |
| Action Tokenizer | continuous action trajectory를 token 또는 compact code로 변환하는 module | language tokenizer와 목적이 다름 | Ch13, Ch15 |
| Waypoint | controller/planner가 향해야 할 중간 target | full trajectory와 구분 | Ch3, Ch13 |
| Delta Pose | 현재 pose 기준 상대 pose command | absolute target pose와 구분 | Ch3, Ch13 |
| End-effector Pose | gripper/tool frame의 position and orientation | joint configuration과 구분 | Ch3 |
| Trajectory Target | controller가 추적할 path/trajectory reference | action chunk와 혼동 금지 | Ch3, Ch13 |
| Controller Target | controller에 전달되는 reference $r_t$ | policy-level action과 low-level command 사이 | Ch3, Ch13 |
| Low-level Command | robot driver 또는 servo loop에 들어가는 $u_t$ | policy action $a_t$와 구분 | Ch3 |
| Torque Command | actuator torque input | high-risk direct control로 취급 | Ch3, Ch13 |
| Velocity Command | joint/cartesian/base velocity target | pose target 및 torque와 구분 | Ch3 |
| Position Command | joint/cartesian position target | trajectory 및 torque와 구분 | Ch3 |
| Whole-body Action | arms, hands, torso, head, base, balance를 포함하는 humanoid-level action | manipulator-only action과 구분 | Ch20 |
| OSC | operational space control. task/end-effector space에서 motion/force를 제어한다. | joint-space control과 구분 | Ch3 |
| Impedance Control | 로봇-환경 상호작용의 dynamic relation을 제어한다. | 단순 position/force control과 구분 | Ch4 |
| MPC | model predictive control. 제약 있는 finite-horizon control을 반복해서 푼다. | open-loop trajectory와 구분 | Ch3, Ch18 |
| WBC | whole-body control. humanoid/mobile manipulator의 전체 body constraint를 함께 다룬다. | arm-only controller와 구분 | Ch20 |
| Servo Loop | 고주파 feedback control loop | VLA inference loop와 구분 | Ch3, Ch18 |
| Control Frequency | controller가 update되는 주파수 | VLA inference frequency와 구분 | Ch18 |
| Inference Latency | VLA/ER model이 output을 생성하는 데 걸리는 시간 | control latency와 함께 보고 | Ch18 |
| Controller Mismatch | VLA output type/frequency/range가 controller가 기대하는 target과 맞지 않는 문제 | model error와 구분 | Ch13 |
| Safety Shield | VLA/plan/controller output을 allow/modify/stop하는 runtime safety module | semantic filter와 구분 가능 | Ch19 |
| Runtime Monitor | execution 중 anomaly/risk를 감시하는 module | offline evaluator와 구분 | Ch19 |
| Recovery Policy | 실패 후 stop/retry/replan/ask human을 결정하는 policy | task policy와 구분 | Ch19 |
| Human Oversight | 사람의 승인, 개입, 중단 권한 | 자동 safety guarantee가 아님 | Ch19 |
| Semantic Safety | 명령/goal 자체의 위험성, 모호성, 금지 여부를 다룬다. | physical safety와 구분 | Ch19 |
| Geometric Safety | collision, workspace, self-collision 등 기하 제약을 다룬다. | dynamic safety와 구분 | Ch19 |
| Dynamic Safety | force, speed, torque, contact, stability를 다룬다. | semantic safety와 구분 | Ch19 |
| System Safety | monitoring, recovery, E-stop, authority, logging 등 전체 운영 안전 | model safety와 구분 | Ch19 |
| Data Safety | unsafe demonstrations, privacy, contamination, bias 관리 | runtime safety와 구분 | Ch14, Ch19 |
| Evaluation Protocol | task, reset, horizon, metric, intervention rule을 포함하는 평가 절차 | benchmark name만으로 대체 불가 | Ch16 |
| Benchmark | 비교 가능한 task suite와 metric set | deployment evidence와 구분 | Ch16 |
| Rollout | 초기 조건에서 policy를 실행한 episode/trial | single action evaluation과 구분 | Ch16 |
| Success Rate | 성공 rollout 비율 | capability 전체와 구분 | Ch16 |
| Intervention | 사람 또는 safety system이 execution에 개입하는 사건 | failure와 별도 기록 | Ch16, Ch19 |
| Distribution Shift | train/eval/deployment condition의 차이 | 단순 noise와 구분 | Ch6, Ch16 |
| Benchmark Artifact | benchmark 설계 때문에 실제 능력보다 쉬운 shortcut이 생기는 현상 | true generalization과 구분 | Ch16 |
| Data Engine | collect-curate-train-evaluate-deploy-log loop | dataset static archive와 구분 | Ch14 |
| Demonstration | 사람/정책/스크립트가 만든 example trajectory | success guarantee가 아님 | Ch6, Ch14 |
| Teleoperation | 사람이 원격/장치를 통해 robot behavior를 생성하는 data collection 방식 | autonomous data와 구분 | Ch14 |
| Relabeling | trajectory에 language/goal/success/failure label을 다시 붙이는 과정 | raw logging과 구분 | Ch14 |
| Embodiment | robot morphology, sensors, actuators, controller, workspace의 묶음 | robot name만으로 충분하지 않음 | Ch14 |
| Embodiment Gap | 서로 다른 robot embodiment 사이에서 action/state 의미가 달라지는 문제 | domain shift의 한 유형 | Ch14, Ch20 |
| Action Normalization | robot/action channel별 scale을 표준화하는 과정 | 일반 feature normalization과 구분 | Ch14, Ch15 |
| Dataset Card | dataset scope, robot, action type, frequency, labels, split, limitations를 문서화한 card | paper appendix와 별개일 수 있음 | Ch14 |
| Source Tier | textbook, peer-reviewed paper, preprint, project page, company doc 등의 evidence level | 모든 claim은 tier를 의식 | Book Bible |
| Freshness Audit | 최신 시스템/버전/benchmark claim을 원고 작성 직전 확인하는 절차 | stable theory에는 불필요 | Book Bible |
| Company Case Study | 공식 release/demo를 conceptual example로 쓰는 사례 | 검증된 일반 원리와 구분 | Ch17, Ch20 |
| Evidence Standard | claim을 뒷받침하는 source와 protocol의 요구 수준 | citation 수와 다름 | Ch16 |
| Roboticist's Takeaway | 각 장 끝에서 실제 robot system 관점으로 정리하는 결론 box | summary 이상의 design principle | 전체 |
| Control Boundary | learned policy와 classical controller가 만나는 책임 경계 | software API보다 넓은 개념 | Ch13 |
| Interface Contract | layer 사이의 input/output, timing, assumptions, failure handling 약속 | model architecture와 구분 | Ch1 |
| Safety Case | 특정 hazard를 어떤 evidence와 mitigation으로 낮췄는지 설명하는 문서화된 주장 | safety score와 구분 | Ch19 |
| Deployment Evidence | 실제 또는 실제에 가까운 운영 조건에서 수집한 latency, failure, recovery, safety, success evidence | benchmark score와 구분 | Ch16-Ch19 |



---

## 12. Open Issues

| Issue ID | Question | Current Decision | Evidence Needed | Affected Chapters |
| --- | --- | --- | --- | --- |
| OI-01 | Gemini Robotics-ER류를 VLA라고 부를 것인가? | 직접 action-producing VLA가 아니라 ER/orchestrator layer로 둔다. | 공식 문서/논문 최신성 확인 | Ch1, Ch17, Ch19 |
| OI-02 | Skill call을 action taxonomy에 포함할 것인가? | Ch1에서는 broad executable output으로 소개, Ch13에서는 robot-control action에서 분리, Ch17에서 hierarchy로 확장 | skill library/VLA hybrid 사례 정리 | Ch1, Ch13, Ch17 |
| OI-03 | Direct torque output VLA를 어떻게 다룰 것인가? | 가능한 action type으로는 인정하되 real deployment에서는 고위험/고난도 interface로 표시 | robot learning 사례와 안전 조건 수집 | Ch3, Ch13, Ch19 |
| OI-04 | Safety 표준/규정을 얼마나 다룰 것인가? | Ch19에서는 standard family를 언급하고 실제 적용은 최신 확인이 필요한 별도 appendix 후보로 둔다. | 표준 최신성 확인 | Ch19, Appendix |
| OI-05 | Action chunk horizon $H$의 표준 표기를 고정할 것인가? | $A_t^{(H)}$를 기본 표기로 사용한다. frequency는 $f_{VLA}$와 $f_{ctrl}$로 구분한다. | Ch13 draft 중 재검토 | Ch13, Ch18 |
| OI-06 | Whole-body action과 manipulation action을 같은 taxonomy에 둘 것인가? | Ch13에서 spectrum 끝으로 소개하고 Ch20에서 별도 상세화한다. | humanoid/WBC 사례 정리 | Ch13, Ch20 |
| OI-07 | Data/evaluation layer를 하나로 볼 것인가? | Ch1 stack에서는 묶고, Ch14는 data engine, Ch16은 evaluation protocol로 분리한다. | chapter draft 중 반복 점검 | Ch1, Ch14, Ch16 |



---

## 13. Immediate Next Tasks

| Order | Task | Purpose | Next Output |
| --- | --- | --- | --- |
| 1 | Ch1 Evidence Map | Ch1에서 인용할 핵심 reference/system을 source tier별로 정리한다. | Ch1 detailed outline |
| 2 | Ch1 Detailed Outline | Section 1.1-1.7의 argument flow와 figures/tables 위치를 확정한다. | Ch1 Section 1.1 draft |
| 3 | Ch1 Section 1.1 Draft | “Why Real VLA Is Not Just a Bigger VLM” 본문을 쓴다. | 첫 실제 원고 anchor |
| 4 | Ch13 Evidence Map | action token/chunk/diffusion/flow/FAST/OFT/control background를 evidence map으로 정리한다. | Ch13 detailed outline |
| 5 | Figure/Table Inventory v0.1 | Wave 1에서 중복되는 그림/표를 줄이고 caption을 고정한다. | 본문 작성 중 cross-reference 안정화 |



### 13.1 Recommended Next Prompt

```text
Book Bible v0.1, Wave 1 Chapter Contracts v0.1, 그리고 Ch1-Ch13 Interface Specification v0.1을 기준으로 Chapter 1 Evidence Map을 작성해줘.

목표는 Ch1 “What Is a Real VLA System?” 본문 작성 전에 이 장에서 쓸 reference, system case, figure/table, failure mode를 source tier별로 정리하는 거야.

조건:
- 본문 원고는 쓰지 마.
- Real VLA system vs VLA policy layer 구분을 유지해.
- ER, VLA, controller, safety, data/evaluation layer별로 reference를 분류해.
- 최신 회사 시스템은 case study/source-watch로 분리해.
- 마지막에는 Section 1.1 draft를 쓰기 전에 잠가야 할 결정 5개를 제시해.
- 출력은 md와 docx 둘 다 만들어줘.
```

### 13.2 Working State Block for Future Turns

```text
[Working State]
Book: Real VLA: A Roboticist's Perspective
Core thesis: VLA is not a replacement for robotics control; it is a policy interface connecting task semantics and embodied perception to action generation.
Current phase: Evidence map / detailed outline / section draft
Current chapter: Chapter [N]. [Title]
Current deliverable: [specific deliverable]
Locked decisions:
- Use Ch1-Ch13 Interface Specification v0.1 terminology.
- Distinguish Real VLA system from VLA policy layer.
- Distinguish policy-level action a_t from low-level control input u_t.
- Avoid paper-list survey style.
- Always connect concepts to robot control/data/evaluation/safety interface.
- Treat latest company systems as case studies unless independently verified.
Do not change:
- Overall book thesis
- 21-chapter sequence
- Real VLA stack definition
- Ch13 action taxonomy without updating the Interface Spec

Task:
[Write the specific instruction here.]
```

---

## 14. One-line Lock

**Real VLA는 하나의 큰 VLM이 아니라, semantic reasoning이 제안한 task intent를 VLA policy의 action object, motion/control의 physical command, safety/evaluation/data의 evidence loop로 연결하는 embodied system interface이다.**
