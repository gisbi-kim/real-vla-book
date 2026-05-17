# t32 -> t33 action plan: Chapter 18

## 기준

- 전체 장 계획: `3_goal_loop/t22_full_chapter_execution_status_2026_05_17.md`
- 대상 장: Chapter 18. Real-Time and Hardware-Aware VLA
- 이전 산출물: Chapter 17까지 통합된 `4_latex_book/build/main.pdf` 146쪽

## 이번 단계의 목표

Chapter 18은 VLA를 closed-loop robot system 안의 시간 제약, compute 제약, memory/power/thermal budget, communication delay와 함께 설계해야 함을 정리한다. 모델의 benchmark accuracy만이 아니라 latency distribution, action frequency, fallback behavior, hardware deployment profile을 평가 기준으로 둔다.

## 포함할 기술 내용

1. latency가 closed-loop control에 만드는 delay와 instability
2. latency budget decomposition: sensing, preprocessing, inference, decoding, communication, control
3. control frequency hierarchy: reasoning, VLA, trajectory generator, low-level controller
4. action chunking, asynchronous execution, stale action 문제
5. hardware constraints: GPU/NPU, memory, bandwidth, power, thermal throttling
6. on-device inference와 cloud inference의 trade-off
7. compression, quantization, distillation, early exit의 robotics-specific risk
8. watchdog, fallback controller, graceful degradation
9. real robot timing report standard

## 산출물

- `4_latex_book/chapters/chapter18.tex`
- `4_latex_book/main.tex`에 `\input{chapters/chapter18}` 추가
- Docker XeLaTeX 빌드로 `4_latex_book/build/main.pdf` 갱신
- PyMuPDF로 페이지 수 및 Chapter 18 포함 확인
- Slack `#진행상황-ping`에 완료 보고

## 완료 기준

- `latexmk -xelatex`가 종료 코드 0으로 완료된다.
- `main.pdf`가 Chapter 18을 포함한 새 페이지 수로 생성된다.
- Slack 업데이트에 action plan, chapter file, PDF path, page count, 다음 장 계획이 포함된다.
