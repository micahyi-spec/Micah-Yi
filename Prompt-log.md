I missed the first few for my prompt log, but going forward I will put all updates in prompt log

1. What do I need to do for this part, explain in order to get meadimum points (Stage 3 — AI-Assisted Build + Audit

**Weight: 17% of projectDeliverables: ****`models/builds/…-model.xlsx`**** + ****`analysis/…-build-audit.md`**

Generate a working workbook **from your own Stage 2 spec** — any AI tool, or by hand — then audit the result ruthlessly. Your graded skill isn't typing formulas; it's **specifying precisely and auditing skeptically** — the two things an analyst still owns when AI does the assembly.

## What you'll learn

- How to drive an AI build from a spec — and why re-explaining mid-chat means your spec has a defect
- What a professional audit of AI output looks like: check, find, fix, document
- Auditable model construction: named ranges, formulas-only, color coding, visible checks

**There is no starter template**

Your spec *is* the template. The instructor workbook exists — as the grading key.

## The build contract

The finished workbook must satisfy all seven, verifiable by inspection — and by the grading script — **regardless of how it was produced**:

| #Requirement |                                                                                                                                                                                                  |
| ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 1            | **All ten named ranges** from the contract, each attached to the right cell                                                                                                                      |
| 2            | **Formulas, never hard-coded values.** Every calculated cell is a formula referencing named ranges — a pasted number where a formula belongs scores zero for that element (checked mechanically) |
| 3            | **Cover page** — scenario, author, date, data-provenance block (placeholders noted as indicative)                                                                                                |
| 4            | **Legend/Key tab** — Yellow = inputs · Blue = assumptions · Green = formulas · Gray = outputs, applied throughout                                                                                |
| 5            | **All three hedge families** — forward; money market in its three explicit steps; put and call with premium cost in USD and proceeds as a function of `S_T`                                      |
| 6            | **Sensitivity table + chart** — ±5% in 1% steps, formula-driven (no hand-typed rows)                                                                                                             |
| 7            | **Validation checks live in the workbook** — the parity check and your spec's §7 check figures, computed, visible, passing                                                                       |

## Run the build — step by step

The spec says *what* to build; this is *how* you run the build, on whichever surface you actually have. Pick your tab — if you've never used an AI coding tool, start with **"Code" Agents**; if you only have a chat window, the **Chat-Only** track gets you all the way to a submitted workbook too. Every track ends the same way: the file on github.com, at the right path, audited by you.

**CLIexpert"Code" AgentsClaude Code / Codex — start hereChat-Onlybasic — claude.ai / ChatGPT**

A coding agent (Claude Code, Codex, and similar) works **inside the repo folder** — it can read the spec and `AGENTS.md`, build the workbook in place, and commit it. You review everything before it lands. This is the closest to how analysts actually work with AI, which is why it's the recommended track.

1 · The repoStage 2 spec committeddocs/specs/…-spec.md2 · Coding agentreads spec + AGENTS.md,builds the workbook3 · You auditopen it, check it againstthe spec's own rules4 · Commit + pushworkbook visible ongithub.com = submittedfound a defect? fix the spec, commit, regenerate

1. **Point the agent at the repo.** Open your terminal (or the tool's app) *in your local clone* of your portfolio repo and start the agent there. Then confirm it's looking at the right place: ask *"Which repo are you in? List its top-level files."* It should name `AGENTS.md` and the spec. If it can't, it's in the wrong folder — fix that before anything else. (Never used one? Ten minutes in the [AI Tools Lab](https://adamwstauffer.github.io/ai-lms/ailab.html) covers install and first launch.)
2. **Prompt the build.** Reference the committed spec, restate that its requirements are binding, say exactly where the file goes, and invite questions:

   **Starter prompt — edit the paths to yours**
   ```
   Read my Stage 2 spec at docs/specs/YYYY-MM-DD-{lastname}-{scenario-slug}-spec.md.
   Build the workbook it specifies. Every requirement in the spec's build contract
   is binding: all ten named ranges, formulas only (no pasted values), cover page,
   Legend/Key tab with the color convention, all three hedge families, the ±5%
   sensitivity table with chart, and the validation checks computed in the workbook.
   Save it as models/builds/YYYY-MM-DD-{lastname}-{scenario-slug}-model.xlsx.
   If anything in the spec is ambiguous, ask me questions before you build.
   ```
3. **Open the workbook and look.** The agent saying "done" is the beginning of your job, not the end of it. Open it in Excel. Do the named ranges exist (Formulas → Name Manager)? Are calculated cells formulas, not typed numbers? Change `S0_in` — does the sensitivity table move? Do your spec's §7 checks pass? What you find goes in your audit note (`analysis/YYYY-MM-DD-{lastname}-build-audit.md`, ≥3 findings).
4. **Iterate through the spec, not the chat.** Every defect you find traces to a spec line that allowed it: fix the spec, commit the fix, tell the agent to regenerate. If you're re-explaining the model in conversation, that's a spec defect by definition.
5. **Land it.** Tell the agent: *"Commit the workbook and the spec changes with a message describing the build, and push."* Then verify like a professional — open the repo on github.com in the browser and confirm the file is at `models/builds/YYYY-MM-DD-{lastname}-{scenario-slug}-model.xlsx`. **If it isn't visible on github.com, it isn't submitted.** Update `prompt-log.md` before you close the session.

## Tool guidance — the contract is graded, not the tool

**Required reading before your first build session**

The [**AI Tools Lab**](https://adamwstauffer.github.io/ai-lms/ailab.html) is the field guide this stage assumes: chat vs "code" tools, web vs desktop vs CLI, and how to give the AI your repo so it checks your conventions instead of guessing them. Ten minutes there decides whether the build is one clean session or an afternoon of flailing.

- **Claude for Excel** — if you have access; availability varies and *don't buy anything*
- **Claude / ChatGPT on the web** — paste or link your spec (GitHub URL is cleanest); ask for the workbook, or for the structure + formulas to assemble yourself
- **Copilot in Excel**
- **Manual build** directly from your spec — always allowed

**Your spec goes in as-is**

If you find yourself re-explaining the model in the chat, that's a spec defect — fix the spec (commit the change), then regenerate. Log every prompt in `prompt-log.md`.

**Feeding context:** best is a GitHub link to your committed spec; medium is uploading the file; last resort is copy-paste. Version-controlled context is the professional pattern — reproducible and auditable.

## The audit note — required, ≥3 findings

AI output is a draft, not a deliverable. Audit the generated workbook against your spec's validation rules and document at least **3 findings** — things you checked and confirmed, or found broken and fixed. Real examples:

- A hardcoded value where a formula belongs
- A named range attached to the wrong cell
- A sign error in the put payoff
- A sensitivity row that doesn't recalculate when inputs change
- The parity check failing because of a rate-basis mismatch (ACT/360 vs ACT/365)

For each finding: **what you checked, what you found, what you did.**

**"Everything was perfect" is a red flag**

Not a good sign — the grader will be auditing the same workbook. An audit that found nothing usually means an audit that looked at nothing.

## Submission checklist

### 🔒Submit Stage 2 to unlock this stage's checklist

This is pacing, not a wall — the whole tutorial above stays open. The checklist and submission unlock once **Stage 2**'s deliverable is on GitHub.

Click below and Kumu will check your repo for `docs/specs/YYYY-MM-DD-{lastname}-{scenario}-spec.md`.

**Check my repo**

🔒 Locked until you submit **Stage 2 — Model Specification** on GitHub. Everything above is yours to read now.

- Workbook generated from the committed spec (prompt logged) or built by hand from it
- All ten named ranges present and attached to the right cells
- Every calculated cell is a formula referencing named ranges — no pasted results
- Cover page + Legend/Key tab; color convention applied throughout
- MM hedge in three explicit steps; put and call payoffs vary with `S_T`
- Sensitivity table ±5% in 1% steps, formula-driven, with chart
- Parity check and spec §7 checks computed in the workbook and passing
- Audit note with ≥3 substantive findings; fixes committed individually
- Workbook at `models/builds/YYYY-MM-DD-{lastname}-{scenario-slug}-model.xlsx`; audit at `analysis/YYYY-MM-DD-{lastname}-build-audit.md`
- `prompt-log.md` updated

## Rubric

| CriterionWeightStrong work looks like |     |                                                                                                                                   |
| ------------------------------------- | --- | --------------------------------------------------------------------------------------------------------------------------------- |
| Contract compliance                   | 50% | Named ranges complete and correct; formulas-only (mechanically checked); all hedges + sensitivity present and computing correctly |
| Structure & presentation              | 25% | Cover, legend/key, color convention, auditable layout                                                                             |
| Audit note                            | 25% | ≥3 substantive findings with evidence; fixes committed)                                                                           |


Read my Stage 2 spec at:

docs/specs/2026-08-07-Yi-eur-receivable-hedge-spec.md

Build the Excel workbook exactly according to the specification.

The following requirements are mandatory:

Include all ten required named ranges and attach each one to the correct input cell.

Every calculated result must use an Excel formula. Do not paste calculated numbers.

Include a Cover page with the scenario, Micah Yi as author, date, and a data-provenance section explaining that Stage 3 uses indicative placeholder market data.

Include a Legend/Key tab using:Yellow = inputsBlue = assumptionsGreen = formulasGray = outputs

Include the forward hedge.

Include the money-market hedge in three visible steps:borrow EUR,convert EUR to USD,invest USD.

Include both put and call option calculations, including premium cost in USD and payoff/proceeds based on S_T.

Include a formula-driven sensitivity table from 0.95 × S0_in through 1.05 × S0_in in 1% increments.

Include a comparison chart.

Include visible validation checks, including covered interest parity and the validation checks defined in the specification.

Save the completed workbook as:

models/builds/2026-08-07-Yi-eur-receivable-hedge-model.xlsx

Do not change the model logic from the
