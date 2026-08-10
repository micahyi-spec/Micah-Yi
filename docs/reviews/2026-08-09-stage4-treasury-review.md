# Stage 4 review — EUR receivable market data & population · Treasury sign-off

Micah — your **Classification** column is the best-designed provenance scheme in the cohort. Five categories, declared in §1 before the table: live market observation, public-market proxy, CIP-implied value, scenario value, explicit assumption. Every input is then tagged with one.

That taxonomy does something a source column alone cannot. "ECB" tells a reader where a number came from; "Live market reference" versus "CIP-implied" versus "Scenario assumption" tells them *what kind of thing it is* — and therefore how much weight it can bear. A reader can see at a glance that your spot is observed, your forward is derived, and your premiums are given, without reading a word of prose.

Your stated purpose is the right one too: "Another analyst should be able to return to the cited sources, identify the same dated observations, and understand the reasoning behind any proxy or computation used."

| Criterion | Score |
|---|---|
| Data quality & provenance | 50 / 50 |
| Model resolves cleanly | 33 / 33 |
| Lab cross-check | 17 / 17 |
| **Total** | **100 / 100** |

**What you did well — and why it matters**

- **You cross-checked spot against a second central bank.** ECB reference rate confirmed against Bank of Finland data, both showing 1 EUR = 1.1535 USD for August 7. Verifying a number against an independent source is a genuine data-quality control, and it is the kind of check that catches a transcription error before it propagates through eleven sensitivity rows.
- **`T_DAYS` and `BASIS` stayed separate all the way through.** 365 days to settlement, 360 as the ACT/360 denominator, each carried as its own row with its own classification. You set this up correctly in the Stage 2 spec and it survived three stages intact. Elsewhere in this cohort those two collapsed into a single 360, which silently drops five days of interest from both legs.
- **You chose 12-month Euribor for `R_FC`.** Tenor-matched to the exposure *and* a borrowing rate, which is what the money-market hedge's EUR leg actually is. A government yield would have been easier to source and would have understated the borrowing cost. Much of the cohort used an overnight policy rate here.
- **You disclosed the Euribor publication lag.** As-of 2026-08-06 against a retrieval date of 2026-08-07, with the reason: "latest public observation available because of delayed release." Two dates, both recorded, difference explained.

**To push it further (real-desk nuance)**

- **Your parity check is now circular — say so explicitly.** `F0_in` = 1.1662946810 is CIP-implied from the same `S0_in`, `R_USD`, and `R_FC` that drive the money-market leg. Both legs are built from one input set, so they agree by construction. It confirms your implementation is internally consistent; it cannot detect a wrong input, a wrong convention, or a genuine market dislocation. Your classification column already makes this visible — the forward is tagged CIP-implied, not Live — but the memo should draw the conclusion out loud, because a passing parity check reads to a casual reader as market validation.
- **The real unknown never enters your model.** Since no quoted dealer forward is used, cross-currency basis and dealer spread are invisible by construction. One live quote compared against your 1.1662946810 would turn the parity check from an arithmetic identity into a measurement, and the gap *is* the basis-plus-spread. That single number is the highest-value addition left here.
- **`PREM_PUT` = `PREM_CALL` = 0.0250 with both strikes at spot.** Equal premiums for an at-the-money put and call is what put-call parity roughly implies when the forward sits near spot — but your forward is at a premium (1.1663 vs 1.1535), which should make the call cheaper than the put. Not an error, since both are scenario-given assumptions correctly tagged as such. Worth one sentence noting that the given premiums are not internally consistent with your live forward, so option comparisons carry that caveat.
- **Quantify your data sensitivity.** At a one-year tenor a 25bp error in `R_FC` moves the CIP forward by roughly 0.0028 — about $12,600 on EUR 4.5M. One sentence tells a CFO how much your sourcing decisions are worth in dollars.

**Next — Stage 5**

Hand the workbook and your Stage 2 spec to an LLM, get its analysis, then break it. Recompute at least three outputs by hand with the arithmetic written out — forward proceeds, the put floor, and the crossover spot where the put overtakes the forward (with a premium carried at `R_USD`, that is `F0_in` plus the carried premium; check which convention your workbook uses). Then write the recommendation in a CFO's voice framed on risk tolerance rather than on which strategy tops the grid.

Your spec retrospective has an excellent story ready: the Stage 2 placeholder set was not parity-consistent, your Stage 3 audit caught it, and you fixed the *specification* rather than the workbook. Say why that mattered.

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
