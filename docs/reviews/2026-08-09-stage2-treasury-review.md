# Stage 2 review — EUR receivable · Treasury sign-off

Micah — this is the most complete spec in the cohort, and the opening blockquote sets the correct standard for what a spec is: "precisely enough that an AI or another analyst could build or rebuild the workbook without additional instructions." The word doing the work is **rebuild**. A spec that only supports a first build is documentation; one that supports a rebuild is a contract.

| Criterion | Score |
|---|---|
| Named-range contract & tab architecture | 30 / 30 |
| Calculation flow | 30 / 30 |
| Validation & sensitivity plan | 20 / 20 |
| Reproducibility & prompt log | 20 / 20 |
| **Total** | **100 / 100** |

**What you did well — and why it matters**

- **You made the exposure concrete with a worked number.** "A decrease in EUR/USD from 1.10 to 1.00 would reduce the unhedged USD value of the €4,500,000 receivable from $4,950,000 to $4,500,000." One sentence, one arithmetic example, and the reader feels the risk. Abstract statements about currency exposure do not land; $450,000 does.
- **You separated `T_DAYS` from `BASIS` as distinct named ranges.** This sounds minor and is not. `T_DAYS` is the actual elapsed days to settlement (365); `BASIS` is the day-count denominator (360). They are different quantities that happen to be similar numbers, and collapsing them into one — which happened elsewhere in this cohort — silently drops five days of interest from both legs of every carry calculation. You got the distinction right in the spec and it held all the way through Stage 4.
- **You named the specific model version.** "ChatGPT (GPT-5.6 Sol) — used to draft and refine the technical specification from the Stage 1 memo and course template." Model, version, and the division of labour between draft and refinement.
- **You versioned at 0.2 with created and updated fields** — and then actually bumped it when your Stage 3 audit changed the assumption set, which is the part most people skip.

**To push it further (real-desk nuance)**

- **Your title says "Company."** The header reads "Company — EUR Receivable FX Transaction Hedge Model." Everything else in the document is specific; the subject is a placeholder. Give the firm the scenario name so the artifact is self-identifying when someone opens it cold.
- **Pre-commit the parity tolerance numerically.** You specify the CIP check, which is what let your Stage 3 audit catch a real inconsistency. Go one step further and state how close `F_implied` must sit to `F0_in` before it passes — a rate tolerance like 0.0001 USD/EUR, or 0.05% of notional. Deciding before you see the answer is what keeps the band honest.
- **Say what the sensitivity exhibit is *for*.** You specify the 95–105% grid in 1% steps with a chart. Add the management question it answers — "at what settlement rate does the recommendation change?" — so the exhibit carries a thesis rather than just a shape. That crossover rate is the single most useful number you will produce at Stage 5.
- **`K_PUT = K_CALL = S0_in` is worth a sentence.** Both at-the-money is a clean convention, but it means the put and call are two separate at-the-money positions rather than a collar. State that they are alternatives being compared, not a structure being proposed — otherwise a reader may assume you are recommending both.

**Next — Stages 3 and 4**

Both are in and reviewed separately. Your Stage 3 audit did the single most important thing available at that stage, and I take it up there.

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
