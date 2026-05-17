# t29 -> t30 action plan: Chapter 15

## 기준

- 전체 장 계획: `3_goal_loop/t22_full_chapter_execution_status_2026_05_17.md`
- 대상 장: Chapter 15. Adaptation and Fine-Tuning
- 이전 산출물: Chapter 14까지 통합된 `4_latex_book/build/main.pdf` 122쪽

## 이번 단계의 목표

Chapter 15는 foundation VLA를 특정 robot, camera, action space, task distribution에 맞추는 practical adaptation 과정을 설명한다. OpenVLA, Octo, OpenVLA-OFT, FAST, VLA Foundry 등은 일반 원리의 증거가 아니라 case study / engineering pattern으로 다룬다.

## 포함할 기술 내용

1. 왜 generalist VLA도 adaptation이 필요한가
2. Adaptation target: prompt, sensor remapping, action head, adapter, LoRA, full fine-tuning
3. Embodiment adapter와 action normalization
4. Fine-tuning objective와 forgetting regularization
5. Data mixture, small data overfitting, failure/correction data
6. Action-head tuning, chunking, continuous action objective
7. Offline validation -> sim validation -> guarded real-robot validation
8. Deployment readiness checklist

## 산출물

- `4_latex_book/chapters/chapter15.tex`
- `4_latex_book/main.tex`에 `\input{chapters/chapter15}` 추가
- Docker XeLaTeX 빌드로 `4_latex_book/build/main.pdf` 갱신
- PyMuPDF로 페이지 수 및 Chapter 15 포함 확인
- Slack `#진행상황-ping`에 완료 보고

## 완료 기준

- `latexmk -xelatex`가 종료 코드 0으로 완료된다.
- `main.pdf`가 Chapter 15를 포함한 새 페이지 수로 생성된다.
- Slack 업데이트에 action plan, chapter file, PDF path, page count, 다음 장 계획이 포함된다.
