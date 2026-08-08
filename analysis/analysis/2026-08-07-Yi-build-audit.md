# Stage 3 — AI-Assisted Build Audit

**Student:** Micah Yi  
**Course:** FIN 321 — International Business Finance  
**Section:** 701  
**Date:** 2026-08-07  
**Scenario:** €4,500,000 EUR Receivable  
**Workbook:** `models/builds/2026-08-07-Yi-eur-receivable-hedge-model.xlsx`  
**Specification:** `docs/specs/2026-08-07-Yi-eur-receivable-hedge-spec.md`  
**AI Tool Used:** ChatGPT  

---

## 1. Audit Purpose

The purpose of this audit was to verify that the Stage 3 Excel workbook was built according to my Stage 2 model specification and the FIN 321 build contract.

The workbook was reviewed for the ten required named ranges, formula-driven calculations, workbook structure, hedge calculations, sensitivity analysis, chart, and validation checks.

The audit also focused on identifying problems in the AI-generated workbook rather than assuming the initial build was correct. When a problem was identified, I traced it back to the model specification or workbook logic, corrected it, and checked the model again.

---

## 2. Build Contract Review

| Requirement | Audit Result | Notes |
|---|---|---|
| All ten required named ranges | PASS | All ten required names were present and connected to their intended input cells. |
| Calculated cells use formulas | PASS | Hedge calculations, sensitivity calculations, and validation checks are formula-driven. |
| Cover page | PASS | Includes scenario, author, date, and Stage 3 data-provenance information. |
| Legend/Key and color convention | PASS | Yellow = inputs, Blue = assumptions, Green = formulas, Gray = outputs. |
| All hedge families | PASS | Forward, three-step money-market hedge, put option, and call illustration are included. |
| Sensitivity table and chart | PASS | Contains 11 formula-driven scenarios from 95% through 105% of `S0_in` and a comparison chart. |
| Validation checks | PASS | Covered-interest-parity and other model-integrity checks are visible and passing after correction. |

---

# 3. Audit Findings

## Finding 1 — Covered Interest Parity Failure

### What I Checked

I reviewed the covered-interest-parity validation and compared the forward hedge with the money-market hedge.

The specification uses:

`F_implied = S0_in × (1 + R_USD × T_DAYS / BASIS) / (1 + R_FC × T_DAYS / BASIS)`

I checked whether the original `F0_in` assumption agreed with the forward rate implied by the other Stage 3 assumptions.

### What I Found

The original model used:

- `S0_in = 1.1000`
- `F0_in = 1.1000`
- `R_USD = 5.30%`
- `R_FC = 3.00%`
- `T_DAYS = 365`
- `BASIS = 360`

These assumptions were not internally consistent.

Using the covered-interest-parity formula produced an implied forward rate of approximately:

`1.1248941906 USD/EUR`

Therefore, the original `F0_in = 1.1000` caused the parity validation to fail.

### What I Did

I traced the problem back to the Stage 2 specification instead of forcing the workbook validation to display PASS.

I revised the Stage 2 specification and changed the Stage 3 indicative forward-rate placeholder to:

`F0_in = 1.1248941906`

This value is specifically identified as a **CIP-consistent indicative placeholder**, not a live market forward quote.

I then updated the workbook and reran the validation. The covered-interest-parity check and forward-versus-money-market reconciliation passed after the correction.

**Final result: PASS**

---

## Finding 2 — Required Named Ranges

### What I Checked

I audited the workbook's named-range structure to determine whether all ten names required by the FIN 321 build contract were present.

The required names were:

1. `FC_AMT`
2. `S0_in`
3. `F0_in`
4. `R_USD`
5. `R_FC`
6. `K_PUT`
7. `K_CALL`
8. `PREM_PUT`
9. `PREM_CALL`
10. `T_DAYS`

### What I Found

All ten required named ranges were present in the workbook and associated with the model's input cells.

The workbook also contains helper names used to make the formulas more readable and auditable:

- `BASIS`
- `SENS_LOW`
- `SENS_STEP`

The helper names do not replace any of the ten standardized names.

### What I Did

I retained the ten required names and documented the additional helper names in the specification.

This keeps the workbook consistent with the standardized FIN 321 named-range contract while allowing the formulas to remain readable.

**Final result: PASS**

---

## Finding 3 — Money-Market Hedge Calculation Structure

### What I Checked

I reviewed the money-market hedge to determine whether the AI had combined the calculation into one formula or followed the specification's required three-step process.

The required calculation sequence was:

**Step 1 — Borrow EUR**

`FC_BORROW = FC_AMT / (1 + R_FC × T_DAYS / BASIS)`

**Step 2 — Convert EUR to USD**

`USD_NOW = FC_BORROW × S0_in`

**Step 3 — Invest USD**

`USD_MM = USD_NOW × (1 + R_USD × T_DAYS / BASIS)`

### What I Found

The workbook contains the three calculations as separate visible steps rather than hiding the money-market hedge inside one nested formula.

This makes it possible to audit the amount borrowed in EUR, the amount converted into USD, and the settlement-date value of the USD investment separately.

### What I Did

No structural correction was required for the three-step pipeline.

I retained the separate calculations and verified that the final money-market proceeds reconcile with the forward hedge after correcting the Stage 3 forward-rate placeholder.

**Final result: PASS**

---

## Finding 4 — Sensitivity Table Recalculation

### What I Checked

I reviewed the sensitivity table to determine whether the terminal exchange-rate scenarios were formula-driven or manually entered.

The specification requires:

`S_T = S0_in × scenario factor`

from:

`0.95 × S0_in`

through:

`1.05 × S0_in`

in 1% increments.

### What I Found

The workbook contains 11 sensitivity scenarios:

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

The terminal exchange rates and hedge proceeds are calculated with formulas rather than being pasted as static calculated results.

During the audit, the hedge-profit calculations were also tightened so they directly reference the model's named inputs and sensitivity logic.

### What I Did

I retained the 11-row sensitivity structure and revised the hedge-profit calculations where appropriate so the analysis remains formula-driven.

The comparison chart is connected to the sensitivity analysis and compares the primary receivable strategies.

**Final result: PASS**

---

## Finding 5 — Call Option Requirement

### What I Checked

I compared the workbook with the Stage 3 build contract, which specifically requires both put and call calculations with premium cost in USD and proceeds as a function of `S_T`.

### What I Found

The put option was the economically relevant downside hedge for the EUR receivable, but the Stage 3 contract also required a call calculation.

To make the workbook fully compliant, the call needed to be clearly visible as an `S_T`-dependent calculation rather than only appearing as an input.

### What I Did

I retained the put as the primary option hedge and added an explicit:

`Call Strategy Proceeds (Illustrative)`

calculation to the sensitivity analysis.

The call calculation includes the call premium and changes with `S_T`.

Because the company is receiving EUR, the call is clearly labeled as an **illustrative calculation** rather than the recommended downside hedge.

The Stage 2 specification was also updated so the specification and Stage 3 workbook describe the same call calculation.

**Final result: PASS**

---

## Finding 6 — Formula Error Scan

### What I Checked

After making the audit corrections, I scanned the workbook for common Excel formula errors.

I checked for:

- `#REF!`
- `#DIV/0!`
- `#VALUE!`
- `#NAME?`
- `#N/A`

### What I Found

The final audit did not identify any of these formula errors in the workbook.

### What I Did

No additional correction was required after the final formula-error scan.

**Final result: PASS**

---

# 4. Data Provenance Review

The Stage 3 workbook intentionally uses indicative placeholder market data because the purpose of Stage 3 is to build and audit the model structure.

The workbook therefore distinguishes model integrity from market-data readiness.

The Stage 3 model status is:

`MODEL_STATUS = PASS`

The market-data status remains:

`DATA_STATUS = PLACEHOLDER`

The corrected `F0_in = 1.1248941906` is a covered-interest-parity-consistent placeholder used for Stage 3 model validation. It should not be interpreted as a live dealer forward quote.

Current market data will replace the indicative inputs during the market-data stage of the project.

---

# 5. Final Validation

After completing the audit and corrections, I verified the following:

- [x] `FC_AMT` exists
- [x] `S0_in` exists
- [x] `F0_in` exists
- [x] `R_USD` exists
- [x] `R_FC` exists
- [x] `K_PUT` exists
- [x] `K_CALL` exists
- [x] `PREM_PUT` exists
- [x] `PREM_CALL` exists
- [x] `T_DAYS` exists
- [x] Forward hedge is formula-driven
- [x] Money-market hedge contains three visible steps
- [x] Put calculations are formula-driven
- [x] Call calculations are formula-driven
- [x] Option premiums are included in USD
- [x] Sensitivity analysis contains 11 scenarios
- [x] Sensitivity calculations depend on `S0_in`
- [x] Comparison chart is included
- [x] Covered-interest-parity validation is visible
- [x] Forward and money-market proceeds reconcile within tolerance
- [x] Validation checks pass
- [x] No major Excel formula errors were identified
- [x] Stage 3 placeholder data are clearly identified as indicative

---

# 6. Audit Conclusion

The initial AI-generated workbook was a useful starting point, but the audit identified an important inconsistency between the original forward-rate placeholder and the interest-rate assumptions.

The most significant correction was tracing the failed covered-interest-parity validation back to the Stage 2 specification. Instead of changing the workbook only to force a passing result, I corrected the specification and aligned the workbook with it.

The audit also verified the named-range structure, three-step money-market hedge, sensitivity calculations, option calculations, chart, and formula integrity. The call-option presentation and sensitivity formulas were further clarified so the final workbook follows the Stage 3 build contract.

After these corrections, the workbook satisfies the Stage 3 model-build requirements and the required validation checks pass. Market data remain clearly identified as placeholders and will be replaced with sourced values in the later market-data stage.
