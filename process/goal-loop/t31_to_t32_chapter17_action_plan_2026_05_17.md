# t31 -> t32 action plan: Chapter 17

## 기준

- 전체 장 계획: `3_goal_loop/t22_full_chapter_execution_status_2026_05_17.md`
- 대상 장: Chapter 17. Hierarchical VLA and Embodied Reasoning
- 이전 산출물: Chapter 16까지 통합된 `4_latex_book/build/main.pdf` 136쪽

## 이번 단계의 목표

Chapter 17은 monolithic VLA와 modular planner 사이의 중간 구조를 공학적으로 정리한다. 상위 embodied reasoning layer가 task 해석, subgoal 생성, progress 판단, recovery 결정을 맡고, 하위 VLA policy가 action chunk 또는 trajectory를 생성하며, controller와 safety monitor가 물리 실행을 제한하는 구조를 수식과 interface contract로 정의한다.

## 포함할 기술 내용

1. 계층형 VLA가 다시 중요해지는 이유: horizon, safety, compute, observability
2. embodied reasoning의 출력 형식: subgoal, constraint, success criterion, query, recovery action
3. options/POMDP 관점의 hierarchical policy 정식화
4. reasoning layer와 VLA policy 사이의 communication contract
5. progress detection, success estimation, replanning trigger
6. VLA + TAMP, tool/function calling, world model의 역할 구분
7. monolithic VLA와 hierarchical VLA의 trade-off
8. deployment 관점의 safety gate와 logging/evaluation 기준

## 산출물

- `4_latex_book/chapters/chapter17.tex`
- `4_latex_book/main.tex`에 `\input{chapters/chapter17}` 추가
- Docker XeLaTeX 빌드로 `4_latex_book/build/main.pdf` 갱신
- PyMuPDF로 페이지 수 및 Chapter 17 포함 확인
- Slack `#진행상황-ping`에 완료 보고

## 완료 기준

- `latexmk -xelatex`가 종료 코드 0으로 완료된다.
- `main.pdf`가 Chapter 17을 포함한 새 페이지 수로 생성된다.
- Slack 업데이트에 action plan, chapter file, PDF path, page count, 다음 장 계획이 포함된다.
