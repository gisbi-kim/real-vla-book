# t26 -> t27 action plan: Chapter 12

## 기준

- 전체 장 계획: `3_goal_loop/t22_full_chapter_execution_status_2026_05_17.md`
- 대상 장: Chapter 12. Robotics Transformer Era
- 이전 산출물: Chapter 11까지 통합된 `4_latex_book/build/main.pdf` 98쪽

## 이번 단계의 목표

Chapter 12는 BC-Z, Gato, RT-1, PaLM-E, RT-2, RoboCat 흐름을 VLA 탄생기로 정리한다. 단순한 논문 연표가 아니라, robot action이 sequence prediction, token prediction, multimodal transformer policy의 대상으로 재정의된 기술적 전환을 설명한다.

## 포함할 기술 내용

1. Language-conditioned imitation learning에서 generalist robot policy로의 이동
2. Transformer policy의 기본 입출력 형식
3. BC-Z: language/video-conditioned zero-shot task generalization
4. Gato: single transformer, multiple modalities/tasks라는 generalist agent 관점
5. RT-1: real robot data, task diversity, action tokenization
6. PaLM-E: embodied multimodal language model과 robot state/text/image 결합
7. RT-2: VLM fine-tuning과 action-as-token 관점
8. RoboCat: multi-task/multi-embodiment adaptation과 data loop
9. 이후 Chapter 13 action representation으로 이어지는 한계: continuous control, latency, dexterity, data scale

## 산출물

- `4_latex_book/chapters/chapter12.tex`
- `4_latex_book/main.tex`에 `\input{chapters/chapter12}` 추가
- Docker XeLaTeX 빌드로 `4_latex_book/build/main.pdf` 갱신
- PyMuPDF로 페이지 수 및 Chapter 12 포함 확인
- Slack `#진행상황-ping`에 완료 보고

## 완료 기준

- `latexmk -xelatex`가 종료 코드 0으로 완료된다.
- `main.pdf`가 Chapter 12를 포함한 새 페이지 수로 생성된다.
- Slack 업데이트에 action plan, chapter file, PDF path, page count, 다음 장 계획이 포함된다.
