# Chapter 1. What Is a Real VLA System? - Section Draft v0.1

## 1.4 Interface Contracts: Observation, State, Action, and Control

Section 1.3에서 Real VLA stack의 다섯 layer를 정의했다. 이제 그 layer들이 서로 무엇을 주고받는지 더 엄밀하게 고정해야 한다. Real VLA system이 실제 로봇에서 작동하려면 observation, state, policy-level action, controller reference, low-level command, safety decision의 interface contract가 명확해야 한다. 이 contract가 흐려지면 VLA가 무엇을 잘한 것인지, controller가 무엇을 보완한 것인지, safety layer가 무엇을 막은 것인지, evaluation이 무엇을 증명한 것인지 구분할 수 없다.

가장 먼저 구분해야 할 것은 observation과 state이다. `o_t`는 카메라 영상, depth, tactile signal, audio, proprioceptive reading 같은 센서 관측이다. 반면 `s_t`는 환경과 로봇의 실제 상태이다. 실제 상태는 대개 직접 관측되지 않는다. 로봇은 image를 볼 수 있지만, 그것만으로 object pose, contact force, gripper slip, hidden obstacle, actuator delay, human motion intention을 완전히 아는 것은 아니다. 그래서 state estimate `\hat{s}_t` 또는 belief `b_t`가 필요하고, robot-centric state `x_t`나 configuration `q_t`가 controller와 safety layer에 중요해진다. **로봇이 본다는 것은 로봇이 상태를 안다는 뜻이 아니다.** [CITATION: Kalman; Siciliano; Murray, Li, and Sastry; RT-1]

머그컵 예제에서도 이 차이는 바로 드러난다. 카메라 image에는 mug와 drying rack이 보일 수 있다. 그러나 mug의 정확한 6D pose, 표면 마찰, gripper와의 접촉 상태, 유리컵의 안정성, robot joint limit, camera timestamp와 controller timestamp의 차이는 image 하나에 그대로 들어 있지 않다. 큰 VLM이 장면을 잘 설명해도, 그 설명이 state estimate를 대체하지는 않는다. VLA가 observation-conditioned policy로 잘 작동하려면, 어떤 observation을 쓰는지뿐 아니라 어떤 robot state와 memory가 policy, controller, safety layer에 전달되는지 명시해야 한다.

두 번째 구분은 policy-level action `a_t`와 low-level command `u_t`이다. `a_t`는 VLA policy가 내는 executable proposal이다. 이것은 action token, continuous vector, waypoint, delta pose, action chunk의 한 원소, 또는 action distribution sample일 수 있다. 반면 `u_t`는 servo loop나 robot driver가 받는 command이다. 이것은 joint velocity, torque, position target, impedance target, whole-body command일 수 있다. 이 둘 사이에는 보통 controller reference `r_t`와 controller interpretation이 있다.

Figure 1.2는 이 구분을 다음처럼 표현한다.

```text
o_t, q_t, language/subgoal
        -> VLA policy
        -> policy-level action a_t
        -> planner/controller/safety interpretation
        -> controller reference r_t
        -> low-level command u_t
        -> robot/environment
```

이 그림에서 중요한 것은 화살표의 존재이다. `a_t`에서 `u_t`로 바로 점프하지 않는다. VLA가 delta pose를 출력한다면 그 pose가 어떤 frame 기준인지 해석해야 한다. VLA가 waypoint를 출력한다면 planner나 controller가 collision-free path와 timing을 만들어야 한다. VLA가 action chunk를 출력한다면 chunk horizon과 interruption policy가 필요하다. VLA가 torque를 직접 출력한다면 latency, stability, safety 검증 부담이 크게 올라간다. 따라서 "VLA가 action을 출력한다"는 문장은 충분하지 않다. 책 전체에서 action이라는 단어는 반드시 level과 downstream controller를 함께 가져야 한다.

### Box 1.3. Why Action Representation Is a Control Boundary

Action representation은 단순한 output format이 아니다. 그것은 learned policy가 어디까지 책임지고, controller가 어디부터 책임지는지를 정하는 control boundary이다. Waypoint를 출력하는 VLA는 motion planning과 tracking을 downstream controller에 맡긴다. Delta pose를 출력하는 VLA는 task-space controller와 frame convention에 의존한다. Action chunk를 출력하는 VLA는 temporal consistency를 얻을 수 있지만 빠른 interruption과 recovery가 어려워질 수 있다. Diffusion이나 flow 기반 action distribution은 multimodal behavior를 표현할 수 있지만 sampling cost와 safety verification 부담을 만든다. Direct torque output은 표현력이 크지만 real deployment에서는 latency, stability, safety envelope가 훨씬 엄격해진다. 그러므로 action representation 선택은 architecture 선택이면서 동시에 controller, safety, data, evaluation contract 선택이다.

세 번째로 필요한 것은 frame, rate, horizon, scaling, downstream controller metadata이다. 같은 numeric vector라도 world frame인지 robot-base frame인지 end-effector frame인지 joint frame인지에 따라 의미가 완전히 달라진다. 같은 "0.05"라는 값도 meter, radian, normalized bin, velocity scale, gripper opening일 수 있다. VLA inference rate `f_VLA`와 controller rate `f_ctrl`도 구분해야 한다. VLA가 5 Hz로 action chunk를 내고 controller가 200 Hz로 servoing한다면, 중간 executor가 어떻게 interpolation하고, 언제 chunk를 interrupt하고, safety monitor가 어느 주기로 개입하는지가 system behavior를 결정한다.

이것을 간단한 interface 식으로 쓰면 다음과 같다.

```text
a_t ~ pi_theta(. | o_{<=t}, q_{<=t}, l or g_t, m_t)
r_t = Interpret(a_t, x_t, robot_model, frame)
u_t = Controller(r_t, x_t, C_t, limits)
```

이 식은 증명을 위한 수식이 아니라 독자가 책임 경계를 놓치지 않게 하기 위한 notation이다. `pi_theta`는 VLA policy이고, `a_t`는 policy-level action이다. `Interpret`는 action type, frame, scaling, controller expectation을 해석해 controller reference `r_t`를 만든다. `Controller`는 robot state와 constraints를 보고 low-level command `u_t`를 만든다. Safety layer는 이 경로의 여러 지점에 붙을 수 있다.

Ch1에서는 action token, continuous action, waypoint, action chunk, diffusion, flow, action expert를 깊게 비교하지 않는다. 그러나 왜 이 taxonomy가 중요한지는 미리 고정해야 한다. Action token은 VLM/LLM-style sequence modeling과 잘 맞지만 physical frequency structure를 잃을 수 있다. Continuous vector는 controller와 연결하기 쉽지만 scale과 normalization에 민감하다. Waypoint는 안정적인 controller integration에 유리하지만 motion/control burden을 downstream으로 넘긴다. Action chunk는 temporal consistency를 줄 수 있지만 interruption과 recovery의 granularity를 바꾼다. Diffusion과 flow는 multimodal action을 표현할 수 있지만 sampling, latency, safety projection 문제를 만든다. Action expert는 semantic backbone과 motor generation head를 나누지만 fine-tuning과 controller compatibility 문제가 남는다. [CITATION: RT-2; Diffusion Policy; pi0; FAST; OpenVLA-OFT]

이 preview의 목적은 Ch13을 미리 써버리는 것이 아니다. 목적은 독자가 Chapter 1부터 action representation을 "모델 출력 모양"이 아니라 "controller와 safety/evaluation이 해석해야 하는 interface"로 읽게 만드는 것이다. 어떤 representation이 가장 좋은지는 일반적으로 말할 수 없다. task contact profile, robot morphology, available controller, data label type, latency budget, safety shield capability에 따라 boundary가 달라진다.

Section 1.4의 결론은 다음과 같다. **Real VLA stack은 좋은 backbone만으로 성립하지 않는다. Observation과 state, `a_t`와 `u_t`, frame과 rate, horizon과 controller contract가 함께 명시될 때 비로소 실행 가능한 robot system으로 읽힌다.** 이제 다음 Section 1.5에서는 이 interface 문제가 VLA 시대에 갑자기 생긴 것이 아니라, control, planning, robot learning, VLM/LLM이 역사적으로 수렴하면서 생긴 문제임을 설명한다.

## Citation Placeholders for Later Integration

- **[C1.4-1] Kalman; Siciliano; Murray, Li, and Sastry; Corke** - observation/state/state-estimation/control vocabulary.
- **[C1.4-2] RT-1; RT-2; OpenVLA** - observation/language-conditioned robot policy examples.
- **[C1.4-3] Khatib; Hogan; MPC; WBC** - `a_t` to `u_t` control boundary and physical feasibility.
- **[C1.4-4] Diffusion Policy; pi0; FAST; OpenVLA-OFT** - action distribution, flow, tokenization, continuous action, and action expert preview.
- **[C1.4-5] vla-eval; BeTTER; ASIMOV-style safety/eval work** - action interface metadata as evaluation and safety evidence.

## Revision Notes

- This is the first draft of Section 1.4 based on Section 1.3.
- It introduces notation in a light interface-oriented way, not as a mathematical derivation.
- It includes Figure 1.2 as a text placeholder and Box 1.3.
- It previews action representation taxonomy only as a handoff to Chapter 13.
- It bridges to Section 1.5 historical convergence.
