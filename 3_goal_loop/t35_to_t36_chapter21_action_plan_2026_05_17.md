# t35 -> t36 action plan: Chapter 21

## 기준

- 전체 장 계획: `3_goal_loop/t22_full_chapter_execution_status_2026_05_17.md`
- 대상 장: Chapter 21. Future Directions
- 이전 산출물: Chapter 20까지 통합된 `4_latex_book/build/main.pdf` 174쪽

## 이번 단계의 목표

Chapter 21은 책 전체를 마무리하면서 Real VLA의 미래 방향을 모델 크기 경쟁이 아니라 world model, online adaptation, self-improving data loop, multi-embodiment transfer, safety assurance, hardware-aware deployment가 결합된 시스템 연구로 정리한다. 결론은 VLA가 제어, 계획, 모션플래닝, 로봇러닝을 대체하는 것이 아니라 이들을 새 interface로 연결한다는 점이다.

## 포함할 기술 내용

1. Real VLA의 미래 시스템 구성 요소
2. world model이 보완할 한계: hidden state, causality, consequence, information gathering
3. self-improving data loop와 robot ops
4. safe online adaptation과 release gate
5. multi-embodiment transfer와 embodiment adapter
6. formal safety assurance와 evaluation standard
7. hardware-aware deployment와 model scaling의 균형
8. 앞으로의 연구 과제와 roboticist의 역할
9. 책 전체의 closing synthesis

## 산출물

- `4_latex_book/chapters/chapter21.tex`
- `4_latex_book/main.tex`에 `\input{chapters/chapter21}` 추가
- Docker XeLaTeX 빌드로 최종 `4_latex_book/build/main.pdf` 갱신
- PyMuPDF로 페이지 수 및 Chapter 21 포함 확인
- Slack `#진행상황-ping`에 전체 장 완료 보고

## 완료 기준

- `latexmk -xelatex`가 종료 코드 0으로 완료된다.
- `main.pdf`가 Chapter 21까지 포함한 최종 PDF로 생성된다.
- Slack 업데이트에 final chapter, PDF path, page count, 전체 chapter completion 상태가 포함된다.
