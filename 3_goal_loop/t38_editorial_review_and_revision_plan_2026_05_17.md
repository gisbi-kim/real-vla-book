# t38 Editorial Review and Revision Plan

## Chief editor style review

### Overall verdict

The manuscript has a credible and differentiated thesis: Real VLA is treated as a robot-system responsibility problem rather than a model catalog. This is the right positioning for an engineering audience and for a KAIST-level course. The strongest parts are the system-contract framing, the separation between policy action and controller command, and the insistence that data, evaluation, and safety are not appendix topics.

### Major comments

1. The manuscript needs a more explicit quality gate for each chapter. A book editor will ask whether every chapter closes a claim, leaves a formal object, and hands an interface to the next chapter. Without that, the manuscript risks reading like a long technical survey.
2. The audience and course-use contract should be clearer. The current draft says who the reader is, but a course reviewer will want to know what a student can do after each part.
3. Source anchoring must become a full revision pass. The concept is strong, but the next editorial pass should align each chapter with representative papers, implementation interfaces, evaluation protocols, and known failure cases.
4. The visual roadmap is useful, but the manuscript should also explain how a reviewer should judge whether a chapter is complete.
5. Layout should not leave visible or logged table instability. The long chapter-role table is useful, but it should fit the book measure without overfull alignment warnings.

## Revisions applied in this pass

1. Added a new Chapter 0 section, `강의 운영과 원고 검토를 위한 기준`.
2. Added a quality-gate table for chapter-level manuscript review.
3. Added a definition box specifying the minimum deliverable for each chapter: central claim, minimal formalization, downstream interface, and failure condition.
4. Added course-operation guidance: claim -> formal variables -> system interface -> evidence/failure check.
5. Tightened the Chapter 0 longtable layout by reducing table padding, using narrower columns, and switching to `\RaggedRight` cells via `ragged2e`.

## Next action

After this pass, the next valuable revision is a source-anchor pass for Chapters 1-3: for each chapter, add representative papers/systems, implementation interfaces, and failure/evaluation cases using a consistent template.
