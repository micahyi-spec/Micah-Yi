# Stage 3 review — EUR receivable build & audit · Treasury sign-off

Micah — one sentence in Finding 1 is the best thing in this cohort's Stage 3 work:

> "I traced the problem back to the Stage 2 specification **instead of forcing the workbook validation to display PASS**."

Your parity check failed. `S0_in` 1.1000, `R_USD` 5.30%, `R_FC` 3.00% imply a forward of 1.1248941906, against an `F0_in` of 1.1000. You had two ways out: adjust something until the check went green, or go upstream and fix the document the build came from. You chose the second, revised the Stage 2 spec, set a **CIP-consistent indicative placeholder** — explicitly labelled as "not a live market forward quote" — and rebuilt.

That is the difference between a model that stays correct and one that drifts from its own documentation. Fix the workbook only, and your spec now describes something that no longer exists. Six months later nobody can tell which is authoritative.

| Criterion | Score |
|---|---|
| Contract compliance | 50 / 50 |
| Structure & presentation | 25 / 25 |
| Audit note | 25 / 25 |
| **Total** | **100 / 100** |

**What you did well — and why it matters**

- **You stated an adversarial audit posture up front.** "The audit also focused on identifying problems in the AI-generated workbook rather than assuming the initial build was correct." That sentence is the whole reason this stage exists. An auditor who opens a file expecting it to be right will find it right.
- **Your build-contract table is a requirements traceability matrix.** Each contract line, its audit result, and a note — so a reader can confirm nothing was skipped. That is the format a real reviewer wants, and it took discipline to write out even the requirements that passed trivially.
- **Finding 2 handles the helper names correctly.** You added `BASIS`, `SENS_LOW`, and `SENS_STEP` for readability, verified they "do not replace any of the ten standardized names," and documented them back into the spec. Extending a contract without violating it — and recording the extension — is exactly right.
- **Finding 3 asked whether the AI collapsed the money-market hedge into one formula.** That is a specific, well-chosen suspicion: an LLM will happily nest borrow / convert / invest into a single unreadable expression that computes correctly and cannot be audited. You checked for it deliberately, and confirmed the three steps stayed visible with a reason — "it is possible to audit the amount borrowed in EUR, the amount converted into USD, and the settlement-date value separately."
- **You reported `F0_in` to ten decimal places.** 1.1248941906. Slightly absurd as a market rate, entirely correct as a derived placeholder — it makes clear the number was computed, not quoted, and lets anyone reproduce your parity result exactly.

**To push it further (real-desk nuance)**

- **Your `R_USD` of 5.30% against `R_FC` of 3.00% is a 230bp differential.** That is wide relative to the actual environment — at Stage 4 you found 4.01% and 2.884%, about 113bp. Your placeholders were internally consistent after the fix, which is what mattered here, but choosing placeholders in the neighbourhood of observable rates makes the Stage 3 model a better rehearsal for the live one.
- **A parity residual of zero is a tautology.** After you derived `F0_in` from your own rates, the forward and money-market legs share one input set and must agree. The check now confirms your arithmetic rather than testing a relationship. You have not claimed otherwise — just be explicit about it at Stage 5, because a passing parity check reads as market validation to a casual reader.
- **Findings 2, 3, and 4 confirm; Finding 1 investigates.** Three of your four verified that things exist and behave as designed. Necessary, but a workbook can pass all three and still be wrong. Finding 1 is the shape to repeat.

**Next — Stage 4**

Already in and reviewed separately. Your input-classification taxonomy there is the best-designed provenance scheme in the cohort.

— Treasury

---

### How to work this review — professional workflow

Treat this PR the way an analyst treats feedback from Treasury — a review is a proposal to engage with, not a checklist to rubber-stamp:

1. **Read it yourself first.** Understand each point and form your own view before changing anything. Disagreeing *with a documented reason* is a legitimate, senior response.
2. **Stress-test it with an LLM (pushback pass).** Paste this review and your spec into your AI assistant and ask it to (a) explain anything you're unsure of more deeply, and (b) argue the *other side* — where might the reviewer be wrong, and what would you give up by making each change. You're building judgment, not just executing edits.
3. **Decide, then draft the changes with the LLM.** For the points you accept, have the AI help implement them — you specify exactly what and why. Your spec is the prompt; precise in, correct out.
4. **Verify — non-negotiable.** Re-run your own checks (`scripts/recalc.py`, the parity tie-out, sensitivity continuity, no error cells) and confirm the numbers before you commit. An AI will hand you a confident wrong edit; verification is what makes the result *yours*.
5. **Close the loop on the PR.** Reply in the thread with what you changed, what you pushed back on and why, then commit and push. Writing down the reasoning is exactly how this works on a real team.

*This is the same human-in-the-loop discipline the whole project is built on: the LLM drafts, you edit and verify, and you own the result.*
