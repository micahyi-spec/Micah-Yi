# Stage 5 review — EUR receivable LLM analysis & validation · Treasury sign-off

Micah — your independent run found the single most serious defect anyone surfaced in this cohort, and it found it in your own model:

> *"The cause was that the workbook still contained the Stage 2 placeholder market inputs, while the independent LLM used the Stage 4 market-data values… The workbook Validation tab also continued to report: `Market Data Status = PLACEHOLDER`."*

`S0_in` at 1.1000 instead of 1.1535. `R_USD` at 5.30% instead of 4.01%. `F0_in` hard at 1.1000 rather than the CIP value. Every strategy off by $186,000 to $298,000 on a €4.5M notional. And the workbook was carrying a status flag that said so in plain text, sitting in the file the whole time.

This is exactly what Stage 5 is for. A parity check would not have caught it — the placeholder inputs are internally consistent, so the model happily reconciles to itself and reports PASS. It took an outside reader working from the *documents* rather than the *spreadsheet* to notice that the spreadsheet and the documents were describing different worlds. You then diagnosed all twelve rows correctly as workbook error rather than blaming the model, and your closing line names the lesson precisely: *"A model can be mathematically correct and still fail a production handoff if the data status or treatment of an instrument is unclear."*

First, a mechanical note: the automated pass scored your retrospective 8.5/17, because it measured only the thirteen words under `### Retrospective Conclusion` and missed the several hundred words of actual retrospective sitting above it under different headings. I read it and restored full marks.

| Criterion | Score |
|---|---|
| LLM execution & comparison | 25 / 25 |
| Hand verification | 25 / 25 |
| Recommendation & executive voice | 25 / 25 |
| Spec retrospective | 17 / 17 *(restored — see above)* |
| Repo polish | 6.4 / 8 |
| **Total** | **99 / 100** |

**What you did well — and why it matters**

- **You future-valued the premium — correctly, and consistently.** Your put figures only reconcile if the $112,500 premium is carried to settlement: `112,500 × 1.04065694 = $117,073.91`, and `5,190,750 − 117,073.91 = $5,073,676.09` ✓. Roughly half this cohort netted the raw premium against settlement-date proceeds, and one classmate marked their LLM *wrong* for doing what you did. You had the right convention and applied it at every scenario.
- **All of it ties.** `DF_USD = 1.04065694` ✓, `DF_FC = 1.02924056` ✓, `F0 = 1.1535 × 1.04065694 / 1.02924056 = 1.16629456` ✓ against your stated 1.1662946810, forward proceeds `4,500,000 × F0 = $5,248,326.06` ✓, and the unhedged row at all three scenarios ✓.
- **You separated the two findings cleanly.** The stale inputs are a **workbook error**; the call treatment is a **spec ambiguity**. Different causes, different owners, different fixes — and you resisted the temptation to fold them into one complaint.
- **Your call diagnosis is properly reasoned.** *"The independent LLM chose not to calculate a call hedge because doing so would require inventing a rule that was not explicitly defined."* Then the v2 fix offers a genuine either/or: exclude the call from the receivable decision set on economic grounds, *or* state the exact formula if it must appear. Giving the spec author a real choice rather than a vague "add more detail" is what makes a retrospective actionable.
- **You closed the Stage 2 loop.** You merged the Stage 2 review PR on 2026-08-15 rather than leaving it open. That is the workflow working as intended.

**The one substantive correction — you wrote the fix down and never made it**

Your validation ends with this:

> *"Before final submission, the actual Excel workbook must be repopulated with the Stage 4 market-data values so that the workbook saved in the repository reflects the reconciled results documented in this validation."*

I checked the commit history. `models/builds/2026-08-07-Yi-eur-receivable-hedge-model .xlsx` was last modified on **2026-08-08**. Your validation document was committed on **2026-08-15**. The workbook was never repopulated.

So the repository currently contains:

- a **memo** citing $5,248,326.06 as the locked forward proceeds,
- a **validation document** explaining in detail why that figure is right and the workbook's is wrong,
- and a **workbook** that, if a reader opens it, returns **$4,950,000** and displays `Market Data Status = PLACEHOLDER`.

Your prose is correct everywhere. The artifact the prose points at is not. Anyone who trusts the memo enough to open the model finds a $298,326 discrepancy and no explanation inside the file itself.

This is the same distinction that separates a good analyst from a good one who is also safe to rely on: **a finding is not closed until the artifact is corrected.** Three things would close it:

1. Repopulate the Inputs tab with the Stage 4 values (`S0_in` 1.1535, `R_USD` 4.01%, `R_FC` 2.884%, `K_PUT`/`K_CALL` 1.1535) and let `F0_in` recompute from CIP rather than sitting as a hard 1.1000.
2. Confirm the Validation tab flips from `PLACEHOLDER` to live — that flag is a genuinely good control, and it did its job. It should be green before the model ships.
3. Add a dated line at the top of the validation doc: *"Resolved 2026-08-15: workbook repopulated with Stage 4 inputs; all figures now reconcile to this document."*

The finding itself is the best in the cohort, and none of this diminishes it. It is specifically about what happens after the finding.

**Two smaller items**

1. **Your memo never states the crossover.** With your (correct) premium convention it is one line: `S_T* = (5,248,326.06 + 117,073.91) / 4,500,000 = **1.19231**`, or **3.37% above spot**. Below that the forward wins; above it, the put. Your §C works through all three scenarios thoroughly — 1,516 words and a full A–E structure with sub-headings, which is genuinely well organised — but a CFO will remember one number, and that is the one.

2. **The workbook filename has a stray space:** `2026-08-07-Yi-eur-receivable-hedge-model .xlsx`, with a space before the extension. It is a leftover from the `(2)` rename on 2026-08-08. Spaces before extensions break links, scripts, and command-line tooling, and they look accidental. Rename it and fix the reference in your memo.

**Repo polish — 1.6 points, one item**

`LICENSE` is the only open box; description, per-directory READMEs, public status and commit history are all in place. Add an MIT license at the repo root for a 100.

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
