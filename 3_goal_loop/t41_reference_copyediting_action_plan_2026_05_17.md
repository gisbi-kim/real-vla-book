# t41 Reference Copyediting Action Plan

## Goal
- 세 명의 editor review 중 즉시 신뢰도에 영향을 주는 bibliography 오류와 citation anchor 누락을 먼저 정리한다.
- 잘못된 저자/제목/venue를 수정하고, 본문에서 언급하는 BC-Z, CALVIN/HuLC, VLA Foundry, RDT-1B의 reference 근거를 보강한다.

## Actions
- [x] [21] Transporter Networks, [36] RoboCat, [50] CALVIN/HuLC 오류를 수정한다.
- [x] CLIPort, SayCan, Inner Monologue, VoxPoser, RT-1, PaLM-E, OpenVLA, LIBERO의 venue 표기를 보강한다.
- [x] BC-Z, HuLC/What Matters, VLA Foundry, RDT-1B bibitem을 추가한다.
- [x] Chapter 12, 13, 14, 15, 16에 누락된 citation anchor를 삽입한다.
- [x] Docker XeLaTeX로 `main.pdf`를 재빌드하고 citation/overfull/page size를 확인한다.
- [x] bibliography와 수정된 장 주변을 PNG로 렌더링해 QA 산출물을 남긴다.
- [ ] 빌드 완료 후 Slack `진행상황-ping`에 PDF/QA 경로를 알린다.

## Verification
- `4_latex_book/build/main.pdf`
- `4_latex_book/build/qa/reference_copyediting`
- `main.log`에 undefined citation과 Overfull hbox가 없어야 한다.
- 전체 PDF page size는 계속 `170mm x 240mm`여야 한다.
