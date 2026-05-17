# T39 Editorial Major Revision Response

## 입력 리뷰 요지

다른 편집자의 verdict는 `Accept with major revision`에 가깝다. 핵심 thesis인 `VLA는 더 큰 VLM이 아니라 robot execution/control/safety/evaluation stack에 연결되는 책임 구조`는 강하지만, 현재 원고는 출판용 단행본보다는 고급 강의노트와 field guide 초안에 가깝다는 지적이다.

## 반영한 수정

1. Front matter 추가
   - `서문`, `이 책의 독자`, `이 책에서 다루지 않는 것`, `어떻게 읽을 것인가`를 표지 뒤에 추가했다.
   - `Notation and Glossary`를 별도 front matter로 추가했다.

2. Part 구조 추가
   - Part I. Real VLA Stack
   - Part II. Learning Foundations
   - Part III. From Planner to VLA
   - Part IV. Deployment Evidence
   - Part V. Beyond Manipulation

3. 참고문헌과 citation 추가
   - SayCan, Code as Policies, Inner Monologue, VoxPoser, RT-1, PaLM-E, RT-2, RoboCat, Open X-Embodiment, ACT, Diffusion Policy, OpenVLA, pi0, FAST, OpenVLA-OFT, GR00T N1, pi0.5를 `thebibliography`에 추가했다.
   - Chapter 12, 13, 14, 20에 대표 citation을 연결했다.

4. Chapter 13 강화
   - 장 제목을 `Action Representation Is the Control Boundary`로 강화했다.
   - RT-1, RT-2, OpenVLA, OpenVLA-OFT, pi0, FAST의 action representation 비교 표를 추가했다.
   - mug/rack/glass running example을 action representation 관점으로 다시 연결했다.

5. Chapter 14 실무성 강화
   - Robot Dataset Card 최소 양식을 추가했다.
   - Open X-Embodiment 흐름을 robot data schema 관점과 연결했다.

6. Chapter 18 deployment checklist 강화
   - 논문에서 자주 빠지는 timing evidence 표를 추가했다.

7. Chapter 20 최신 humanoid VLA 사례 추가
   - GR00T N1을 dual-system humanoid VLA 사례로 삽입했다.

## 다음 액션 플랜

1. Chapter 1 끝에 `이 책에서 다루지 않는 것`을 별도 subsection으로 다시 노출해 thesis boundary를 더 강하게 만든다.
2. Chapter 10에 SayCan, Code as Policies, Inner Monologue, VoxPoser 비교 case를 citation과 함께 추가한다.
3. Chapter 15에 OpenVLA-OFT fine-tuning recipe를 adaptation/interface 관점의 case study로 확장한다.
4. Chapter 16에 LIBERO, SimplerEnv, real-robot reporting checklist를 추가한다.
5. 전체 장에서 반복 thesis 문장을 줄이고, 반복 대신 case/evidence로 대체하는 copy-edit pass를 수행한다.
