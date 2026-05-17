# t25 -> t26 action plan: Chapter 11

## 기준

- 전체 장 계획: `3_goal_loop/t22_full_chapter_execution_status_2026_05_17.md`
- 대상 장: Chapter 11. From Planner + Skills to VLA
- 이전 산출물: Chapter 10까지 통합된 `4_latex_book/build/main.pdf` 89쪽

## 이번 단계의 목표

Chapter 11은 planner+skills 구조에서 VLA로 넘어가는 경계 장이다. Chapter 10이 LLM/VLM을 high-level planner로 놓고 skill/controller를 호출하는 구조를 설명했다면, Chapter 11은 어떤 책임을 skill library에 남기고 어떤 책임을 learned VLA policy로 흡수할지 다룬다.

## 포함할 기술 내용

1. Planner+skills 구조의 장점과 병목
2. Skill boundary가 data efficiency, generalization, safety에 미치는 영향
3. End-to-end VLA policy가 흡수하는 responsibility
4. Skill call, waypoint, action chunk, residual command의 중간 interface
5. Hierarchical policy와 latent skill 관점
6. Closed-loop feedback이 VLA 내부로 들어오는 방식
7. Pure planning과 pure end-to-end policy 사이의 design spectrum

## 산출물

- `4_latex_book/chapters/chapter11.tex`
- `4_latex_book/main.tex`에 `\input{chapters/chapter11}` 추가
- Docker XeLaTeX 빌드로 `4_latex_book/build/main.pdf` 갱신
- PyMuPDF로 페이지 수 및 Chapter 11 포함 확인
- Slack `#진행상황-ping`에 완료 보고

## 완료 기준

- `latexmk -xelatex`가 종료 코드 0으로 완료된다.
- `main.pdf`가 Chapter 11을 포함한 새 페이지 수로 생성된다.
- Slack 업데이트에 action plan, chapter file, PDF path, page count, 다음 장 계획이 포함된다.
