# Real VLA Chapter 1 - Source Anchor Map v0.1

Date checked: 2026-05-17

## Purpose

This file maps the assembled Chapter 1 claims to source clusters. It is not the final bibliography. It is the control document for the next citation pass.

## Source Reliability Labels

- **Stable/classical:** low drift; exact bibliographic metadata still needed.
- **Established paper:** arXiv/project paper with stable claim surface; verify venue/version later.
- **Current system page:** drift-prone; recheck before publication.
- **Recent diagnostic/safety paper:** drift-prone field; cite with date and avoid overclaiming.

## Claim Cluster A: VLA Is Not Just VLM Plus Action Head

**Chapter locations:** 1.1, 1.3, 1.8

**Claim:** VLA systems connect visual/language representations to robot actions, but the robot system also needs controller, safety, and evaluation interfaces.

**Anchors:**

- RT-1: Robotics Transformer for Real-World Control at Scale  
  https://arxiv.org/abs/2212.06817  
  Label: established paper.
- RT-2: Vision-Language-Action Models Transfer Web Knowledge to Robotic Control  
  https://arxiv.org/abs/2307.15818  
  Label: established paper.
- OpenVLA: An Open-Source Vision-Language-Action Model  
  https://arxiv.org/abs/2406.09246  
  Label: established paper.
- OpenVLA project page  
  https://openvla.github.io/  
  Label: current project page.

**Use in chapter:** cite when introducing VLA policy as a model class that maps observation/language to action, then immediately contrast it with Real VLA as a system stack.

**Verification needed:** exact RT-1/RT-2/OpenVLA venue/version metadata.

## Claim Cluster B: Action Representation Is a Control Boundary

**Chapter locations:** 1.1, 1.4, 1.6, 1.8

**Claim:** Action tokens, continuous actions, waypoints, chunks, diffusion/flow outputs, and action experts create different controller, latency, scaling, and safety implications.

**Anchors:**

- Diffusion Policy: Visuomotor Policy Learning via Action Diffusion  
  https://arxiv.org/abs/2303.04137  
  Label: established paper.
- ACT / ALOHA: Learning Fine-Grained Bimanual Manipulation with Low-Cost Hardware  
  https://arxiv.org/abs/2304.13705  
  Label: established paper.
- pi0: A Vision-Language-Action Flow Model for General Robot Control  
  https://www.physicalintelligence.company/download/pi0.pdf  
  Label: current/company paper; verify latest public version before publication.
- FAST: Efficient Action Tokenization for Vision-Language-Action Models  
  https://arxiv.org/abs/2501.09747  
  Label: established paper, still relatively recent.

**Use in chapter:** cite around Box 1.3 and the Section 1.6 action-distribution pattern.

**Verification needed:** pi0 exact arXiv/report URL and current version; OpenVLA-OFT/openpi exact source if included in final bibliography.

## Claim Cluster C: Embodied Reasoning and Tool/Policy Orchestration Are Distinct from Motor Policy

**Chapter locations:** 1.2, 1.3, 1.5, 1.6

**Claim:** LLM/VLM/ER systems can structure tasks, call tools, synthesize code, or build value maps, but this is not identical to low-level motor execution.

**Anchors:**

- SayCan / Do As I Can, Not As I Say  
  https://arxiv.org/abs/2204.01691  
  Label: established paper.
- Code as Policies  
  https://arxiv.org/abs/2209.07753  
  Label: established paper.
- PaLM-E  
  https://arxiv.org/abs/2303.03378  
  Label: established paper.
- VoxPoser  
  https://arxiv.org/abs/2307.05973  
  Label: established paper.
- Gemini Robotics official model page  
  https://deepmind.google/models/gemini-robotics/  
  Label: current system page.
- Gemini Robotics-ER 1.6 official blog  
  https://deepmind.google/blog/gemini-robotics-er-1-6/  
  Label: current system page; recheck before publication.

**Use in chapter:** cite where the chapter separates embodied reasoning from VLA policy and classifies Gemini Robotics-ER-like systems as reasoning/orchestration rather than direct motor policy.

**Verification needed:** exact wording from current Google DeepMind pages before making detailed claims about model versions or capabilities.

## Claim Cluster D: Classical Control, Planning, and Estimation Remain Necessary

**Chapter locations:** 1.1, 1.2, 1.3, 1.4, 1.5

**Claim:** VLA policy output must still pass through state estimation, feasibility, dynamics, contact, controllers, and task/motion planning constraints.

**Anchors:**

- Operational-space control / Khatib.
- Impedance control / Hogan.
- Model predictive control / Mayne et al. and related MPC references.
- Planning and TAMP: STRIPS/PDDL, LaValle, PDDLStream, TAMP surveys.
- Robot modeling and control textbooks: Murray, Li, and Sastry; Siciliano; Corke.

**Use in chapter:** cite broad background claims, especially Box 1.1, Section 1.4 interface notation, and the historical convergence section.

**Verification needed:** exact canonical editions, page ranges, and BibTeX entries. Web recency is not important for this cluster.

## Claim Cluster E: Robot Data Is Embodied, Action-Labeled, and Metadata-Dependent

**Chapter locations:** 1.1, 1.5, 1.7, 1.8

**Claim:** Robot data is not like web text/image data; trajectory meaning depends on embodiment, controller, action representation, reset/intervention policy, and failure labels.

**Anchors:**

- Open X-Embodiment: Robotic Learning Datasets and RT-X Models  
  https://arxiv.org/abs/2310.08864  
  Label: established paper.
- DROID: A Large-Scale In-The-Wild Robot Manipulation Dataset  
  https://arxiv.org/abs/2403.12945  
  Label: established paper.
- BridgeData V2  
  Label: established dataset/paper; exact URL still needed.

**Use in chapter:** cite the Section 1.7 trajectory-record block and the claim that robot data needs embodiment/action/controller metadata.

**Verification needed:** exact BridgeData V2 source; exact Open X-Embodiment and DROID bibliographic metadata.

## Claim Cluster F: Evaluation Must Go Beyond Final Success Rate

**Chapter locations:** 1.1, 1.7, 1.8

**Claim:** Benchmark success is useful but incomplete; Real VLA evaluation must expose protocol, randomization, failure taxonomy, intervention, safety events, controller assumptions, and distribution shift.

**Anchors:**

- vla-eval: A Unified Evaluation Harness for Vision-Language-Action Models  
  https://arxiv.org/abs/2603.13966  
  Label: recent diagnostic/evaluation paper.
- BeTTER / Unmasking the Illusion of Embodied Reasoning in VLA Models  
  https://arxiv.org/abs/2604.18000  
  Label: recent diagnostic/evaluation paper.
- VLA-Arena project page  
  https://vla-arena.github.io/  
  Label: current benchmark page; verify publication status.

**Use in chapter:** cite Box 1.4 and Checklist 1.1, especially claims about benchmark under-specification, embodied reasoning diagnosis, and failure mode visibility.

**Verification needed:** exact publication status, version, and benchmark scope for vla-eval, BeTTER, and VLA-Arena before strong wording.

## Claim Cluster G: Safety Is a Stack Property

**Chapter locations:** 1.2, 1.3, 1.7, 1.8

**Claim:** VLA safety includes semantic, geometric, dynamic, runtime, data, and human-supervision responsibilities; it cannot be reduced to text safety or a final collision checker.

**Anchors:**

- Vision-Language-Action Safety: Threats, Challenges, Evaluations, and Mechanisms  
  https://arxiv.org/abs/2604.23775  
  Label: recent safety survey.
- HazardArena: Evaluating Semantic Safety in Vision-Language-Action Models  
  https://arxiv.org/abs/2604.12447  
  Label: recent safety benchmark.
- SAFE: Multitask Failure Detection for Vision-Language-Action Models  
  https://vla-safe.github.io/  
  Label: recent project page/paper; verify final publication details.
- Concept-Based Dictionary Learning for Inference-Time Safety in VLA Models  
  https://arxiv.org/abs/2602.01834  
  Label: recent safety paper.

**Use in chapter:** cite Section 1.7 safety taxonomy and Figure 1.4. Avoid claiming safety is solved; use these as evidence that safety is an active, multi-layer system problem.

**Verification needed:** exact dates, versions, and whether claims are survey taxonomy, benchmark result, or proposed mechanism.

## Claim Cluster H: Humanoid and Whole-Body VLA Are Frontier System Cases

**Chapter locations:** 1.6

**Claim:** Humanoid/whole-body VLA systems make the stack harder because locomotion, whole-body control, balance, tactile feedback, latency, and safety envelopes become central.

**Anchors:**

- NVIDIA Isaac GR00T repository  
  https://github.com/NVIDIA/Isaac-GR00T  
  Label: current system repository.
- NVIDIA Isaac GR00T developer page  
  https://developer.nvidia.com/isaac/gr00t  
  Label: current product/developer page.
- Figure Helix 02 official page  
  https://www.figure.ai/news/helix-02  
  Label: current company page.

**Use in chapter:** cite only as current frontier examples, not as independent proof of general deployability.

**Verification needed:** recheck dates and wording before publication; company pages are especially drift-prone.

## Claims Needing Careful Wording

1. **"General robot control" or "generalist robot" claims**  
   Use as source terminology, not as book endorsement.

2. **"Open-source stack enables reproducibility"**  
   Safe if limited to code/model/evaluation surface. Do not imply deployment reproducibility.

3. **"Benchmarks under-specify protocols"**  
   Support with vla-eval and BeTTER, but keep the claim scoped to VLA evaluation practice.

4. **"Safety is unsolved"**  
   Phrase as: recent work shows safety is multi-layer and active; do not overstate that no useful mechanisms exist.

## t12 -> t13 Recommendation

Patch the assembled chapter into v0.2 with lightweight citation anchors:

- Add bracketed source tags at the end of high-value evidence paragraphs.
- Keep detailed URLs in a `Selected Source Anchors` appendix.
- Do not add full BibTeX yet.
- Recheck current system pages only if the final file will make version-specific claims.
