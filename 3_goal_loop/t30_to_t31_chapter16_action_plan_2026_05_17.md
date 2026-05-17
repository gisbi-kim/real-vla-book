# t30 -> t31 action plan: Chapter 16

## 기준

- 전체 장 계획: `3_goal_loop/t22_full_chapter_execution_status_2026_05_17.md`
- 대상 장: Chapter 16. Evaluation and Benchmarking
- 이전 산출물: Chapter 15까지 통합된 `4_latex_book/build/main.pdf` 130쪽

## 이번 단계의 목표

Chapter 16은 benchmark success rate와 실제 robot capability를 분리하는 evidence standard를 정의한다. 목적은 benchmark를 부정하는 것이 아니라, 어떤 protocol에서 어떤 capability가 검증되었고 무엇이 여전히 검증되지 않았는지 분해하는 것이다.

## 포함할 기술 내용

1. Why success rate is not enough
2. Benchmark families: manipulation, long-horizon, lifelong, sim, real-robot, open-vocabulary
3. Evaluation protocol schema: reset, instruction, rollout, success, failure, intervention
4. Action-type dependent metrics: latency, smoothness, saturation, tracking, invalid token/chunk interruption
5. Robustness/generalization tests and distribution shift
6. Evaluation harness and reproducibility
7. Real robot reporting standard
8. Benchmark artifacts and shortcut behavior

## 산출물

- `4_latex_book/chapters/chapter16.tex`
- `4_latex_book/main.tex`에 `\input{chapters/chapter16}` 추가
- Docker XeLaTeX 빌드로 `4_latex_book/build/main.pdf` 갱신
- PyMuPDF로 페이지 수 및 Chapter 16 포함 확인
- Slack `#진행상황-ping`에 완료 보고

## 완료 기준

- `latexmk -xelatex`가 종료 코드 0으로 완료된다.
- `main.pdf`가 Chapter 16을 포함한 새 페이지 수로 생성된다.
- Slack 업데이트에 action plan, chapter file, PDF path, page count, 다음 장 계획이 포함된다.
