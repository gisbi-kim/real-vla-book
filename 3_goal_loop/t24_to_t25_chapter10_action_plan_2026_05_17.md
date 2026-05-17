# t24 -> t25 action plan: Chapter 10

## 기준

- 전체 장 계획: `3_goal_loop/t22_full_chapter_execution_status_2026_05_17.md`
- 대상 장: Chapter 10. LLM/VLM as Robot Planner
- 이전 산출물: Chapter 9까지 통합된 `4_latex_book/build/main.pdf` 80쪽

## 이번 단계의 목표

Chapter 10은 end-to-end VLA 직전 단계로서 LLM/VLM이 robot planner로 사용되던 구조를 정리한다. 핵심은 LLM/VLM이 직접 motor command를 내는 모델이 아니라, skill library, controller, affordance/value function, visual feedback, code API와 결합된 high-level decision module이었다는 점이다.

## 포함할 기술 내용

1. Plan, skill, controller의 계층 분해
2. LLM planner의 기본 입출력 형식
3. SayCan식 language likelihood와 affordance/value 결합
4. Code as Policies식 code generation과 API/controller 호출 구조
5. Inner Monologue식 closed-loop feedback planning
6. VoxPoser식 value map 생성과 model-based planning
7. Executability gap: semantic plausibility와 physical feasibility의 차이
8. VLA로 넘어가기 위한 교훈: representation, skill boundary, feedback, verification

## 산출물

- `4_latex_book/chapters/chapter10.tex`
- `4_latex_book/main.tex`에 `\input{chapters/chapter10}` 추가
- Docker XeLaTeX 빌드로 `4_latex_book/build/main.pdf` 갱신
- PyMuPDF로 페이지 수 및 주요 페이지 텍스트 확인
- Slack `#진행상황-ping`에 완료 보고

## 완료 기준

- `latexmk -xelatex`가 종료 코드 0으로 완료된다.
- `main.pdf`가 Chapter 10을 포함한 새 페이지 수로 생성된다.
- Slack 업데이트에 action plan, chapter file, PDF path, page count, 다음 장 계획이 포함된다.
