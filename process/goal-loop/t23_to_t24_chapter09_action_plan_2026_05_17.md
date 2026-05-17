# t23 -> t24 Action Plan: Chapter 9 Transformers, VLMs, and Grounding

## Goal

Write Chapter 9 of the Korean LaTeX book and rebuild the integrated `main.pdf`.

## Planning basis

Use the full chapter plan from:

- `0_기획/step0_2_comments.md`
- `0_기획/step1_2_Real_VLA_Chapter_Prologues_v0_1_2026_05.md`
- `1_Book Bible v0.1/1_Real_VLA_Book_Bible_v0_1_2026_05.md`

## Chapter scope

Chapter 9 explains Transformer/VLM representation only to the degree needed for Real VLA. The core distinction is that semantic image-text grounding is not the same as embodied action grounding.

## Required content

- Explain tokenization and self-attention.
- Explain ViT-style image tokenization.
- Explain contrastive image-text alignment in CLIP-style VLMs.
- Explain multimodal token fusion and VLM backbone use.
- Distinguish semantic grounding, visual grounding, affordance grounding, and physical/action grounding.
- Connect VLM priors to VLA policy design and failure modes.
- Include evaluation metadata for VLM-to-robot grounding.

## Output artifacts

- `4_latex_book/chapters/chapter09.tex`
- Update `4_latex_book/main.tex` to include Chapter 9.
- Rebuild `4_latex_book/build/main.pdf` with Docker XeLaTeX.
- Send Slack update to `#진행상황-ping` after successful build.

## Acceptance check

- Docker build exits successfully.
- `main.pdf` exists and page count is verified.
- The chapter contains equations and tables suitable for a KAIST-level robotics course.
