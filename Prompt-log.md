# Prompt Log

**Student:** Micah Yi
**Course:** FIN-321 International Finance & Securities
**Project:** FX Transaction Hedging Project
**Scenario:** €4,500,000 EUR Receivable
**Primary AI Tool:** ChatGPT

---

# Stage 1 — Decision / Framing Memo

## Prompt 1 — Create the Initial Memo

**Date:** 2026-07-31
**Tool:** ChatGPT

### Prompt

> Following this template create the memo and commit it to `docs/decisions/`

### Context Provided

The assignment required an executive memo to the CFO addressing a €4,500,000 EUR receivable due in one year.

The memo needed to:

* Explain the company's EUR/USD transaction exposure
* Quantify the potential financial effect of EUR depreciation
* Discuss forward/futures contracts
* Discuss a money-market hedge
* Discuss a put-option hedge
* Explain the advantages and disadvantages of the alternatives
* Preview the later modeling stages
* Follow the provided decision-memo template
* Be prepared for the GitHub repository

### Result

ChatGPT assisted in creating the initial EUR receivable foreign-exchange risk assessment and framing memo.

The memo was prepared for:

`docs/decisions/2026-07-31-Yi-eur-receivable-hedge-framing.md`

---

## Prompt 2 — Add Required YAML Frontmatter

**Date:** 2026-08-07
**Tool:** ChatGPT

### Prompt

> Add the template's YAML frontmatter — the `---` fenced block at the very top of the file (above the `#` title) holding `title`, `author`, `date`, and `version`. Yours jumps straight into the heading; copy that block back in from the decision-memo template and fill it in.
>
> EUR Receivable Foreign Exchange Risk Assessment
>
> Created by: Micah Yi
> Updated by: Micah Yi
> Date Created: 2026-07-31
> Date Updated: 2026-07-31
> Version: 0.1
> LLM Used: ChatGPT
>
> Executive Summary
>
> Our company expects to receive €4,500,000 from a customer one year from today. While the payment amount in euros is fixed, the value of that payment in U.S. dollars depends on the EUR/USD exchange rate when the payment is received. If the euro weakens before settlement, the company could receive significantly fewer dollars than expected. For example, if the exchange rate falls from 1.10 to 1.00 USD per euro, the payment decreases from $4,950,000 to $4,500,000, creating a $450,000 shortfall. That reduction could affect budgeting, cash flow, and financial planning. This memo outlines the company's foreign exchange exposure, summarizes the three primary hedging approaches available, and explains the structured analysis that will be completed before recommending a hedging strategy.
>
> Background & Objectives
>
> The company faces foreign exchange risk because it expects to receive €4,500,000 in one year while reporting its financial results in U.S. dollars. Although the euro amount is fixed, fluctuations in the EUR/USD exchange rate will determine how many dollars the company ultimately receives. A weaker euro at settlement would reduce expected revenue and could negatively impact budgets, profitability, and cash flow.
>
> There are three primary hedge families available to manage this risk:
>
> Forward/Futures Contracts: Lock in an exchange rate today, providing complete certainty but eliminating any benefit if the euro strengthens.
>
> Money Market Hedge: Uses borrowing and investing to replicate a forward contract, providing certainty but requiring financing capacity and additional transactions.
>
> Currency Options (Put Option): Establishes a minimum exchange rate while allowing the company to benefit if the euro appreciates, although an upfront premium is required.
>
> The objective is to evaluate each alternative and identify the solution that best balances cost, flexibility, and risk protection.
>
> Methods
>
> Rather than recommending a hedge immediately, a structured evaluation process will be completed.
>
> Stage 2 will develop the workbook design, including worksheet organization, formulas, named ranges, and validation checks.
>
> Stage 3 will use AI assistance to generate the workbook while independently reviewing every formula and correcting any errors.
>
> Stage 4 will replace placeholder values with current market exchange rates and other relevant financial data.
>
> Stage 5 will validate the completed model, compare the performance of each hedging alternative, and provide a final recommendation supported by quantitative analysis.
>
> Following this process ensures the final recommendation is based on objective financial evidence rather than assumptions.
>
> Limitations & Next Steps
>
> This memo is intended to frame the company's foreign exchange exposure rather than recommend a specific hedging strategy. Market exchange rates, interest rates, and option premiums will change over time, so any recommendation must be supported by current market data.
>
> The next step is to complete the financial model, populate it with live market information, verify the calculations, compare the available hedging alternatives, and present an evidence-based recommendation for management approval.
>
> References
>
> Hull, J. C. (2022). Options, Futures, and Other Derivatives (11th ed.). Pearson.
>
> Corporate Finance Institute. (n.d.). Foreign Exchange Risk Management.
>
> Course assignment materials and FX Hedging Lab.

### Template Provided

```text
# [Memo Title]

Created by: [name]
Updated by: [name]
Date Created: [date]
Date Updated: [date]
Version: [0.0]
LLM Used: [LLM name, or "None"]

Executive Summary
Background & Objectives
Methods
Limitations & Next Steps
References
```

### Result

The memo was revised to follow the required GitHub document structure and metadata conventions.

---

# Stage 2 — Model Specification

## Prompt 3 — Convert Memo Into Model Specification

**Date:** 2026-08-07
**Tool:** ChatGPT

### Prompt

> Stage 2 — turn the memo into a model specification.
>
> In `docs/specs/`, write the named-range contract, tab architecture, calculation flow, and validation checks — precise enough that an AI could build the workbook from the spec alone.

### Result

ChatGPT began converting the Stage 1 framing memo into a technical model specification suitable for building the Excel workbook.

---

## Prompt 4 — Stage 2 Assignment Requirements

**Date:** 2026-08-07
**Tool:** ChatGPT

### Prompt / Assignment Context Provided

> # Stage 2 — Model Specification
>
> **Weight: 21% of project**
>
> Deliverable:
>
> `docs/specs/YYYY-MM-DD-{lastname}-{scenario-slug}-spec.md`
>
> Design the workbook before any Excel exists: every input, name, formula, and check — written down precisely enough that an AI, or a colleague who has never seen your memo, could build the complete workbook from this document alone. In Stage 3, that is literally what happens.

The supplied instructions established eight required sections:

1. Problem statement
2. Inputs — named-range contract
3. Tab architecture
4. Assumptions & constraints
5. Calculation flow
6. Sensitivity plan
7. Validation rules
8. Outputs

The required standardized named ranges were:

```text
FC_AMT
S0_in
F0_in
R_USD
R_FC
K_PUT
K_CALL
PREM_PUT
PREM_CALL
T_DAYS
```

The assignment also supplied the required forward, money-market, covered-interest-parity, and option calculation logic.

### Result

These assignment requirements were used as binding constraints for the Stage 2 specification.

---

## Prompt 5 — Make the Specification GitHub-Ready

**Date:** 2026-08-07
**Tool:** ChatGPT

### Prompt

> Write the entire thing in code so that I can use it in Github

### Result

The Stage 2 specification was converted into GitHub-ready Markdown.

---

## Prompt 6 — Apply the Official Specification Template

**Date:** 2026-08-07
**Tool:** ChatGPT

### Prompt

> Here is the spec template

### Context Provided

The official FIN-321 technical-specification template was supplied to ChatGPT.

The template established additional requirements including:

* UH Mānoa / Shidler formatting
* Metadata table
* Standardized versus legacy named ranges
* Settlement-date treatment of option premiums
* Inputs and derived values
* Calculation flow
* Outputs
* Model review
* Auditability checklist
* Sensitivity plan
* Limitations and next steps
* Change log
* Branding and formatting standards

### Result

The official template became the source of truth for the final Stage 2 specification.

---

## Prompt 7 — Rewrite the Entire Finished Specification

**Date:** 2026-08-07
**Tool:** ChatGPT

### Prompt

> Use this template and rewrite the entire finished spec **inside one GitHub-ready Markdown code block using this exact template and your €4,500,000 EUR receivable scenario**.

### Result

ChatGPT generated the complete Stage 2 specification using the FIN-321 template and the €4,500,000 EUR receivable scenario.

The specification included:

* Problem statement
* Named-range contract
* Inputs
* Assumptions and constraints
* Forward hedge
* Three-step money-market hedge
* Covered-interest-parity check
* Put-option hedge
* Call-option compatibility
* No-hedge calculation
* Sensitivity analysis
* Required outputs
* Model-review section
* Auditability checklist
* Validation tolerances
* Sensitivity chart requirements
* Limitations
* Stage 3 handoff instructions
* Change log
* AI drafting/revision evidence
* UH Mānoa formatting standards

---

## Prompt 8 — Confirm Specification Filename

**Date:** 2026-08-07
**Tool:** ChatGPT

### Prompt

> `YYYY-MM-DD-Yi-{scenario-slug}-spec.md`

### Result

The final Stage 2 specification filename was established as:

`2026-08-07-Yi-eur-receivable-hedge-spec.md`

with the intended repository location:

`docs/specs/2026-08-07-Yi-eur-receivable-hedge-spec.md`

---

# Stage 3 — AI-Assisted Build + Audit

## Prompt 9 — Explain Stage 3 Requirements

**Date:** 2026-08-07
**Tool:** ChatGPT

### Prompt

> What do I need to do for this part, explain in order to get meadimum points

### Assignment Context Provided

The complete Stage 3 — AI-Assisted Build + Audit instructions were supplied.

The required deliverables were:

`models/builds/…-model.xlsx`

and:

`analysis/…-build-audit.md`

The Stage 3 build contract required:

1. All ten standardized named ranges
2. Formulas rather than pasted calculated values
3. Cover page
4. Legend/Key tab
5. Forward, money-market, put, and call calculations
6. Formula-driven ±5% sensitivity table and chart
7. Visible validation checks

The audit note required at least three substantive findings documenting:

* What was checked
* What was found
* What was done

### Result

ChatGPT explained the Stage 3 process in order and identified contract compliance as the highest-priority grading category.

---

## Prompt 10 — Build the Stage 3 Workbook

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

### Result

ChatGPT generated the Stage 3 Excel workbook from the committed specification.

The workbook contained:

* `Cover`
* `Legend_Key`
* `Inputs`
* `Forward_Hedge`
* `Money_Market_Hedge`
* `Option_Hedge`
* `Sensitivity`
* `Validation`
* `Notes_Assumptions`

All ten required standardized Excel named ranges were created.

The workbook also included formula-driven calculations, the three-step money-market pipeline, option calculations, an 11-row sensitivity table, a comparison chart, and visible validation checks.

---

# Stage 3 — Data Verification and Workbook Correction

## Prompt 11 — Verify and Correct the Workbook Data

**Date:** 2026-08-07
**Tool:** ChatGPT

### Prompt

> Correct and make sure each piece of data is accurate and use multiple reliable sources to check

### Result

ChatGPT reviewed the model inputs rather than automatically treating the Stage 2 placeholder values as verified market information.

The review distinguished among:

* Verified market data
* Market proxies
* Model-implied values
* Analyst assumptions
* Unverified placeholders

The review specifically examined:

* EUR/USD spot exchange rate
* EUR interest rate
* USD interest rate
* Forward rate
* Option strikes
* Put premium
* Call premium

The workbook was revised so uncertain values were not falsely represented as verified market observations.

A verification/provenance section was added to document data status and sources.

The revised workbook was saved as:

`models/builds/2026-08-07-Yi-eur-receivable-hedge-model-verified.xlsx`

---

# Stage 3 — Prompt Documentation

## Prompt 12 — Create Prompt Log

**Date:** 2026-08-07
**Tool:** ChatGPT

### Prompt

> Create a prompt log

### Result

ChatGPT created a GitHub-ready `prompt-log.md` documenting the major AI interactions used during the Stage 2 and Stage 3 process.

---

## Prompt 13 — Expand Prompt Log to Entire GitHub Project

**Date:** 2026-08-07
**Tool:** ChatGPT

### Prompt

> All the prompts related to this github project list out all of the prompts used

### Result

The prompt log was expanded to document the AI-assisted workflow from the initial Stage 1 framing memo through the Stage 2 specification, Stage 3 workbook construction, audit preparation, market-data verification, and prompt documentation.

---

# Summary of AI-Assisted Workflow

The AI workflow for this project followed this sequence:

1. Create the initial EUR receivable framing memo.
2. Correct the memo structure and metadata.
3. Convert the memo into a detailed model specification.
4. Apply the standardized FIN-321 named-range contract.
5. Convert the specification to GitHub-ready Markdown.
6. Apply the official FIN-321 technical-specification template.
7. Rewrite and finalize the Stage 2 specification.
8. Establish the required GitHub filename.
9. Review the Stage 3 assignment and build requirements.
10. Generate the Excel workbook directly from the committed Stage 2 specification.
11. Audit and verify model construction.
12. Verify market-data assumptions using external sources.
13. Correct the workbook and distinguish verified data from assumptions and placeholders.
14. Document the AI-assisted process in `prompt-log.md`.

---

# AI Use Statement

ChatGPT was used as a drafting, modeling, verification, and documentation assistant throughout the project.

AI-generated work was not automatically treated as correct. Outputs were reviewed against:

* The FIN-321 assignment instructions
* The Stage 1 decision-memo template
* The Stage 2 technical-specification template
* The standardized named-range contract
* Required hedge formulas
* Covered-interest-parity logic
* Sensitivity-analysis requirements
* Workbook validation rules
* External financial-market sources where market-data verification was requested

The project workflow demonstrates the intended AI-assisted modeling process: **specify, generate, audit, correct, verify, and document.**
