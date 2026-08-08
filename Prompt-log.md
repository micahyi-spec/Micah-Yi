# Prompt Log

**Student:** Micah Yi  
**Course:** FIN 321 — International Business Finance  
**Section:** 701  
**Project:** FX Transaction Hedging Project  
**Scenario:** €4,500,000 EUR Receivable  
**Primary AI Tool:** ChatGPT  

---

# Stage 1 — Decision / Framing Memo

## Prompt 1 — Create the Initial FX Risk Memo

**Date:** 2026-07-31  
**Tool:** ChatGPT  

### Prompt

> Following this template create the memo and commit it to `docs/decisions/`

### Purpose

I used AI to help draft the initial decision memo explaining the company's foreign-exchange exposure from a €4,500,000 receivable due in one year.

The memo introduced the three primary hedge alternatives:

- Forward/futures hedge
- Money-market hedge
- Currency put option

### Result

The initial EUR receivable foreign-exchange risk assessment was drafted for the GitHub repository.

---

## Prompt 2 — Correct the Memo Template

**Date:** 2026-08-07  
**Tool:** ChatGPT  

### Prompt

> Add the template's YAML frontmatter — the `---` fenced block at the very top of the file (above the `#` title) holding `title`, `author`, `date`, and `version`. Yours jumps straight into the heading; copy that block back in from the decision-memo template and fill it in.

### Purpose

The original memo did not completely follow the required GitHub template.

### Result

The memo structure and metadata were corrected to follow the required decision-memo format.

---

# Stage 2 — Model Specification

## Prompt 3 — Turn the Memo Into a Model Specification

**Date:** 2026-08-07  
**Tool:** ChatGPT  

### Prompt

> Stage 2 — turn the memo into a model specification.
>
> In `docs/specs/`, write the named-range contract, tab architecture, calculation flow, and validation checks — precise enough that an AI could build the workbook from the spec alone.

### Purpose

I used AI to convert the Stage 1 business memo into a detailed technical specification for the Excel model.

### Result

The initial model specification established the workbook structure, required inputs, formulas, hedge calculations, sensitivity analysis, and validation requirements.

---

## Prompt 4 — Make the Specification GitHub-Ready

**Date:** 2026-08-07  
**Tool:** ChatGPT  

### Prompt

> Write the entire thing in code so that I can use it in Github

### Purpose

The specification needed to be formatted as Markdown so it could be committed directly to the GitHub repository.

### Result

The specification was converted into GitHub-ready Markdown.

---

## Prompt 5 — Apply the Official Specification Template

**Date:** 2026-08-07  
**Tool:** ChatGPT  

### Prompt

> Here is the spec template

### Purpose

I supplied the official FIN 321 technical-specification template so the AI-generated specification could be revised to follow the required organization.

### Result

The official specification template became the formatting and organizational standard for the Stage 2 document.

---

## Prompt 6 — Rewrite the Complete Specification

**Date:** 2026-08-07  
**Tool:** ChatGPT  

### Prompt

> Use this template and rewrite the entire finished spec inside one GitHub-ready Markdown code block using this exact template and your €4,500,000 EUR receivable scenario.

### Purpose

The initial specification needed to be rewritten using the exact FIN 321 template and standardized model terminology.

### Result

The revised specification included:

- Problem statement
- Named-range contract
- Workbook architecture
- Assumptions and constraints
- Forward hedge
- Three-step money-market hedge
- Put-option hedge
- Call-option compatibility
- Covered-interest-parity calculation
- Sensitivity analysis
- Validation rules
- Required outputs
- Auditability checklist
- Limitations and next steps

---

## Prompt 7 — Establish the Specification Filename

**Date:** 2026-08-07  
**Tool:** ChatGPT  

### Prompt

> YYYY-MM-DD-Yi-{scenario-slug}-spec.md

### Result

The specification was assigned the required GitHub path:

`docs/specs/2026-08-07-Yi-eur-receivable-hedge-spec.md`

---

# Stage 3 — AI-Assisted Build

## Prompt 8 — Understand the Stage 3 Requirements

**Date:** 2026-08-07  
**Tool:** ChatGPT  

### Prompt

> What do I need to do for this part, explain in order to get medium points

### Context

I supplied the Stage 3 — AI-Assisted Build + Audit assignment instructions.

### Purpose

I asked AI to explain the required workflow and identify the most important grading requirements before generating the workbook.

### Result

The Stage 3 process was organized into:

1. Build from the committed specification.
2. Verify the ten required named ranges.
3. Verify formula-driven calculations.
4. Check all hedge families.
5. Check the sensitivity analysis.
6. Check validation rules.
7. Audit the AI-generated workbook.
8. Document at least three findings.
9. Commit the workbook, audit note, and prompt log.

---

## Prompt 9 — Generate the Excel Workbook

**Date:** 2026-08-07  
**Tool:** ChatGPT  

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

### Purpose

This was the primary Stage 3 AI build prompt. The Stage 2 specification was used as the model-building instructions.

### Result

ChatGPT generated the Stage 3 Excel workbook containing:

- Cover
- Legend_Key
- Inputs
- Forward_Hedge
- Money_Market_Hedge
- Option_Hedge
- Sensitivity
- Validation
- Notes_Assumptions

The workbook also contained the ten required named ranges and formula-driven hedge calculations.

---

# Stage 3 — Market Data Review

## Prompt 10 — Verify Model Data

**Date:** 2026-08-07  
**Tool:** ChatGPT  

### Prompt

> Correct and make sure each piece of data is accurate and use multiple reliable sources to check

### Purpose

I asked AI to determine whether the values being used in the workbook represented current market information or Stage 2 placeholders.

### Result

The review distinguished between:

- Verified market data
- Market proxies
- Model-implied values
- Analyst assumptions
- Indicative placeholders

This review helped clarify that Stage 3 focuses on model construction and validation while live market inputs are handled in the later market-data stage.

---

# Stage 3 — Build Contract Review

## Prompt 11 — Review the Seven Build Requirements

**Date:** 2026-08-07  
**Tool:** ChatGPT  

### Prompt

> ## Goal
>
> Generate a working workbook from your own Phase 2 specification — using any AI tool or by hand — and audit the result.
>
> The build contract requires:
>
> 1. All ten named ranges attached to the right cells.
> 2. Formulas, never hard-coded calculated values.
> 3. Cover page with scenario, author, date, and data provenance.
> 4. Legend/Key with the required color convention.
> 5. All three hedge families.
> 6. Formula-driven sensitivity table and chart.
> 7. Validation checks live in the workbook and passing.

### Purpose

I supplied the official Stage 3 build contract so the generated workbook could be compared directly against the grading requirements.

### Result

The workbook requirements were reviewed against the grading contract and the covered-interest-parity validation was identified as an area requiring additional audit attention.

---

# Stage 3 — Workbook Audit and Corrections

## Prompt 12 — Audit the Workbook Against the Grading Requirements

**Date:** 2026-08-07  
**Tool:** ChatGPT  

### Prompt

> Audit and correct the Excel workbook itself against these seven grading requirements

### Purpose

I asked AI to inspect the generated workbook rather than assuming the initial AI build was correct.

### Findings

The audit checked:

- Required named ranges
- Formula-driven calculations
- Cover page
- Legend and color convention
- Hedge-family calculations
- Sensitivity table
- Comparison chart
- Validation rules
- Formula errors

### Major Finding

The original Stage 3 assumptions included:

`S0_in = 1.1000`

`F0_in = 1.1000`

`R_USD = 5.30%`

`R_FC = 3.00%`

`T_DAYS = 365`

`BASIS = 360`

The original `F0_in` was not consistent with covered interest parity.

The implied forward rate was approximately:

`F_implied = 1.1248941906`

This caused the required parity validation not to pass.

### Correction

The Stage 3 indicative forward placeholder was changed to:

`F0_in = 1.1248941906`

The value was explicitly identified as a **CIP-consistent indicative placeholder**, not a live dealer quote.

The workbook was then rechecked.

### Additional Corrections

The audit also:

- Tightened formula-driven sensitivity calculations.
- Added explicit call-strategy proceeds as a function of `S_T`.
- Confirmed the ten required named ranges.
- Confirmed the money-market hedge remained in three visible steps.
- Confirmed the sensitivity table contained 11 scenarios.
- Confirmed the comparison chart was present.
- Confirmed the required validation checks passed.
- Scanned for common Excel formula errors.

The final formula scan found no:

- `#REF!`
- `#DIV/0!`
- `#VALUE!`
- `#NAME?`
- `#N/A`

---

# Stage 2 / Stage 3 Alignment

## Prompt 13 — Correct the Specification to Match the Audited Workbook

**Date:** 2026-08-07  
**Tool:** ChatGPT  

### Prompt

> Fix the spec so that it reflects the stage 3 workbook

### Purpose

The Stage 3 audit identified a specification issue because the original forward-rate placeholder caused the parity validation to fail.

The assignment instructions state that defects should be corrected through the specification rather than explained only through chat.

### Result

The specification was revised to match the audited workbook.

The revision included:

- `F0_in = 1.1248941906`
- CIP-consistent placeholder explanation
- Nine-tab workbook architecture
- Ten required named ranges
- `BASIS`
- `SENS_LOW`
- `SENS_STEP`
- Call-option calculation
- Call Strategy Proceeds (Illustrative)
- Passing covered-interest-parity validation
- Separate model and market-data status
- Updated auditability requirements
- Version 0.3 change-log entry

---

## Prompt 14 — Correct GitHub Formatting of the Specification

**Date:** 2026-08-07  
**Tool:** ChatGPT  

### Prompt

> Make sure it is github code formatted properly just like the previous spec

### Purpose

The corrected specification needed to retain the same GitHub-ready Markdown structure and formatting used by the previous Stage 2 specification.

### Result

The specification was reformatted as GitHub-ready Markdown while preserving the technical content and Stage 3 audit corrections.

The final specification is stored at:

`docs/specs/2026-08-07-Yi-eur-receivable-hedge-spec.md`

---

# Stage 3 — Audit Documentation

## Prompt 15 — Build the Audit Note

**Date:** 2026-08-07  
**Tool:** ChatGPT  

### Prompt

> Build the audit

### Purpose

I used AI to organize the results of the workbook audit into the required Stage 3 audit-note format.

### Result

The audit note documented multiple substantive findings using the required structure:

**What I checked → What I found → What I did**

The findings included:

1. Covered-interest-parity failure and correction.
2. Required named-range verification.
3. Money-market hedge structure.
4. Sensitivity-table verification.
5. Call-option requirement.
6. Formula-error scan.

The audit note was prepared for:

`analysis/2026-08-07-Yi-build-audit.md`

---

# Stage 3 — GitHub Submission Assistance

## Prompt 16 — Ask How to Upload the Workbook

**Date:** 2026-08-07  
**Tool:** ChatGPT  

### Prompt

> How do I put it in github

### Purpose

I asked AI for instructions on placing the completed workbook into the required repository path.

### Result

The workbook was uploaded to:

`models/builds/2026-08-07-Yi-eur-receivable-hedge-model.xlsx`

The process also confirmed that the workbook must be uploaded as an actual `.xlsx` file rather than created as a text file through GitHub's file editor.

---

# Stage 3 — Prompt Documentation

## Prompt 17 — Initial Prompt Log

**Date:** 2026-08-07  
**Tool:** ChatGPT  

### Prompt

> Create a prompt log

### Purpose

The assignment requires every material AI prompt to be documented in `prompt-log.md`.

### Result

An initial project prompt log was created.

---

## Prompt 18 — Expand the Prompt Log

**Date:** 2026-08-07  
**Tool:** ChatGPT  

### Prompt

> All the prompts related to this github project list out all of the prompts used

### Purpose

I asked AI to expand the prompt log beyond the workbook-generation prompt so that it documented the broader AI-assisted project workflow.

### Result

The log was expanded to include Stage 1, Stage 2, Stage 3 generation, verification, and audit-related prompts.

---

## Prompt 19 — Rebuild the Final Prompt Log

**Date:** 2026-08-07  
**Tool:** ChatGPT  

### Prompt

> Create the prompt log again

### Purpose

The prompt log was rebuilt after completing additional Stage 3 audit work and specification corrections so that the final log accurately reflected the complete AI-assisted workflow.

---

# Final AI-Assisted Workflow

The project used AI through the following workflow:

1. Draft the Stage 1 FX exposure memo.
2. Correct the memo to match the required template.
3. Convert the memo into a technical model specification.
4. Apply the standardized named-range contract.
5. Format the specification for GitHub.
6. Apply the official FIN 321 specification template.
7. Generate the Stage 3 workbook from the specification.
8. Review the workbook against the official build contract.
9. Audit formulas, named ranges, hedge calculations, sensitivity analysis, and validation checks.
10. Identify the covered-interest-parity inconsistency.
11. Correct the Stage 2 specification rather than silently overriding the model.
12. Regenerate/correct the Stage 3 workbook.
13. Verify the corrected model.
14. Document the audit findings.
15. Update the specification to match the audited workbook.
16. Document the AI prompts and revisions in this prompt log.
17. Commit and push the required project deliverables to GitHub.

---

# AI Use Statement

ChatGPT was used as a drafting, spreadsheet-building, auditing, verification, and documentation assistant during this project.

AI output was treated as a draft rather than automatically assumed to be correct. The generated workbook was reviewed against the FIN 321 build contract and the Stage 2 specification.

The audit identified a substantive covered-interest-parity inconsistency in the original assumptions. The issue was traced back to the specification, corrected, and then reflected in the final workbook.

The final workflow followed the project's intended AI-assisted process:

**Specify → Build → Audit → Find → Fix the Specification → Correct the Model → Validate → Document**
