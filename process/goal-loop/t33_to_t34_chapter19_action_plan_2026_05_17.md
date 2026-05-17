# t33 -> t34 action plan: Chapter 19

## 기준

- 전체 장 계획: `3_goal_loop/t22_full_chapter_execution_status_2026_05_17.md`
- 대상 장: Chapter 19. Safety and Assurance
- 이전 산출물: Chapter 18까지 통합된 `4_latex_book/build/main.pdf` 157쪽

## 이번 단계의 목표

Chapter 19는 VLA safety를 prompt-level refusal 문제가 아니라 robot system stack의 기본 성질로 정리한다. semantic safety, geometric safety, dynamic safety, system safety, data safety를 분리하고, runtime monitor, safety shield, human override, failure handling, assurance case를 수식과 평가 기준으로 정의한다.

## 포함할 기술 내용

1. unsafe success와 safe failure의 구분
2. semantic, geometric, dynamic, system, data safety taxonomy
3. hazard model과 risk metric
4. safety shield와 control barrier style constraint filtering
5. runtime monitor, watchdog, emergency stop, fallback policy
6. human-in-the-loop supervision과 authority boundary
7. red-teaming, unsafe instruction, ambiguous instruction, physical uncertainty
8. safety benchmark와 assurance case: claim, evidence, argument
9. deployment log와 incident report standard

## 산출물

- `4_latex_book/chapters/chapter19.tex`
- `4_latex_book/main.tex`에 `\input{chapters/chapter19}` 추가
- Docker XeLaTeX 빌드로 `4_latex_book/build/main.pdf` 갱신
- PyMuPDF로 페이지 수 및 Chapter 19 포함 확인
- Slack `#진행상황-ping`에 완료 보고

## 완료 기준

- `latexmk -xelatex`가 종료 코드 0으로 완료된다.
- `main.pdf`가 Chapter 19를 포함한 새 페이지 수로 생성된다.
- Slack 업데이트에 action plan, chapter file, PDF path, page count, 다음 장 계획이 포함된다.
