# t28 -> t29 action plan: Chapter 14

## 기준

- 전체 장 계획: `3_goal_loop/t22_full_chapter_execution_status_2026_05_17.md`
- 대상 장: Chapter 14. Data Engines
- 이전 산출물: Chapter 13까지 통합된 `4_latex_book/build/main.pdf` 115쪽

## 이번 단계의 목표

Chapter 14는 VLA 성능이 모델 아키텍처만이 아니라 data collection, curation, labeling, failure/recovery logging, evaluation loop의 산물임을 설명한다. Chapter 13에서 정의한 action representation이 dataset 설계와 직접 연결된다는 점을 강조한다.

## 포함할 기술 내용

1. Robot data is not web data
2. Data engine loop: collect -> curate -> train -> evaluate -> deploy -> log
3. Demonstration collection: teleoperation, kinesthetic, scripted, autonomous
4. Data record schema: observation, action, state, language, metadata, outcome
5. Multi-embodiment/action normalization problem
6. Failure, correction, intervention, recovery data
7. Simulation, synthetic data, human video의 역할과 한계
8. Curation, relabeling, dataset cards, leakage prevention
9. Data engine quality metrics

## 산출물

- `4_latex_book/chapters/chapter14.tex`
- `4_latex_book/main.tex`에 `\input{chapters/chapter14}` 추가
- Docker XeLaTeX 빌드로 `4_latex_book/build/main.pdf` 갱신
- PyMuPDF로 페이지 수 및 Chapter 14 포함 확인
- Slack `#진행상황-ping`에 완료 보고

## 완료 기준

- `latexmk -xelatex`가 종료 코드 0으로 완료된다.
- `main.pdf`가 Chapter 14를 포함한 새 페이지 수로 생성된다.
- Slack 업데이트에 action plan, chapter file, PDF path, page count, 다음 장 계획이 포함된다.
