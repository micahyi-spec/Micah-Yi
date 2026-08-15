---
title: "EUR Receivable Hedge — Stage 5 Validation"
author: "Micah Yi"
date: "2026-08-14"
version: "1.0"
---

# EUR Receivable Hedge — Stage 5 Validation

**Student:** Micah Yi  
**Course:** FIN 321 — International Business Finance  
**Section:** 701  
**Scenario:** €4,500,000 EUR Receivable  

---

# Part 1 — Independent LLM Execution

## 1.1 Purpose

The purpose of the independent LLM execution was to test whether the Stage 2 technical specification and Stage 4 market-data memo contained enough information for another model to reproduce the hedge analysis without access to the Excel workbook or previous project conversations.

A fresh LLM conversation with no project history was used.

The LLM received exactly two documents:

1. `docs/specs/2026-08-07-Yi-eur-receivable-hedge-spec.md`
2. `data/2026-08-07-Yi-market-data.md`

The workbook, previous calculations, Stage 3 audit, and prior LLM responses were not supplied.

No corrections or coaching were provided during the independent run.

## 1.2 Prompt Used

> Using only the attached hedge specification and market-data memo, independently calculate the outcomes for the unhedged position, forward hedge, money-market hedge, put option hedge, and call option where applicable. Evaluate the strategies across representative terminal EUR/USD spot rates, explain the sensitivity of each strategy, and recommend the most appropriate hedge strategy for the firm. Show the calculations and assumptions used.

The complete independent output is preserved separately in:

`analysis/2026-08-14-Yi-llm-output.md`

[View the raw independent LLM output](./2026-08-14-Yi-llm-output.md)

---

# Part 2 — Comparison & Hand Verification

## 2.1 Stage 4 Inputs Used by the Independent LLM

The independent LLM used the values documented in the Stage 4 market-data memo.

| Named Range | Stage 4 Value | Source / Basis |
|---|---:|---|
| `FC_AMT` | €4,500,000 | Assigned transaction amount |
| `S0_in` | 1.1535 USD/EUR | ECB EUR/USD reference rate |
| `F0_in` | 1.1662946810 USD/EUR | Covered-interest-parity implied forward |
| `R_USD` | 4.01% | 1-year U.S. Treasury proxy |
| `R_FC` | 2.884% | 12-month Euribor |
| `T_DAYS` | 365 | One-year settlement horizon |
| `BASIS` | 360 | FIN 321 ACT/360 convention |
| `K_PUT` | 1.1535 USD/EUR | At-the-money strike set equal to spot |
| `K_CALL` | 1.1535 USD/EUR | At-the-money strike set equal to spot |
| `PREM_PUT` | 0.0250 USD/EUR | Scenario assumption |
| `PREM_CALL` | 0.0250 USD/EUR | Scenario assumption |

Three representative terminal EUR/USD scenarios were selected:

- 5% EUR depreciation: `S_T = 1.095825`
- No change: `S_T = 1.153500`
- 5% EUR appreciation: `S_T = 1.211175`

---

## 2.2 Initial LLM vs. Workbook Comparison

The workbook initially produced different results because its `Inputs` tab was still populated with the Stage 2 placeholder market values.

The workbook contained:

| Named Range | Workbook Value | Stage 4 Value |
|---|---:|---:|
| `S0_in` | 1.1000 | 1.1535 |
| `F0_in` | 1.1000 | 1.1662946810 |
| `R_USD` | 5.30% | 4.01% |
| `R_FC` | 3.00% | 2.884% |
| `K_PUT` | 1.1000 | 1.1535 |
| `K_CALL` | 1.1000 | 1.1535 |

The workbook's Validation tab also reported:

`Market Data Status = PLACEHOLDER`

### Initial Comparison Table

**Difference = LLM Result − Workbook Result**

| `S_T` Scenario | Strategy | LLM Result | Initial Workbook Result | Difference | Diagnosis |
|---|---|---:|---:|---:|---|
| **-5%** | Unhedged | $4,931,212.50 | $4,702,500.00 | $228,712.50 | **Workbook error** |
| **-5%** | Forward | $5,248,326.06 | $4,950,000.00 | $298,326.06 | **Workbook error** |
| **-5%** | Money Market | $5,248,326.06 | $5,062,023.86 | $186,302.20 | **Workbook error** |
| **-5%** | Put Option | $5,073,676.09 | $4,831,454.69 | $242,221.40 | **Workbook error** |
| **-5%** | Call Option | N/A | Illustrative only | N/A | **Spec ambiguity** |
| **0%** | Unhedged | $5,190,750.00 | $4,950,000.00 | $240,750.00 | **Workbook error** |
| **0%** | Forward | $5,248,326.06 | $4,950,000.00 | $298,326.06 | **Workbook error** |
| **0%** | Money Market | $5,248,326.06 | $5,062,023.86 | $186,302.20 | **Workbook error** |
| **0%** | Put Option | $5,073,676.09 | $4,831,454.69 | $242,221.40 | **Workbook error** |
| **0%** | Call Option | N/A | Illustrative only | N/A | **Spec ambiguity** |
| **+5%** | Unhedged | $5,450,287.50 | $5,197,500.00 | $252,787.50 | **Workbook error** |
| **+5%** | Forward | $5,248,326.06 | $4,950,000.00 | $298,326.06 | **Workbook error** |
| **+5%** | Money Market | $5,248,326.06 | $5,062,023.86 | $186,302.20 | **Workbook error** |
| **+5%** | Put Option | $5,333,213.59 | $5,078,954.69 | $254,258.90 | **Workbook error** |
| **+5%** | Call Option | N/A | Illustrative only | N/A | **Spec ambiguity** |

---

## 2.3 Diagnosis

The differences in the unhedged, forward, money-market, and put results were classified as **Workbook error**.

The workbook formulas themselves were structurally intact, but the workbook had not been repopulated with the Stage 4 market inputs before the Stage 5 comparison.

For example, the independent LLM used:

`S0_in = 1.1535`

while the workbook still used:

`S0_in = 1.1000`

The same issue occurred with the forward rate, USD interest rate, EUR interest rate, and option strikes.

This means the independent LLM and workbook were effectively solving the same model with two different sets of market assumptions.

The issue was therefore not caused by an LLM arithmetic error.

### Call Option Diagnosis

The call option produced a different type of issue.

The technical specification defines:

- `K_CALL`
- `PREM_CALL`

but states that the call is retained mainly for compatibility with a broader model and a foreign-currency payable version.

The specification identifies the **put** as the primary option hedge for this EUR receivable.

The workbook includes a standalone call payoff and an illustrative receivable-plus-call calculation, but the specification does not clearly require that calculation as a valid hedge strategy for the EUR receivable.

The independent LLM therefore declined to invent a call hedge formula.

I classify this as:

**Spec ambiguity**

rather than an LLM or workbook arithmetic error.

---

## 2.4 Reconciliation

To reconcile the results, the existing workbook formulas were evaluated using the Stage 4 market-data values instead of the Stage 2 placeholders.

The required Stage 4 values are:

```text
FC_AMT     = 4,500,000
S0_in      = 1.1535
F0_in      = 1.1662946810
R_USD      = 4.01%
R_FC       = 2.884%
K_PUT      = 1.1535
K_CALL     = 1.1535
PREM_PUT   = 0.0250
PREM_CALL  = 0.0250
T_DAYS     = 365
BASIS      = 360
## 2.5 Hand Verification

The following calculations were recomputed manually using named-range notation and the values documented in the Stage 4 market-data memo.

No Excel formulas were used to perform the hand verification.

### Hand-Verification Summary Table

| Outcome | Named-Range Formula | Arithmetic | Verified Result |
|---|---|---|---:|
| Forward proceeds | `USD_FWD = FC_AMT × F0_in` | `4,500,000 × 1.1662946810` | **$5,248,326.06** |
| MM Step 1 — Borrow EUR | `FC_BORROW = FC_AMT / DF_FC` | `4,500,000 / 1.0292405556` | **€4,372,155.74** |
| MM Step 2 — Convert to USD | `USD_NOW = FC_BORROW × S0_in` | `4,372,155.74 × 1.1535` | **$5,043,281.64** |
| MM Step 3 — Invest USD | `USD_MM = USD_NOW × DF_USD` | `5,043,281.64 × 1.0406569444` | **$5,248,326.06** |
| Put at -5% `S_T` | `USD_PUT = MAX(S_T,K_PUT) × FC_AMT + FV_PREM_PUT` | `1.1535 × 4,500,000 − 117,073.91` | **$5,073,676.09** |

## 2.6 Forward Hedge Hand Verification

### Inputs

`FC_AMT = €4,500,000`

This amount comes directly from the assigned transaction scenario.

`F0_in = 1.1662946810 USD/EUR`

The Stage 4 market-data memo calculated the one-year forward rate using covered interest parity based on the live spot rate and the selected USD and EUR interest-rate proxies.

### Formula

`USD_FWD = FC_AMT × F0_in`

### Arithmetic

`USD_FWD = 4,500,000 × 1.1662946810`

`USD_FWD = 5,248,326.0645`

Rounded to cents:

**`USD_FWD = $5,248,326.06`**

### Verification

The forward hedge locks approximately **$5.248 million** at settlement regardless of the terminal EUR/USD rate.

## 2.7 Money-Market Hedge Hand Verification

The money-market hedge contains three economic steps:

1. Borrow enough EUR today so the loan grows to €4.5 million at settlement.
2. Convert the borrowed EUR to USD at the current spot rate.
3. Invest the USD until settlement.

### Step 1 — Determine the EUR Amount to Borrow

#### Inputs

`FC_AMT = €4,500,000`

`R_FC = 2.884% = 0.02884`

`T_DAYS = 365`

`BASIS = 360`

#### EUR Accumulation Factor

`DF_FC = 1 + R_FC × T_DAYS / BASIS`

`DF_FC = 1 + 0.02884 × 365 / 360`

`DF_FC = 1.0292405556`

#### EUR Borrowing

`FC_BORROW = FC_AMT / DF_FC`

`FC_BORROW = 4,500,000 / 1.0292405556`

**`FC_BORROW = €4,372,155.74`**

### Step 2 — Convert the Borrowed EUR Into USD

`USD_NOW = FC_BORROW × S0_in`

`USD_NOW = 4,372,155.74 × 1.1535`

**`USD_NOW = $5,043,281.64`**

### Step 3 — Invest the USD Until Settlement

`DF_USD = 1 + R_USD × T_DAYS / BASIS`

`DF_USD = 1 + 0.0401 × 365 / 360`

**`DF_USD = 1.0406569444`**

`USD_MM = USD_NOW × DF_USD`

`USD_MM = 5,043,281.64 × 1.0406569444`

**`USD_MM = $5,248,326.06`**

### Verification

The money-market hedge produces approximately **$5.248 million**, which reconciles with the forward hedge.

## 2.8 Put Option Hand Verification — 5% EUR Depreciation

### Step 1 — Calculate Terminal Spot

`S_T = S0_in × 0.95`

`S_T = 1.1535 × 0.95`

**`S_T = 1.095825`**

### Step 2 — Determine Whether to Exercise the Put

`K_PUT = 1.1535`

Since:

`1.095825 < 1.1535`

the company exercises the put.

### Step 3 — Calculate Gross Protected Proceeds

`Gross Put Proceeds = K_PUT × FC_AMT`

`Gross Put Proceeds = 1.1535 × 4,500,000`

**`Gross Put Proceeds = $5,190,750.00`**

### Step 4 — Calculate the Put Premium

`Premium Today = PREM_PUT × FC_AMT`

`Premium Today = 0.0250 × 4,500,000`

**`Premium Today = $112,500.00`**

`FV_PREM_PUT = -PREM_PUT × FC_AMT × DF_USD`

`FV_PREM_PUT = -0.0250 × 4,500,000 × 1.0406569444`

**`FV_PREM_PUT = -$117,073.91`**

### Step 5 — Calculate Net Put Proceeds

`USD_PUT = MAX(S_T,K_PUT) × FC_AMT + FV_PREM_PUT`

`USD_PUT = 1.1535 × 4,500,000 - 117,073.91`

**`USD_PUT = $5,073,676.09`**

## Part 4 — Spec Retrospective

The independent LLM test revealed two areas where the project could be improved.

The first issue was a data-readiness problem. The independent LLM used the Stage 4 market-data memo correctly, while my uploaded workbook was still populated with the Stage 2 placeholder values. The workbook formulas passed the structural validation checks, but the Validation tab continued to show `Market Data Status = PLACEHOLDER`.

In a version 2 specification, I would add a required Stage 4 completion control. The model would not be considered ready for Stage 5 unless every required market input had a non-placeholder status, a source, an as-of date, and agreement with the market-data memo.

The second issue involved the call option. The specification defines `K_CALL` and `PREM_CALL`, but it does not clearly state whether the call should be included as a primary strategy for this EUR receivable or provide a required total-proceeds formula.

The workbook therefore included an illustrative call calculation, while the independent LLM did not calculate a call hedge. I classify this as **spec ambiguity**.

In version 2, I would either clearly exclude the call from the receivable decision set or define the exact call formula and interpretation.

Overall, the independent test showed that the core hedge formulas were reproducible, but the project would benefit from stronger data-readiness controls and clearer treatment of the call option.

## Validation Conclusion

The Stage 5 validation identified two meaningful issues.

First, the saved workbook was still using Stage 2 placeholder market inputs even though the Stage 4 market-data memo contained updated values. This caused the initial discrepancies between the workbook and the independent LLM.

Second, the treatment of the call option was not fully defined for the EUR receivable, which created a specification ambiguity.

When the workbook formulas are recalculated using the Stage 4 market-data values, the unhedged, forward, money-market, and put outcomes reconcile with the independent LLM results.

The manual calculations also confirm the forward proceeds, all three steps of the money-market hedge, and the put outcome under a 5% EUR depreciation scenario.

Before final submission, the saved Excel workbook must be updated with the Stage 4 market values so the actual repository workbook reflects the reconciled results.
