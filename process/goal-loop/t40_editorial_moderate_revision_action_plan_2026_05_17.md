# t40 editorial moderate revision action plan

## Summary

두 명의 editor review를 반영해, 이번 pass에서는 출판 가능성을 체감하게 만드는 장치를 우선 보강한다. 목표는 원고를 단순 강의노트가 아니라 VLA system engineering field manual로 보이게 만드는 것이다.

## Actions

1. Ch0에 evidence tier와 citation policy를 추가한다.
2. frontmatter에 notation discipline을 추가해 전역 기호 충돌을 줄인다.
3. Ch10, Ch13, Ch14, Ch16, Ch20에 boxed case study를 추가한다.
4. Ch17-20의 `Chapter summary` heading을 `요약`으로 통일한다.
5. 참고문헌을 최신 VLA 중심 17개에서 robotics/control/planning/learning/VLM/data/eval/safety를 포함한 50개 이상으로 확장한다.
6. Docker XeLaTeX로 `main.pdf`를 재빌드하고 page size와 주요 QA 이미지를 확인한다.
7. Slack `진행상황-ping`에 완료 경로와 QA 경로를 알린다.

## Verification

- `4_latex_book/build/main.pdf` 재빌드 성공
- 전체 PDF page size가 `170mm x 240mm`
- Ch0 evidence tier, Ch10/13/14/16/20 case study, bibliography 후반부가 PNG로 렌더링됨
