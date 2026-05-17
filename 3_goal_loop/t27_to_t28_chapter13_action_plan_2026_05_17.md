# t27 -> t28 action plan: Chapter 13

## 기준

- 전체 장 계획: `3_goal_loop/t22_full_chapter_execution_status_2026_05_17.md`
- 대상 장: Chapter 13. Action Representation
- 이전 산출물: Chapter 12까지 통합된 `4_latex_book/build/main.pdf` 104쪽

## 이번 단계의 목표

Chapter 13은 책의 기술적 중심 장이다. 목적은 action representation을 출력 포맷이 아니라 VLA policy layer와 motion/control layer 사이의 control boundary로 정의하는 것이다.

## 포함할 기술 내용

1. Action representation is the control boundary
2. Discrete action token과 quantization/latency 한계
3. Continuous regression과 normalization/saturation/mode averaging
4. Waypoint/delta pose/trajectory target 구분
5. Action chunking as temporal interface
6. Diffusion policy와 multimodal action distribution
7. Flow matching/action expert 구조
8. Action tokenizer/compression과 temporal-frequency structure
9. Task/robot/controller/latency/safety 기반 design matrix
10. Failure modes and checklist

## 산출물

- `4_latex_book/chapters/chapter13.tex`
- `4_latex_book/main.tex`에 `\input{chapters/chapter13}` 추가
- Docker XeLaTeX 빌드로 `4_latex_book/build/main.pdf` 갱신
- PyMuPDF로 페이지 수 및 Chapter 13 포함 확인
- Slack `#진행상황-ping`에 완료 보고

## 완료 기준

- `latexmk -xelatex`가 종료 코드 0으로 완료된다.
- `main.pdf`가 Chapter 13을 포함한 새 페이지 수로 생성된다.
- Slack 업데이트에 action plan, chapter file, PDF path, page count, 다음 장 계획이 포함된다.
