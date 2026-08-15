# Micah Yi

Hello! My name is Micah Yi, and I am currently a senior at the University of Hawaiʻi at Mānoa, majoring in Finance with a minor in Economics.

My academic and professional interests include business, finance, entrepreneurship, and the hospitality industry. I am especially interested in developing practical skills in financial analysis, corporate finance, banking, trading, and business decision-making.

## Skills

### Languages
- English

### Software & Tools
- Microsoft Excel
- Microsoft Word
- Microsoft PowerPoint
- Microsoft Teams
- Microsoft Outlook
- Google Workspace
- GitHub

### Other Skills
- Basic financial and data analysis
- Business communication
- Customer service
- Leadership
- Team collaboration

## Fun Facts

- I enjoy playing volleyball.
- I have gone skydiving.
- I studied abroad in Korea.

## Career Goals

My long-term goal is to build a successful career in finance, whether that involves banking, trading, corporate finance, or another area of the financial industry.

I am interested in continuing to develop my analytical, technical, and professional skills while gaining experience that connects finance with real-world business decisions.

---

# FIN 321 — EUR Receivable FX Hedging Project

## Project Overview

This project analyzes the foreign-exchange risk associated with a **€4,500,000 EUR receivable** that will be received approximately one year in the future.

Because the company reports in U.S. dollars, a decline in EUR/USD would reduce the USD value of the receivable.

The project evaluates several approaches for managing this exposure:

- No hedge
- Forward hedge
- Money-market hedge
- Put option hedge
- Call-option analysis where applicable

The project was completed in multiple stages that moved from defining the financial problem to designing, building, validating, and recommending a final hedge strategy.

The final analysis uses sourced Stage 4 market information and compares the hedge strategies based on downside protection, cash-flow certainty, flexibility, premium cost, and operational complexity.

---

## Project Workflow

The project followed this process:

**Frame → Specify → Build → Audit → Populate Market Data → Independently Validate → Recommend**

---

## Stage 1 — Decision / Framing Memo

The first stage defines the €4,500,000 EUR receivable exposure and explains the company's foreign-exchange risk.

It introduces the major hedge alternatives before the quantitative model is built.

> **Add the exact Stage 1 file link here once you confirm its filename.**

Example format:

`[Stage 1 — Decision Memo](docs/decisions/YOUR-STAGE-1-FILENAME.md)`

---

## Stage 2 — Technical Specification

The Stage 2 specification defines the complete hedge model before Excel is built.

It includes:

- Named ranges
- Workbook structure
- Forward hedge logic
- Money-market hedge logic
- Put-option logic
- Call-option treatment
- Covered-interest-parity validation
- Sensitivity analysis
- Model checks and outputs

[Stage 2 — Technical Specification](docs/specs/2026-08-07-Yi-eur-receivable-hedge-spec.md)

---

## Stage 3 — AI-Assisted Workbook Build & Audit

Stage 3 converts the technical specification into a working Excel financial model.

The workbook includes:

- Cover page
- Input panel
- Forward hedge
- Money-market hedge
- Option hedge
- Sensitivity analysis
- Comparison chart
- Validation checks

### Workbook

[Stage 3 — EUR Receivable Hedge Workbook](models/builds/2026-08-07-Yi-eur-receivable-hedge-model.xlsx)

### Build Audit

The audit documents the checks performed on the AI-generated workbook and the corrections made after review.

[Stage 3 — Build Audit](analysis/2026-08-07-Yi-build-audit.md)

---

## Stage 4 — Market Data & Population

Stage 4 replaces the original placeholder market assumptions with sourced market information.

The market-data memo documents:

- EUR/USD spot rate
- USD interest-rate proxy
- EUR interest rate
- Covered-interest-parity implied forward rate
- Option strikes
- Option premium assumptions
- Data sources and as-of dates

[Stage 4 — Market Data Memo](data/2026-08-07-Yi-market-data.md)

---

## Stage 5 — Independent LLM Analysis & Validation

Stage 5 tests whether the Stage 2 specification and Stage 4 market-data memo can stand on their own.

A fresh LLM session received only those two documents and independently calculated the hedge outcomes.

The independent results were then compared against the workbook and manually verified.

### Independent LLM Output

[Stage 5 — Raw Independent LLM Output](analysis/2026-08-14-Yi-llm-output.md)

### Validation

The validation document includes:

- LLM vs. workbook comparison
- Discrepancy diagnosis
- Reconciliation
- Forward hand verification
- Three-step money-market hand verification
- Put-option hand verification
- Spec retrospective

[Stage 5 — Validation](analysis/2026-08-14-Yi-eur-receivable-hedge-validation.md)

---

## Final Hedge Recommendation

The final executive recommendation compares the major hedge alternatives and recommends a strategy based on the validated Stage 4 market-data results.

The analysis recommends a **forward hedge** because it provides:

- Downside protection
- Cash-flow stability
- Budget certainty
- Operational simplicity
- No option premium

[Final Hedge Recommendation](docs/decisions/2026-08-14-Yi-eur-receivable-hedge-recommendation.md)

---

## AI Prompt Log

The prompt log documents how AI was used throughout the project, including model design, workbook generation, auditing, validation, corrections, and GitHub formatting.

[AI Prompt Log](Prompt-log.md)

---

## Key Project Takeaway

One of the most important lessons from this project was that AI-generated financial analysis should not be accepted without verification.

The workflow required the model output to be audited, discrepancies to be diagnosed, calculations to be independently checked, and errors to be corrected before making a recommendation.

This project demonstrates the use of AI as a financial-analysis tool while maintaining human review, model validation, documentation, and professional judgment.

---

## AI Use Disclosure

Drafted with help from ChatGPT (OpenAI, 2026); reviewed, verified, and edited by me.
