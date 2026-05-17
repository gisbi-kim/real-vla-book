# t34 -> t35 action plan: Chapter 20

## 기준

- 전체 장 계획: `3_goal_loop/t22_full_chapter_execution_status_2026_05_17.md`
- 대상 장: Chapter 20. Humanoids and Whole-Body VLA
- 이전 산출물: Chapter 19까지 통합된 `4_latex_book/build/main.pdf` 165쪽

## 이번 단계의 목표

Chapter 20은 humanoid VLA를 단순히 action dimension이 큰 manipulation model이 아니라 balance, locomotion, bimanual manipulation, dexterous hand, gaze, whole-body contact가 결합된 embodiment-specific VLA로 정리한다. VLA policy와 whole-body controller의 책임 경계를 명확히 하고, human video, teleoperation, simulation data의 역할을 구분한다.

## 포함할 기술 내용

1. humanoid VLA가 arm-only VLA와 다른 이유
2. whole-body state와 action representation
3. center of mass, support polygon, contact, balance constraint
4. VLA policy와 whole-body controller의 interface
5. locomotion-manipulation coupling
6. bimanual manipulation과 dexterous hand control
7. dual-system architecture: reasoning, VLA policy, WBC, locomotion controller
8. humanoid data engine: human video, teleoperation, simulation, retargeting
9. safety envelope and evaluation metrics

## 산출물

- `4_latex_book/chapters/chapter20.tex`
- `4_latex_book/main.tex`에 `\input{chapters/chapter20}` 추가
- Docker XeLaTeX 빌드로 `4_latex_book/build/main.pdf` 갱신
- PyMuPDF로 페이지 수 및 Chapter 20 포함 확인
- Slack `#진행상황-ping`에 완료 보고

## 완료 기준

- `latexmk -xelatex`가 종료 코드 0으로 완료된다.
- `main.pdf`가 Chapter 20을 포함한 새 페이지 수로 생성된다.
- Slack 업데이트에 action plan, chapter file, PDF path, page count, 다음 장 계획이 포함된다.
