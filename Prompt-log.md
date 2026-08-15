# AI Prompt Log — FIN 321 FX Hedging Project

**Student:** Micah Yi  
**Course:** FIN 321 — International Business Finance  
**Section:** 701  
**Project:** FX Transaction Hedging Project  
**Scenario:** €4,500,000 EUR Receivable  
**Primary AI Tool:** ChatGPT  
**Project Dates:** 2026-07-31 through 2026-08-07  

---

## Purpose of This Log

This document records the material AI prompts used throughout the FIN 321 FX Hedging Project.

The project used AI across several stages:

1. Stage 1 — Decision / Framing Memo
2. Stage 2 — Model Specification
3. Stage 3 — AI-Assisted Excel Build
4. Workbook Audit and Corrections
5. Market-Data Review
6. Stage 2 / Stage 3 Alignment
7. GitHub Formatting and Submission
8. Audit Documentation
9. Prompt Documentation

The purpose of this log is to show not only where AI was used to generate content, but also where AI output was reviewed, questioned, corrected, and regenerated.

Where the exact original prompt is available, it is reproduced below. Where only the project record is available, the entry is clearly labeled as reconstructed rather than presented as a verbatim prompt.

---

# Stage 1 — Decision / Framing Memo

## Prompt 1 — Create the Initial EUR Receivable Risk Memo

**Date:** 2026-07-31  
**Tool:** ChatGPT  
**Prompt Type:** Initial drafting  
**Status:** Reconstructed from project record

### Prompt / Instruction

Create a decision memo for a company that expects to receive a €4,500,000 EUR receivable one year from today.

The memo should explain the foreign-exchange exposure created by the EUR receivable and introduce the main alternatives available to manage the exposure, including a forward/futures hedge, money-market hedge, and currency options.

Follow the decision-memo template and prepare the document for the GitHub repository under `docs/decisions/`.

### Why I Used AI

I used AI to organize the financial problem into a professional decision memo before designing the quantitative model.

### AI Output

The draft explained that the company would receive a fixed €4,500,000 but that the USD value would change with EUR/USD.

It used the example that a decline from 1.10 USD/EUR to 1.00 USD/EUR would reduce the USD proceeds from $4,950,000 to $4,500,000.

The memo introduced:

- Forward/futures contracts
- Money-market hedging
- Currency options

### My Review / Revision

I reviewed the memo against the required template and later discovered that required YAML metadata was missing from the top of the document.

---

## Prompt 2 — Restore the Required YAML Frontmatter

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Formatting correction  
**Status:** Exact prompt

### Prompt

> Add the template's YAML frontmatter — the `---` fenced block at the very top of the file (above the `#` title) holding `title`, `author`, `date`, and `version`. Yours jumps straight into the heading; copy that block back in from the decision-memo template and fill it in.

### Why I Used AI

The memo content was complete, but the GitHub document did not fully comply with the required template.

### Problem Identified

The file began directly with the Markdown heading instead of the required YAML frontmatter.

### Correction

The document was revised to include metadata for:

- `title`
- `author`
- `date`
- `version`

### Result

The Stage 1 memo was brought back into compliance with the GitHub decision-memo template.

---

# Stage 2 — Model Specification

## Prompt 3 — Convert the Memo Into a Model Specification

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Technical design  
**Status:** Exact prompt

### Prompt

> Stage 2 — turn the memo into a model specification.
>
> In `docs/specs/`, write the named-range contract, tab architecture, calculation flow, and validation checks — precise enough that an AI could build the workbook from the spec alone.

### Why I Used AI

Stage 2 required the financial model to be completely designed before creating the Excel workbook.

The specification needed to function as the prompt for the Stage 3 workbook build.

### Required Design Areas

The specification needed to define:

- Problem statement
- Inputs
- Named ranges
- Workbook tabs
- Assumptions
- Forward hedge
- Money-market hedge
- Options
- Sensitivity analysis
- Validation checks
- Outputs

### Result

AI produced the first technical design for the workbook.

---

## Prompt 4 — Provide the Full Stage 2 Assignment Requirements

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Requirements/context  
**Status:** Exact assignment content supplied to AI

### Prompt / Context Supplied

> # Stage 2 — Model Specification
>
> Weight: 21% of project
>
> Deliverable:
>
> `docs/specs/YYYY-MM-DD-{lastname}-{scenario-slug}-spec.md`
>
> Design the workbook before any Excel exists: every input, name, formula, and check — written down precisely enough that an AI, or a colleague who has never seen your memo, could build the complete workbook from this document alone.
>
> The eight required sections are:
>
> 1. Problem statement
> 2. Inputs — the named-range contract
> 3. Tab architecture
> 4. Assumptions & constraints
> 5. Calculation flow
> 6. Sensitivity plan
> 7. Validation rules
> 8. Outputs

### Why I Supplied This

I wanted the specification to follow the professor's grading requirements rather than use a generic financial-model format.

### Result

The requirements were incorporated into the specification.

---

## Prompt 5 — Supply the Required Named-Range Contract

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Model requirements  
**Status:** Exact assignment content supplied to AI

### Required Names Supplied

> `FC_AMT`
>
> `S0_in`
>
> `F0_in`
>
> `R_USD`
>
> `R_FC`
>
> `K_PUT`
>
> `K_CALL`
>
> `PREM_PUT`
>
> `PREM_CALL`
>
> `T_DAYS`

### Why This Was Important

The assignment stated that these names are shared across:

- The specification
- Excel workbook
- Grading script
- LLM prompts

The names therefore needed to be used exactly.

### Result

All ten standardized names were incorporated into the Stage 2 specification and later the Stage 3 workbook.

---

## Prompt 6 — Supply the Required Forward Hedge Logic

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Model logic  
**Status:** Exact assignment content supplied to AI

### Formula Supplied

> USD proceeds = FC_AMT × F0_in

### Result

The specification defined the forward hedge as a locked USD settlement amount using the required named-range notation.

---

## Prompt 7 — Supply the Three-Step Money-Market Hedge Logic

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Model logic  
**Status:** Exact assignment content supplied to AI

### Formula Supplied

> Step 1 — Borrow FC today:
>
> `Borrow = FC_AMT / (1 + R_FC × T_DAYS/360)`
>
> Step 2 — Convert at spot:
>
> `USD_now = Borrow × S0_in`
>
> Step 3 — Invest in USD:
>
> `Proceeds = USD_now × (1 + R_USD × T_DAYS/360)`

### Important Requirement

Each step needed to appear separately in Excel rather than being hidden inside one nested formula.

### Result

The Stage 2 specification required a visible:

**Borrow EUR → Convert EUR to USD → Invest USD**

pipeline.

---

## Prompt 8 — Supply the Covered Interest Parity Validation

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Validation design  
**Status:** Exact assignment content supplied to AI

### Formula Supplied

> `F_implied = S0_in × (1 + R_USD × T/360) / (1 + R_FC × T/360) ≈ F0_in`

### Why It Was Included

The assignment identified covered interest parity as a built-in error detector.

### Result

The Stage 2 specification included parity validation comparing:

- Implied forward rate
- Forward input
- Forward hedge proceeds
- Money-market hedge proceeds

This check later identified a real Stage 3 inconsistency.

---

## Prompt 9 — Supply the Put Option Logic

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Model logic  
**Status:** Exact assignment content supplied to AI

### Formula Supplied

> Net proceeds at settlement spot `S_T`:
>
> `= FC_AMT × max(S_T, K_PUT) − FC_AMT × PREM_PUT`

### Result

The specification incorporated the put-option floor and later expanded premium treatment so the workbook could compare settlement-date proceeds consistently.

---

## Prompt 10 — Make the Entire Specification GitHub-Ready

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Formatting  
**Status:** Exact prompt

### Prompt

> Write the entire thing in code so that I can use it in Github

### Why I Used AI

The specification needed to be copied directly into a `.md` file in the repository.

### Result

The specification was rewritten as GitHub-ready Markdown.

---

## Prompt 11 — Provide the Official Specification Template

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Template correction  
**Status:** Exact prompt

### Prompt

> Here is the spec template

### Why I Used AI

The first draft needed to be aligned with the official template supplied for the project.

### Result

The template became the structure for the revised technical specification.

---

## Prompt 12 — Rewrite the Finished Specification Using the Exact Template

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Major revision  
**Status:** Exact prompt

### Prompt

> Use this template and rewrite the entire finished spec inside one GitHub-ready Markdown code block using this exact template and your €4,500,000 EUR receivable scenario.

### Why I Used AI

The specification needed to be both technically complete and formatted exactly like the project template.

### Result

The revised specification documented:

- €4,500,000 receivable
- USD functional currency
- EUR/USD quote convention
- Ten standardized named ranges
- ACT/360 basis
- Forward hedge
- Money-market hedge
- Put option
- Call-option compatibility
- Covered interest parity
- Sensitivity analysis
- Validation checks
- Required outputs
- Auditability requirements
- Stage 4 data sourcing

---

## Prompt 13 — Establish the Required Specification Filename

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Repository naming  
**Status:** Exact prompt

### Prompt

> YYYY-MM-DD-Yi-{scenario-slug}-spec.md

### Result

The specification was assigned:

`docs/specs/2026-08-07-Yi-eur-receivable-hedge-spec.md`

---

# Stage 3 — Assignment Planning

## Prompt 14 — Explain Stage 3 and How to Earn Points

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Assignment planning  
**Status:** Exact prompt

### Prompt

> What do I need to do for this part, explain in order to get meadimum points

### Context Supplied

I provided the full Stage 3 — AI-Assisted Build + Audit instructions.

### Why I Used AI

Before building the workbook, I wanted the Stage 3 assignment translated into an ordered checklist.

### Result

The process was organized around:

1. Build from the committed Stage 2 spec.
2. Verify named ranges.
3. Verify formulas.
4. Verify workbook structure.
5. Verify all hedge families.
6. Verify sensitivity analysis.
7. Verify validation checks.
8. Audit the workbook.
9. Record at least three findings.
10. Commit workbook, audit, and prompt log.

---

# Stage 3 — Initial Workbook Build

## Prompt 15 — Build the Excel Workbook From the Specification

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Workbook generation  
**Status:** Exact prompt

### Prompt

> Read my Stage 2 spec at:
>
> `docs/specs/2026-08-07-Yi-eur-receivable-hedge-spec.md`
>
> Build the Excel workbook exactly according to the specification.
>
> The following requirements are mandatory:
>
> 1. Include all ten required named ranges and attach each one to the correct input cell.
> 2. Every calculated result must use an Excel formula. Do not paste calculated numbers.
> 3. Include a Cover page with the scenario, Micah Yi as author, date, and a data-provenance section explaining that Stage 3 uses indicative placeholder market data.
> 4. Include a Legend/Key tab using:
>    Yellow = inputs
>    Blue = assumptions
>    Green = formulas
>    Gray = outputs
> 5. Include the forward hedge.
> 6. Include the money-market hedge in three visible steps:
>    borrow EUR,
>    convert EUR to USD,
>    invest USD.
> 7. Include both put and call option calculations, including premium cost in USD and payoff/proceeds based on `S_T`.
> 8. Include a formula-driven sensitivity table from `0.95 × S0_in` through `1.05 × S0_in` in 1% increments.
> 9. Include a comparison chart.
> 10. Include visible validation checks, including covered interest parity and the validation checks defined in the specification.
>
> Save the completed workbook as:
>
> `models/builds/2026-08-07-Yi-eur-receivable-hedge-model.xlsx`
>
> Do not change the model logic from the specification.

### Why I Used AI

This was the primary Stage 3 build prompt.

The specification was intended to function as the instructions for the AI workbook builder.

### Result

The generated workbook contained nine tabs:

1. `Cover`
2. `Legend_Key`
3. `Inputs`
4. `Forward_Hedge`
5. `Money_Market_Hedge`
6. `Option_Hedge`
7. `Sensitivity`
8. `Validation`
9. `Notes_Assumptions`

---

# Stage 3 — Data Accuracy / Verification

## Prompt 16 — Verify the Data Using Reliable Sources

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Data verification  
**Status:** Exact prompt

### Prompt

> Correct and make sure each piece of data is accurate and use multiple reliable sources to check

### Why I Used AI

I wanted to distinguish actual market information from placeholders before treating the workbook inputs as verified.

### Review Performed

The later verification work distinguished among:

- Verified market data
- Public-market proxies
- Model-implied values
- Analyst assumptions
- Unverified placeholders

### Market-Data Review Recorded in the Project

The review identified:

- EUR/USD spot of approximately `1.1535` from ECB data and a Bank of Finland cross-check in the separate market-data verification iteration.
- `R_USD = 0.0401` as a USD rate proxy.
- `R_FC = 0.02898` as a public 12-month Euribor reference.
- `F0_in` as model-implied rather than a verified dealer forward quote.
- Put/call premiums as unverified placeholders.

### Important Stage Distinction

These market-data checks did not change the purpose of the Stage 3 submission.

Stage 3 still uses clearly identified indicative placeholders for the model build, while live/verified data are handled separately in the market-data stage.

---

# Stage 3 — Prompt Log Request

## Prompt 17 — Create the First Prompt Log

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Documentation  
**Status:** Exact prompt

### Prompt

> Create a prompt log

### Result

An initial `prompt-log.md` was drafted.

---

## Prompt 18 — Expand the Log to Include the Whole GitHub Project

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Documentation expansion  
**Status:** Exact prompt

### Prompt

> All the prompts related to this github project list out all of the prompts used

### Why I Used AI

The first prompt log was too narrow.

I wanted the log to document the entire AI-assisted project rather than only the final workbook-generation prompt.

### Result

The prompt log was expanded to include the memo, specification, workbook build, verification, and audit workflow.

---

# Stage 3 — Build Contract Verification

## Prompt 19 — Re-Supply the Official Build Contract

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Requirements verification  
**Status:** Exact project instructions supplied

### Prompt / Context

> ## Goal
>
> Generate a working workbook from your own Phase 2 specification — using any AI tool or by hand — and audit the result.
>
> ## The build contract
>
> 1. All ten named ranges attached to the right cells.
> 2. Formulas, never hard-coded values.
> 3. Cover page.
> 4. Legend/Key tab.
> 5. All three hedge families.
> 6. Sensitivity table + chart.
> 7. Validation checks live in the workbook.

### Why I Supplied This Again

I wanted the workbook evaluated directly against the grading contract rather than only against the earlier model specification.

### Result

This became the checklist used for the later workbook audit.

---

# Stage 3 — Deliverables Clarification

## Prompt 20 — Ask How to Complete the Deliverables

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Assignment clarification  
**Status:** Exact prompt

### Prompt

> How do I do these deliverables

### Context Supplied

The required Stage 3 deliverables were:

- Workbook
- Audit note
- Updated prompt log

### Result

The required repository paths were identified as:

`models/builds/2026-08-07-Yi-eur-receivable-hedge-model.xlsx`

`analysis/2026-08-07-Yi-build-audit.md`

`prompt-log.md`

---

## Prompt 21 — Provide the Complete Stage 3 Assignment Page

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Grading clarification  
**Status:** Exact assignment content supplied

### Key Instructions Supplied

> Submit
>
> Commit & push the workbook + audit note + prompt log; submit links via Lamaku.
>
> Audit the generated workbook against your spec's validation rules and document at least 3 findings.
>
> For each:
>
> what you checked,
> what you found,
> what you did.
>
> "Everything was perfect" is a red flag, not a good sign.
>
> Commit incrementally — generation, then each audit fix.

### Why This Was Important

This clarified that simply generating the workbook was not enough.

The audit and Git history were part of the graded work.

---

# Stage 3 — Workbook Audit

## Prompt 22 — Audit and Correct the Excel Workbook

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Workbook audit  
**Status:** Exact prompt

### Prompt

> Audit and correct the Excel workbook itself against these seven grading requirements

### Why I Used AI

The initial AI-generated workbook needed to be treated as a draft.

The goal was to inspect the workbook against the same requirements the grading script would evaluate.

### Audit Areas

The audit inspected:

- Worksheet structure
- Defined names
- Input cells
- Formulas
- Forward hedge
- Money-market hedge
- Put option
- Call option
- Sensitivity table
- Chart
- Validation checks
- Formula errors

---

## Prompt 23 — Covered Interest Parity Defect Identified During Audit

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Audit finding / correction  
**Status:** Correction generated from Prompt 22

### What Was Checked

The workbook compared:

`F0_in`

against:

`F_implied = S0_in × (1 + R_USD × T_DAYS/BASIS) / (1 + R_FC × T_DAYS/BASIS)`

### Original Stage 3 Inputs

`S0_in = 1.1000`

`F0_in = 1.1000`

`R_USD = 5.30%`

`R_FC = 3.00%`

`T_DAYS = 365`

`BASIS = 360`

### Problem Found

The original `F0_in = 1.1000` was inconsistent with the other assumptions.

The implied rate was:

`F_implied ≈ 1.1248941906`

Therefore, the parity validation did not pass.

### Correction

The Stage 3 forward placeholder was changed to:

`F0_in = 1.1248941906`

### Important Qualification

This value was documented as:

**CIP-consistent indicative placeholder**

and not as:

**live dealer forward quote**

### Result

The covered-interest-parity check passed after the correction.

---

## Prompt 24 — Tighten the Formula-Driven Sensitivity Calculations

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Audit correction  
**Status:** Generated as part of workbook audit

### Problem Reviewed

The sensitivity analysis needed to remain mechanically formula-driven and respond to the required named inputs.

### Correction

The hedge-profit formulas were tightened so they directly reference the model logic and named inputs rather than depending on pasted calculated values.

### Sensitivity Structure Confirmed

The model uses 11 scenarios:

- 95%
- 96%
- 97%
- 98%
- 99%
- 100%
- 101%
- 102%
- 103%
- 104%
- 105%

### Result

The sensitivity table remained formula-driven from `0.95 × S0_in` through `1.05 × S0_in`.

---

## Prompt 25 — Correct the Call-Option Presentation

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Audit correction  
**Status:** Generated as part of workbook audit

### Requirement Reviewed

The Stage 3 build contract required both put and call calculations, including:

- Premium cost in USD
- Payoff/proceeds based on `S_T`

### Issue

The put option was the economically relevant downside hedge for a EUR receivable, but the call calculation still needed to be explicitly visible for build-contract compliance.

### Correction

An explicit sensitivity output was added:

`Call Strategy Proceeds (Illustrative)`

### Formula Logic

`USD_CALL_ILLUSTRATIVE(S_T)`

was defined as the EUR receivable converted at `S_T`, plus the call payoff, less the settlement-date value of the call premium.

### Result

The workbook includes both required option families while clearly labeling the call as illustrative rather than the primary downside hedge.

---

## Prompt 26 — Run the Formula-Error Audit

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Technical verification  
**Status:** Generated as part of workbook audit

### Checks Performed

The final workbook was scanned for:

- `#REF!`
- `#DIV/0!`
- `#VALUE!`
- `#NAME?`
- `#N/A`

### Result

No major Excel formula errors were identified in the corrected workbook.

---

# Stage 2 / Stage 3 Alignment

## Prompt 27 — Correct the Specification to Match Stage 3

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Specification correction  
**Status:** Exact prompt

### Prompt

> Fix the spec so that it reflects the stage 3 workbook

### Why I Used AI

The Stage 3 audit revealed that the original specification allowed an internally inconsistent forward placeholder.

The project instructions stated that defects discovered during Stage 3 should be corrected in the specification rather than re-explained only in chat.

### Changes Made

The specification was revised to include:

- `F0_in = 1.1248941906`
- CIP-consistent placeholder explanation
- Nine-tab Stage 3 architecture
- Stage 3 color convention
- `BASIS`
- `SENS_LOW`
- `SENS_STEP`
- Explicit call calculations
- Call Strategy Proceeds (Illustrative)
- Required passing parity checks
- Separate model-integrity and market-data status
- Stage 3 audit revision
- Version 0.3

### Result

The Stage 2 specification and Stage 3 workbook were aligned.

---

## Prompt 28 — Make the Corrected Specification Match the Previous GitHub Formatting

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** GitHub formatting correction  
**Status:** Exact prompt

### Prompt

> Make sure it is github code formatted properly just like the previous spec

### Why I Used AI

The corrected technical content needed to retain the same GitHub Markdown structure and presentation as the earlier specification.

### Result

The corrected specification was exported as GitHub-ready Markdown.

### Final Path

`docs/specs/2026-08-07-Yi-eur-receivable-hedge-spec.md`

---

# Stage 3 — Workbook Clarification

## Prompt 29 — Ask What the Workbook Is

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Submission clarification  
**Status:** Exact prompt

### Prompt

> What is the workbook

### Result

AI clarified that the workbook is the actual `.xlsx` financial model rather than the Markdown specification.

### Required Workbook Path

`models/builds/2026-08-07-Yi-eur-receivable-hedge-model.xlsx`

### Workbook Tabs

1. Cover
2. Legend_Key
3. Inputs
4. Forward_Hedge
5. Money_Market_Hedge
6. Option_Hedge
7. Sensitivity
8. Validation
9. Notes_Assumptions

---

# Stage 3 — GitHub Upload

## Prompt 30 — Ask How to Put the Workbook on GitHub

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Repository assistance  
**Status:** Exact prompt

### Prompt

> How do I put it in github

### Why I Used AI

I needed to place the binary `.xlsx` workbook in the exact repository location required by the assignment.

### Result

AI explained how to:

1. Open the repository.
2. Navigate to `models/builds/`.
3. Use **Add file → Upload files**.
4. Upload the `.xlsx` workbook.
5. Commit the workbook.

---

## Prompt 31 — GitHub Screenshot: Correct Upload Location

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Screenshot-based navigation  
**Status:** User supplied screenshot

### Context

I provided a screenshot showing GitHub at:

`Micah-Yi / models / builds /`

while on the **Create new file** screen.

### AI Guidance

AI identified that the repository was already in the correct `models/builds/` folder but that **Create new file** was the wrong action for an Excel workbook.

### Correction

The recommended workflow was:

**Cancel changes → Add file → Upload files**

rather than trying to create the `.xlsx` file as text.

---

## Prompt 32 — GitHub Screenshot: Verify Uploaded Workbook

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Submission verification  
**Status:** User supplied screenshot

### Context

I supplied another screenshot showing the workbook inside:

`models/builds/`

### Issue Identified

The visible workbook filename appeared to include:

`-verified.xlsx`

rather than the exact required assignment filename.

### Required Filename

`2026-08-07-Yi-eur-receivable-hedge-model.xlsx`

### Required Path

`models/builds/2026-08-07-Yi-eur-receivable-hedge-model.xlsx`

### Result

AI recommended replacing/renaming the workbook so the grading script could locate the exact required path.

---

# Stage 3 — Audit Note

## Prompt 33 — Build the Audit

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Documentation  
**Status:** Exact prompt

### Prompt

> Build the audit

### Why I Used AI

The assignment requires a Markdown audit note with at least three substantive findings.

Each finding must document:

**What I checked → What I found → What I did**

### Result

The audit note was prepared for:

`analysis/2026-08-07-Yi-build-audit.md`

### Findings Documented

The audit included six substantive findings:

1. Covered-interest-parity failure
2. Required named-range verification
3. Money-market hedge structure
4. Sensitivity-table recalculation
5. Call-option requirement
6. Formula-error scan

---

## Prompt 34 — Audit Finding: Covered Interest Parity

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Audit documentation

### What Was Documented

**Checked:** Forward vs. money-market parity.

**Found:** Original `F0_in = 1.1000` did not agree with the implied forward rate.

**Action:** Corrected the specification and Stage 3 placeholder to `1.1248941906`, regenerated/rechecked the model, and confirmed PASS.

---

## Prompt 35 — Audit Finding: Named Ranges

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Audit documentation

### What Was Documented

**Checked:** All ten standardized named ranges.

**Found:** All ten required names were present.

**Action:** Retained the names and documented helper names separately.

### Required Names

`FC_AMT`

`S0_in`

`F0_in`

`R_USD`

`R_FC`

`K_PUT`

`K_CALL`

`PREM_PUT`

`PREM_CALL`

`T_DAYS`

---

## Prompt 36 — Audit Finding: Money-Market Pipeline

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Audit documentation

### What Was Documented

**Checked:** Whether the money-market hedge used three explicit calculations.

**Found:** Borrow EUR, convert to USD, and invest USD were visible separately.

**Action:** Retained the three-step design and verified the final proceeds against the forward hedge.

---

## Prompt 37 — Audit Finding: Sensitivity Table

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Audit documentation

### What Was Documented

**Checked:** Whether the sensitivity scenarios were formula-driven.

**Found:** The workbook contained 11 scenarios from 95% to 105%.

**Action:** Retained the sensitivity structure and tightened formulas where necessary.

---

## Prompt 38 — Audit Finding: Call Option

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Audit documentation

### What Was Documented

**Checked:** Whether the call calculation met the build contract.

**Found:** A visible `S_T`-dependent call strategy was needed for full compliance.

**Action:** Added and documented `Call Strategy Proceeds (Illustrative)`.

---

## Prompt 39 — Audit Finding: Formula Errors

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Audit documentation

### What Was Documented

**Checked:** Common Excel formula errors.

**Found:** No `#REF!`, `#DIV/0!`, `#VALUE!`, `#NAME?`, or `#N/A` errors after corrections.

**Action:** No further formula-error correction was required.

---

# Prompt Documentation — Final Iterations

## Prompt 40 — Recreate the Prompt Log

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Documentation revision  
**Status:** Exact prompt

### Prompt

> Create the prompt log again

### Why I Used AI

Additional Stage 3 work had occurred after the original prompt log was created.

The log therefore needed to include:

- Workbook audit
- Parity correction
- Call-option correction
- Stage 2 spec correction
- GitHub formatting
- GitHub upload
- Audit note creation

### Result

The prompt log was rebuilt to reflect the later stages of the project.

---

## Prompt 41 — Request a More Detailed Complete Prompt Log

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Final documentation revision  
**Status:** Exact prompt

### Prompt

> Create more detailed prompt logs with all prompts used within this project

### Why I Used AI

The earlier prompt log summarized the major AI interactions but did not show enough detail about the iterative workflow.

### Goal

Create a final prompt log showing:

- What was asked
- Why AI was used
- What AI produced
- What problems were discovered
- What corrections were made
- How the specification and workbook evolved

---

# Summary of AI-Assisted Iterations

The project did not use AI as a one-step workbook generator.

The actual workflow was:

### 1. Frame the Problem

Create a professional memo describing the €4,500,000 EUR receivable exposure.

### 2. Correct the Memo

Restore the required YAML metadata and GitHub template structure.

### 3. Design Before Building

Translate the memo into a technical specification.

### 4. Standardize the Model

Use the ten required named ranges and named-range notation instead of relying on Excel cell addresses.

### 5. Specify the Hedge Logic

Document:

- Forward hedge
- Three-step money-market hedge
- Put option
- Call calculation
- Covered interest parity

### 6. Specify the Sensitivity Analysis

Require `S_T` scenarios from:

`0.95 × S0_in`

through:

`1.05 × S0_in`

in 1% increments.

### 7. Generate the Workbook

Use the Stage 2 specification as the primary build prompt.

### 8. Review the Build Contract

Compare the workbook against the seven mechanically verifiable requirements.

### 9. Audit the AI Output

Inspect formulas, names, calculations, sensitivity analysis, chart, and validation.

### 10. Find a Real Defect

Identify that the original `F0_in = 1.1000` was inconsistent with the Stage 2 interest-rate assumptions.

### 11. Trace the Defect Back to the Specification

Recognize that the problem was not merely an Excel formatting issue.

The specification itself allowed an inconsistent Stage 3 placeholder.

### 12. Correct the Specification

Change the Stage 3 placeholder to:

`F0_in = 1.1248941906`

and explicitly label it as CIP-consistent and indicative.

### 13. Correct the Workbook

Regenerate/revise the workbook so the required parity validation passes.

### 14. Improve Option Compliance

Make the call calculation explicitly visible as a function of `S_T`.

### 15. Verify Formula Integrity

Scan for common Excel formula errors.

### 16. Align Stage 2 and Stage 3

Update the specification so it accurately describes the audited workbook.

### 17. Document the Audit

Create at least three substantive audit findings using:

**What I checked → What I found → What I did**

### 18. Prepare the GitHub Deliverables

Final required files:

`docs/specs/2026-08-07-Yi-eur-receivable-hedge-spec.md`

`models/builds/2026-08-07-Yi-eur-receivable-hedge-model.xlsx`

`analysis/2026-08-07-Yi-build-audit.md`

`Prompt-log.md`

---

# Key AI-Identified Defect and Human Review

The most important iteration in this project was the covered-interest-parity issue.

The initial Stage 3 model used:

| Input | Original Value |
|---|---:|
| `S0_in` | 1.1000 |
| `F0_in` | 1.1000 |
| `R_USD` | 5.30% |
| `R_FC` | 3.00% |
| `T_DAYS` | 365 |
| `BASIS` | 360 |

These assumptions imply:

`F_implied = S0_in × (1 + R_USD × T_DAYS/BASIS) / (1 + R_FC × T_DAYS/BASIS)`

which produces approximately:

`1.1248941906 USD/EUR`

The original `F0_in` therefore failed the Stage 3 parity validation.

Instead of changing the validation rule to make the workbook appear correct, the underlying specification was corrected.

The Stage 3 placeholder became:

`F0_in = 1.1248941906`

and was labeled:

**Indicative CIP-consistent placeholder — replace with live market data at Stage 4.**

This correction demonstrates the intended project workflow:

**AI output → audit → identify defect → trace defect → correct specification → correct workbook → validate again**

---

# AI Use Statement

ChatGPT was used throughout this project as a drafting, technical-design, spreadsheet-building, auditing, verification, formatting, and documentation assistant.

AI output was not treated as automatically correct.

The project included multiple review and correction cycles. The most significant audit finding was an inconsistency between the original forward-rate placeholder and the interest-rate assumptions used by the money-market hedge.

The inconsistency was traced back to the Stage 2 specification, the specification was revised, the workbook was corrected, and the validation was rerun.

AI was also used to review the workbook's:

- Named ranges
- Formula structure
- Forward hedge
- Money-market hedge
- Put option
- Call calculation
- Sensitivity analysis
- Chart
- Covered-interest-parity checks
- Formula errors
- GitHub file structure
- Audit documentation

The final workflow was:

**Frame → Specify → Build → Audit → Identify → Correct → Rebuild → Validate → Document → Commit**

---

# Final Project Files

## Stage 1 Decision Memo

Stored under:

`docs/decisions/`

## Stage 2 Model Specification

`docs/specs/2026-08-07-Yi-eur-receivable-hedge-spec.md`

## Stage 3 Excel Workbook

`models/builds/2026-08-07-Yi-eur-receivable-hedge-model.xlsx`

## Stage 3 Build Audit

`analysis/2026-08-07-Yi-build-audit.md`

## AI Prompt Log

`Prompt-log.md`

---

# Prompt Log Integrity Note

This log is intended to document the material AI interactions that affected the FIN 321 FX Hedging Project.

Prompts reproduced from the available conversation are identified as exact prompts.

Some earlier interactions are reconstructed from the resulting project documents and project history because the complete verbatim chat text was not available when this final log was assembled. Those entries are identified as reconstructed rather than being presented as exact quotations.

This distinction is intentional so that the prompt log does not claim that reconstructed wording is a verbatim historical prompt.

---

# Stage 4 — Market Data + Population

## Prompt 42 — Provide the Full Stage 4 Assignment

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Assignment requirements / market-data research  
**Status:** Exact prompt supplied by user

### Prompt

> # Stage 4 — Market Data + Population
>
> **Weight: 12% of project**
>
> **Deliverables:** `data/…-market-data.md` + re-committed workbook
>
> Replace your placeholders with **live market data**, document exactly where every number came from, and confirm the model survives contact with reality.
>
> Retrieve, as of market close on the day you begin:
>
> - `S0_in` — EURUSD spot
> - `R_USD`, `R_FC` — 1-year rates
> - `F0_in` — 1-year forward, or compute the CIP-implied forward
> - `K_PUT`, `K_CALL` — strikes at or near live spot
> - `PREM_PUT`, `PREM_CALL` — keep scenario-given premiums
> - `FC_AMT`, `T_DAYS` — from the scenario
>
> Then:
>
> 1. Write the market-data memo.
> 2. Populate the workbook.
> 3. Re-run the checks.
> 4. Cross-check against the FX Hedging Lab.
>
> The CIP-implied forward formula is:
>
> `F0 = S0 × (1 + R_USD × T/360) / (1 + R_FC × T/360)`

### Why I Used AI

I supplied the full Stage 4 instructions so AI could help identify the required live market inputs, document provenance, populate the workbook, rerun the model checks, and prepare the required GitHub deliverables.

### Result

The Stage 4 workflow was organized around:

1. Retrieving dated market inputs.
2. Documenting every source and timestamp.
3. Computing a CIP-implied forward when a directly comparable live forward quote was not available.
4. Populating the existing workbook through the named input cells.
5. Re-running all validation checks.
6. Cross-checking the results with the FIN 321 FX Hedging Lab.
7. Updating the prompt log.

---

## Prompt 43 — Complete Stage 4

**Date:** 2026-08-07  
**Tool:** ChatGPT  
**Prompt Type:** Execution request  
**Status:** Exact prompt

### Prompt

> complete

### Why I Used AI

After reviewing the Stage 4 requirements, I asked AI to complete the Stage 4 deliverables and workbook population.

### AI-Assisted Work

AI helped:

- Research the dated EUR/USD spot rate.
- Select a one-year USD interest-rate proxy.
- Select a one-year EUR benchmark.
- Compute the CIP-implied forward.
- Set the put and call strikes at the live spot.
- Retain the scenario-given option premiums.
- Populate the Stage 4 workbook.
- Re-run validation checks.
- Create the market-data provenance memo.
- Prepare a Stage 4 prompt-log addition.

### Stage 4 Values Used

FC_AMT    = 4,500,000 EUR
S0_in     = 1.1535 USD/EUR
F0_in     = 1.1662946810 USD/EUR
R_USD     = 4.01%
R_FC      = 2.884%
T_DAYS    = 365
K_PUT     = 1.1535
PREM_PUT  = 0.0250
K_CALL    = 1.1535
PREM_CALL = 0.0250
BASIS     = 360

This distinction is intentional so that the prompt log does not claim that reconstructed wording is a verbatim historical prompt.
---

# Stage 5 — Independent LLM Analysis & Validation

## Prompt 48 — Update the Top-Level GitHub README

**Date:** 2026-08-14  
**Tool:** ChatGPT / GitHub  
**Prompt Type:** Repository documentation  
**Status:** Exact project request

### Prompt / Context

> Create a pull request and change my README to include my updated bio, skills, fun facts, and career goals.

### Purpose

I used AI to revise the top-level repository README so that it presents a professional personal bio and makes the repository more portfolio-ready.

### Result

The README was expanded to include:

- Personal introduction
- Finance and Economics academic background
- Skills
- Software and tools
- Fun facts
- Career goals
- GitHub project presentation

---

## Prompt 49 — Ask What Stage 5 Requires

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** Assignment clarification  
**Status:** Exact assignment content supplied

### Prompt

> Read this and tell me what I need to do Stage 5 — LLM Analysis & Validation

### Purpose

I supplied the complete Stage 5 assignment instructions and asked AI to translate them into a simpler step-by-step workflow.

### Result

Stage 5 was organized into:

1. Fresh independent LLM execution
2. LLM vs. workbook comparison
3. Hand verification
4. Executive recommendation
5. Spec retrospective
6. Repository polish
7. Final prompt-log update

---

## Prompt 50 — Independent Fresh LLM Analysis

**Date:** 2026-08-14  
**Tool:** ChatGPT (fresh conversation)  
**Prompt Type:** Independent hedge analysis  
**Status:** Exact prompt

### Prompt

> Using only the attached hedge specification and market-data memo, independently calculate the outcomes for the unhedged position, forward hedge, money-market hedge, put option hedge, and call option where applicable. Evaluate the strategies across representative terminal EUR/USD spot rates, explain the sensitivity of each strategy, and recommend the most appropriate hedge strategy for the firm. Show the calculations and assumptions used.

### Documents Provided

Only these two documents were supplied:

1. `docs/specs/2026-08-07-Yi-eur-receivable-hedge-spec.md`
2. `data/2026-08-07-Yi-market-data.md`

### Important Control

The workbook, previous calculations, and prior project conversations were not supplied.

The LLM was not corrected or coached during the run.

### Result

The independent LLM calculated:

- Unhedged outcomes
- Forward proceeds
- Three-step money-market hedge
- Put-option outcomes
- Sensitivity analysis
- Covered-interest-parity check
- Final hedge recommendation

The LLM recommended the forward hedge.

---

## Prompt 51 — Convert Independent LLM Output to GitHub Markdown

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** GitHub formatting  
**Status:** Exact prompt

### Prompt

> Write in Github code

### Purpose

The independent LLM output needed to be saved as a Markdown artifact in the repository.

### Result

The Stage 5 independent LLM output was formatted for:

`analysis/2026-08-14-Yi-llm-output.md`

---

## Prompt 52 — Ask What to Do After the Independent Run

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** Workflow guidance  
**Status:** Exact prompt

### Prompt

> What should I do next

### Result

The next required task was identified as comparing the independent LLM results against the Stage 4 Excel workbook and then completing the required hand verification.

---

## Prompt 53 — Compare Stage 4 Workbook Against LLM Results

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** Model validation  
**Status:** Exact prompt

### Prompt

> Here is my Stage 4 Excel workbook please compare the results against the LLM results

### Purpose

I supplied the Excel workbook so the independent LLM results could be compared against the spreadsheet outputs.

### Key Finding

The uploaded workbook was still populated with Stage 2 placeholder values instead of the Stage 4 market-data inputs.

Examples included:

- Workbook `S0_in = 1.1000`
- Stage 4 `S0_in = 1.1535`
- Workbook `F0_in = 1.1000`
- Stage 4 `F0_in = 1.1662946810`
- Workbook `R_USD = 5.30%`
- Stage 4 `R_USD = 4.01%`
- Workbook `R_FC = 3.00%`
- Stage 4 `R_FC = 2.884%`

### Result

The differences were initially diagnosed as workbook population errors rather than LLM arithmetic errors.

---

## Prompt 54 — Build the Required Comparison Table

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** Validation documentation  
**Status:** Exact prompt

### Prompt

> Make the comparison table as needed with LLM result, workbook result, differences, Diagnosis: `Match`, `LLM error`, `Workbook error`, or `Spec ambiguity`. Afterwards let me know what I need to do hand calculations for and where to find it within each part.

### Result

The comparison used three representative terminal exchange-rate scenarios:

- `-5%`
- `0%`
- `+5%`

The following strategies were compared:

- Unhedged
- Forward
- Money market
- Put option
- Call option where applicable

The forward, money-market, put, and unhedged discrepancies were classified as:

**Workbook error**

The call treatment was later identified as:

**Spec ambiguity**

---

## Prompt 55 — Verify, Diagnose, and Reconcile

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** Model reconciliation  
**Status:** Exact prompt

### Prompt

> Please verify, diagnose, and reconcile, then let me know what I am missing and what to do in github

### Purpose

I asked AI to go beyond listing discrepancies and identify their causes, reconcile the correct results, and identify missing GitHub deliverables.

### Result

The validation identified:

1. Stage 4 market data had been documented.
2. The saved workbook still contained Stage 2 placeholders.
3. The underlying hedge formulas were consistent.
4. Applying the Stage 4 inputs reconciled the core LLM and workbook calculations.
5. The actual saved workbook still needed to be repopulated before final submission.

---

## Prompt 56 — Complete Part 2

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** Stage 5 deliverable drafting  
**Status:** Exact assignment request

### Prompt

> Part 2 — Comparison & hand verification
>
> 1. Comparison table: LLM's result vs. your workbook's result for each strategy — forward, MM, put, call, unhedged at 2–3 `S_T` points. Flag every discrepancy and diagnose it: LLM error, workbook error, or spec ambiguity?
>
> 2. Hand-verification table (≥3 outcomes, arithmetic shown): recompute by hand — calculator and named-range notation, no Excel:
> - forward proceeds (`FC_AMT × F0_in`)
> - the money-market hedge, all three steps
> - one option outcome
>
> Complete this.

### Result

Part 2 was drafted with:

- Initial comparison
- Diagnosis
- Reconciliation
- Forward verification
- Three-step money-market verification
- Put-option verification

---

## Prompt 57 — Explain Formula Sources for Hand Verification

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** Hand verification  
**Status:** Exact prompt

### Prompt

> Show the formulas and explain where numbers came from for the hand-calculations

### Result

The hand-verification section documented both the formula and source of each input.

Examples:

`FC_AMT = €4,500,000`

Assigned project exposure.

`S0_in = 1.1535`

ECB EUR/USD reference rate.

`R_USD = 4.01%`

1-year U.S. Treasury proxy.

`R_FC = 2.884%`

12-month Euribor.

`F0_in = 1.1662946810`

Covered-interest-parity implied forward.

---

## Prompt 58 — Re-Supply the Full Stage 5 Goal and Deliverables

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** Requirements verification  
**Status:** Exact assignment content supplied

### Prompt / Context

> Goal
>
> The capstone. Feed your Phase 2 spec and Phase 4 market-data memo — and nothing else — to a fresh LLM session and have it produce the complete hedge analysis independently. Then do what a professional does with any model output: verify it by hand, reconcile the differences, and only then make the recommendation.
>
> Part 1 — Independent LLM execution
>
> Part 2 — Comparison & hand verification
>
> Part 3 — Executive recommendation memo
>
> Part 4 — Spec retrospective & repo polish

### Purpose

The complete requirements were resupplied to make sure the final Stage 5 files matched the professor's capstone instructions.

---

## Prompt 59 — Create the Validation Document and Raw LLM File

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** Deliverable creation  
**Status:** Exact prompt

### Prompt

> Complete the validation doc in a copy and pastable markdown first and then also the raw LLM output as a file

### Result

Two Stage 5 artifacts were prepared:

`analysis/2026-08-14-Yi-eur-receivable-hedge-validation.md`

`analysis/2026-08-14-Yi-llm-output.md`

---

## Prompt 60 — Request Validation Document in GitHub Code

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** GitHub formatting  
**Status:** Exact prompt

### Prompt

> Make the Validation document in copy and past code format for github

### Result

The validation document was converted to GitHub-ready Markdown.

---

## Prompt 61 — Ask Exactly What to Paste Into GitHub

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** GitHub navigation / formatting  
**Status:** Exact prompt

### Prompt

> what am I supposed to copy and paste into github code

### Result

AI clarified that the Markdown contents should be pasted into:

`analysis/2026-08-14-Yi-eur-receivable-hedge-validation.md`

and the separate raw LLM file should be uploaded to the same `analysis/` directory.

---

## Prompt 62 — Request Validation Document Again as GitHub Code

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** GitHub formatting  
**Status:** Exact prompt

### Prompt

> Give me the validation doc as github code

### Result

The complete validation document was returned as Markdown.

---

## Prompt 63 — Identify Inconsistent Markdown Formatting

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** Formatting correction  
**Status:** Exact prompt

### Prompt

> why is 2.5 through the validation conclusion not typed in the same way as part 1 through 2.4

### Result

The formatting inconsistency was identified and the later validation sections were rewritten using the same Markdown style.

---

## Prompt 64 — Reformat the Entire Validation Document Consistently

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** Markdown revision  
**Status:** Exact prompt

### Prompt

> Now format it all the same and give me one large markdown for the validation doc

### Result

The full validation document was rebuilt into one consistent Markdown structure.

---

## Prompt 65 — Diagnose Broken GitHub Rendering

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** GitHub Markdown troubleshooting  
**Status:** Exact prompt

### Prompt

> Why does it look like this when I copy and paste it into Github

### Finding

A Markdown code fence in the reconciliation section had not been closed.

As a result, GitHub interpreted the later validation content as part of a code block.

### Result

The missing closing code fence was identified.

---

## Prompt 66 — Review the Current Raw LLM File Formatting

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** Markdown troubleshooting  
**Status:** Exact prompt

### Prompt

> This is how my LLM looks

### Finding

Several Markdown table headers had lost their `|` column separators.

Examples included malformed headings for:

- Inputs and assumptions
- Forward comparison
- Sensitivity analysis

### Result

Correct table syntax was provided.

---

## Prompt 67 — Rebuild Validation to Match Raw LLM Style

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** Final validation formatting  
**Status:** Exact prompt

### Prompt

> Match the style and start over and remake the validation doc using so the raw file works

### Result

The validation document was rebuilt to match the raw LLM file style:

- Metadata table
- Numbered headings
- Simple Markdown
- Standard tables
- No nested fenced-code sections that could break rendering

---

# Stage 5 — Executive Recommendation

## Prompt 68 — Supply Part 3 Executive Recommendation Requirements

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** Recommendation memo requirements  
**Status:** Exact assignment content supplied

### Prompt / Context

> Part 3 — The executive recommendation memo
>
> 2–4 pages, to the CFO, insight over computation — the CFO already has the numbers.
>
> A. Exposure summary
>
> B. Hedge outcomes
>
> C. Sensitivity interpretation
>
> D. Recommendation
>
> E. Executive justification

### Result

A CFO-oriented recommendation memo was drafted using the validated Stage 4 results.

---

## Prompt 69 — Convert Executive Recommendation to GitHub Markdown

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** GitHub formatting  
**Status:** Exact prompt

### Prompt

> Remake in Github code

### Result

The executive recommendation memo was formatted for:

`docs/decisions/2026-08-14-Yi-eur-receivable-hedge-recommendation.md`

### Recommendation

The memo recommends a:

**Forward hedge for the full €4,500,000 EUR receivable**

with modeled settlement proceeds of approximately:

`$5,248,326.06`

---

# Stage 5 — Repository Polish

## Prompt 70 — Review the Current Top-Level README

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** Repository polish  
**Status:** Exact prompt

### Prompt

> This is my current top-level README current (bio + a project section linking every stage artifact)

### Result

AI reviewed the README requirement and identified that the top-level file needed:

- Updated bio
- Skills
- Career goals
- FIN 321 project overview
- Stage-by-stage artifact links
- Final recommendation link
- Prompt-log link

---

## Prompt 71 — Supply Current README and Request Final Update

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** README revision  
**Status:** Exact prompt supplied with current README text

### Prompt

> This is my current readme

The current README contained the personal bio, skills, fun facts, and career goals.

### Requested Update

The README was expanded to include a dedicated:

`FIN 321 — EUR Receivable FX Hedging Project`

section linking the Stage 2 through Stage 5 artifacts and the final recommendation.

---

# Stage 5 — Final Prompt Log Update

## Prompt 72 — Add Today's AI GitHub Prompts to the Prompt Log

**Date:** 2026-08-14  
**Tool:** ChatGPT  
**Prompt Type:** Final documentation update  
**Status:** Exact prompt

### Prompt

> update the prompt log so that it includes all of the prompts I have written today for the AI Github project

### Purpose

The existing prompt log covered the earlier stages of the project but needed to be extended through the Stage 5 capstone work.

### Stage 5 Work Added

The updated prompt log now documents AI use for:

- Stage 5 assignment interpretation
- Fresh independent LLM execution
- Raw LLM output
- Workbook comparison
- Discrepancy diagnosis
- Reconciliation
- Hand verification
- Formula and input-source explanation
- Validation-document drafting
- GitHub Markdown troubleshooting
- Spec retrospective
- Executive recommendation memo
- README portfolio polish
- Final prompt-log completion

---

# Stage 5 AI-Assisted Workflow Summary

The Stage 5 workflow was:

**Independent LLM Run → Compare → Diagnose → Hand Verify → Reconcile → Retrospective → Recommend → Format → Polish Repository**

The most important Stage 5 finding was that the independent LLM used the Stage 4 market-data memo correctly, while the saved workbook being reviewed still contained Stage 2 placeholder values.

This produced a genuine validation discrepancy rather than a manufactured one.

The call option also revealed a specification ambiguity because the specification retained call variables but did not clearly define the call as a primary hedge for the EUR receivable.

The final core calculations independently verified were:

- Forward hedge: `$5,248,326.06`
- Money-market hedge: `$5,248,326.06`
- Put hedge at 5% EUR depreciation: `$5,073,676.09`

The final executive analysis recommends the forward hedge for the €4,500,000 EUR receivable, subject to obtaining an executable market forward quote.

---

# Updated AI Use Statement

ChatGPT was used throughout Stage 5 as an independent analysis tool, validation assistant, documentation assistant, and GitHub formatting assistant.

The independent LLM output was not accepted automatically.

Its calculations were compared with the Excel workbook, differences were diagnosed, the major hedge calculations were independently recomputed using named-range notation and calculator arithmetic, specification weaknesses were documented, and the recommendation was made only after reconciliation.

AI was also used to prepare and format the final GitHub portfolio artifacts.

The complete project workflow is now:

**Frame → Specify → Build → Audit → Populate Market Data → Independently Analyze → Compare → Diagnose → Hand Verify → Reconcile → Recommend → Document → Polish → Commit**
