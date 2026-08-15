| **title**   | EUR Receivable FX Hedge — Stage 5 Validation |
| ----------- | -------------------------------------------- |
| **author**  | Micah Yi                                     |
| **date**    | 2026-08-14                                   |
| **version** | 1.0                                          |

# EUR Receivable FX Hedge — Stage 5 Validation

## 1. Independent LLM Execution

For Stage 5, a fresh LLM conversation with no project history was used to independently test whether the Stage 2 technical specification and Stage 4 market-data memo contained enough information to reproduce the hedge analysis.

The LLM was provided only the following two documents:

1. `docs/specs/2026-08-07-Yi-eur-receivable-hedge-spec.md`
2. `data/2026-08-07-Yi-market-data.md`

The Excel workbook, previous calculations, Stage 3 audit, and previous LLM conversations were not provided.

No corrections, coaching, or workbook results were supplied during the independent run.

### Prompt Used

> Using only the attached hedge specification and market-data memo, independently calculate the outcomes for the unhedged position, forward hedge, money-market hedge, put option hedge, and call option where applicable. Evaluate the strategies across representative terminal EUR/USD spot rates, explain the sensitivity of each strategy, and recommend the most appropriate hedge strategy for the firm. Show the calculations and assumptions used.

The complete raw LLM output is preserved separately in:

`analysis/2026-08-14-Yi-llm-output.md`

[View the raw independent LLM output](./2026-08-14-Yi-llm-output.md)

---

## 2. Stage 4 Inputs Used by the Independent LLM

The independent LLM used the values documented in the Stage 4 market-data memo.

| Input | Stage 4 Value | Source / Basis |
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

Three representative terminal EUR/USD scenarios were used for comparison:

- 5% EUR depreciation: `S_T = 1.095825`
- No change from spot: `S_T = 1.153500`
- 5% EUR appreciation: `S_T = 1.211175`

---

## 3. Initial LLM vs. Workbook Comparison

The independent LLM and workbook initially produced different results.

The cause was that the workbook still contained the Stage 2 placeholder market inputs, while the independent LLM used the Stage 4 market-data values.

The workbook still contained:

| Input | Workbook Value | Stage 4 Value |
|---|---:|---:|
| `S0_in` | 1.1000 | 1.1535 |
| `F0_in` | 1.1000 | 1.1662946810 |
| `R_USD` | 5.30% | 4.01% |
| `R_FC` | 3.00% | 2.884% |
| `K_PUT` | 1.1000 | 1.1535 |
| `K_CALL` | 1.1000 | 1.1535 |

The workbook Validation tab also continued to report:

`Market Data Status = PLACEHOLDER`

### Comparison Table

Difference is calculated as:

`LLM Result - Workbook Result`

| S_T Scenario | Strategy | LLM Result | Initial Workbook Result | Difference | Diagnosis |
|---|---|---:|---:|---:|---|
| -5% | Unhedged | $4,931,212.50 | $4,702,500.00 | $228,712.50 | **Workbook error** |
| -5% | Forward | $5,248,326.06 | $4,950,000.00 | $298,326.06 | **Workbook error** |
| -5% | Money Market | $5,248,326.06 | $5,062,023.86 | $186,302.20 | **Workbook error** |
| -5% | Put Option | $5,073,676.09 | $4,831,454.69 | $242,221.40 | **Workbook error** |
| -5% | Call Option | N/A | Illustrative only | N/A | **Spec ambiguity** |
| 0% | Unhedged | $5,190,750.00 | $4,950,000.00 | $240,750.00 | **Workbook error** |
| 0% | Forward | $5,248,326.06 | $4,950,000.00 | $298,326.06 | **Workbook error** |
| 0% | Money Market | $5,248,326.06 | $5,062,023.86 | $186,302.20 | **Workbook error** |
| 0% | Put Option | $5,073,676.09 | $4,831,454.69 | $242,221.40 | **Workbook error** |
| 0% | Call Option | N/A | Illustrative only | N/A | **Spec ambiguity** |
| +5% | Unhedged | $5,450,287.50 | $5,197,500.00 | $252,787.50 | **Workbook error** |
| +5% | Forward | $5,248,326.06 | $4,950,000.00 | $298,326.06 | **Workbook error** |
| +5% | Money Market | $5,248,326.06 | $5,062,023.86 | $186,302.20 | **Workbook error** |
| +5% | Put Option | $5,333,213.59 | $5,078,954.69 | $254,258.90 | **Workbook error** |
| +5% | Call Option | N/A | Illustrative only | N/A | **Spec ambiguity** |

---

## 4. Diagnosis of Differences

### Workbook Error

The unhedged, forward, money-market, and put differences were classified as **Workbook error**.

The formulas themselves were not the main problem. The workbook was still using the Stage 2 placeholder market values instead of the Stage 4 values documented in the market-data memo.

For example:

Independent LLM:

`S0_in = 1.1535`

Workbook:

`S0_in = 1.1000`

The same issue occurred with:

- `F0_in`
- `R_USD`
- `R_FC`
- `K_PUT`
- `K_CALL`

Because the two models were using different inputs, they naturally produced different outcomes.

The independent LLM correctly followed the Stage 4 market-data memo, while the workbook had not yet completed the Stage 4 population step.

Therefore, these discrepancies were classified as:

**Workbook error**

rather than LLM error.

### Call Option — Spec Ambiguity

The call option produced a different issue.

The specification includes:

- `K_CALL`
- `PREM_CALL`

However, it also states that the call variables are primarily included for compatibility with a broader model and a foreign-currency payable scenario.

The specification identifies the **put option** as the primary option hedge for this EUR receivable because the company's risk is EUR depreciation.

The workbook contains an illustrative call calculation, but the specification does not clearly define a required call-plus-receivable hedge formula.

The independent LLM therefore did not calculate a call hedge because doing so would have required inventing additional model logic.

This discrepancy was classified as:

**Spec ambiguity**

---

## 5. Reconciliation

To reconcile the results, the workbook formulas were evaluated using the Stage 4 market-data values rather than the original Stage 2 placeholders.

The Stage 4 inputs used were:

`FC_AMT = 4,500,000`

`S0_in = 1.1535`

`F0_in = 1.1662946810`

`R_USD = 4.01%`

`R_FC = 2.884%`

`K_PUT = 1.1535`

`K_CALL = 1.1535`

`PREM_PUT = 0.0250`

`PREM_CALL = 0.0250`

`T_DAYS = 365`

`BASIS = 360`

### Reconciled Results

| S_T Scenario | Strategy | Recalculated Workbook Result | LLM Result | Reconciliation |
|---|---|---:|---:|---|
| -5% | Unhedged | $4,931,212.50 | $4,931,212.50 | **Match** |
| -5% | Forward | $5,248,326.06 | $5,248,326.06 | **Match** |
| -5% | Money Market | $5,248,326.06 | $5,248,326.06 | **Match** |
| -5% | Put Option | $5,073,676.09 | $5,073,676.09 | **Match** |
| 0% | Unhedged | $5,190,750.00 | $5,190,750.00 | **Match** |
| 0% | Forward | $5,248,326.06 | $5,248,326.06 | **Match** |
| 0% | Money Market | $5,248,326.06 | $5,248,326.06 | **Match** |
| 0% | Put Option | $5,073,676.09 | $5,073,676.09 | **Match** |
| +5% | Unhedged | $5,450,287.50 | $5,450,287.50 | **Match** |
| +5% | Forward | $5,248,326.06 | $5,248,326.06 | **Match** |
| +5% | Money Market | $5,248,326.06 | $5,248,326.06 | **Match** |
| +5% | Put Option | $5,333,213.59 | $5,333,213.59 | **Match** |

The forward and money-market hedge results are economically equivalent because the Stage 4 forward rate was calculated using covered interest parity from the same spot and interest-rate inputs.

Any difference beyond the displayed cents is caused by rounding and the number of decimal places retained in the calculated forward rate.

The actual Excel workbook should be updated with these Stage 4 values before final submission so that the saved workbook itself reflects the reconciled results.

---

## 6. Hand Verification

The following calculations were independently recomputed using calculator arithmetic and named-range notation.

Excel formulas were not used to perform these calculations.

The three required outcomes are:

1. Forward hedge proceeds
2. Money-market hedge, including all three steps
3. Put option outcome under a 5% EUR depreciation scenario

### Hand-Verification Summary

| Outcome | Formula | Arithmetic | Verified Result |
|---|---|---|---:|
| Forward | `USD_FWD = FC_AMT × F0_in` | `4,500,000 × 1.1662946810` | **$5,248,326.06** |
| MM Borrow EUR | `FC_BORROW = FC_AMT / DF_FC` | `4,500,000 / 1.0292405556` | **€4,372,155.74** |
| MM Convert USD | `USD_NOW = FC_BORROW × S0_in` | `4,372,155.74 × 1.1535` | **$5,043,281.64** |
| MM Invest USD | `USD_MM = USD_NOW × DF_USD` | `5,043,281.64 × 1.0406569444` | **$5,248,326.06** |
| Put at -5% | `USD_PUT = MAX(S_T,K_PUT) × FC_AMT + FV_PREM_PUT` | `1.1535 × 4,500,000 - 117,073.91` | **$5,073,676.09** |

---

## 7. Forward Hedge Hand Verification

### Inputs

`FC_AMT = €4,500,000`

This amount comes directly from the assigned project scenario. The company expects to receive €4.5 million at settlement.

`F0_in = 1.1662946810 USD/EUR`

The Stage 4 market-data memo calculated this one-year forward rate using covered interest parity because a directly comparable live dealer forward quote was not used.

### Formula

`USD_FWD = FC_AMT × F0_in`

### Calculation

`USD_FWD = 4,500,000 × 1.1662946810`

`USD_FWD = 5,248,326.0645`

Rounded to cents:

**$5,248,326.06**

### Verification

The forward hedge locks approximately **$5.248 million** at settlement.

This amount does not depend on the terminal EUR/USD exchange rate.

---

## 8. Money-Market Hedge Hand Verification

The money-market hedge has three main steps:

1. Borrow EUR today.
2. Convert the borrowed EUR into USD.
3. Invest the USD until settlement.

### Step 1 — Borrow EUR Today

The EUR interest rate is:

`R_FC = 2.884%`

Convert the percentage to decimal form:

`R_FC = 0.02884`

The settlement horizon is:

`T_DAYS = 365`

The model uses:

`BASIS = 360`

First calculate the EUR accumulation factor.

### Formula

`DF_FC = 1 + R_FC × T_DAYS / BASIS`

### Calculation

`DF_FC = 1 + 0.02884 × 365 / 360`

`365 / 360 = 1.013888889`

`0.02884 × 1.013888889 = 0.029240556`

`DF_FC = 1 + 0.029240556`

**DF_FC = 1.0292405556**

Now calculate the amount of EUR that must be borrowed today.

### Formula

`FC_BORROW = FC_AMT / DF_FC`

### Calculation

`FC_BORROW = 4,500,000 / 1.0292405556`

**FC_BORROW = €4,372,155.74**

At settlement:

`4,372,155.74 × 1.0292405556 ≈ 4,500,000`

Therefore, the future EUR receivable can repay the EUR borrowing.

### Step 2 — Convert EUR to USD

The Stage 4 spot rate is:

`S0_in = 1.1535 USD/EUR`

### Formula

`USD_NOW = FC_BORROW × S0_in`

### Calculation

`USD_NOW = 4,372,155.74 × 1.1535`

**USD_NOW = $5,043,281.64**

The company therefore receives approximately **$5.043 million today** after converting the borrowed euros.

### Step 3 — Invest USD Until Settlement

The USD interest rate is:

`R_USD = 4.01%`

Convert the percentage to decimal form:

`R_USD = 0.0401`

Calculate the USD accumulation factor.

### Formula

`DF_USD = 1 + R_USD × T_DAYS / BASIS`

### Calculation

`DF_USD = 1 + 0.0401 × 365 / 360`

`365 / 360 = 1.013888889`

`0.0401 × 1.013888889 = 0.040656944`

`DF_USD = 1 + 0.040656944`

**DF_USD = 1.0406569444**

Now calculate the settlement proceeds.

### Formula

`USD_MM = USD_NOW × DF_USD`

### Calculation

`USD_MM = 5,043,281.64 × 1.0406569444`

**USD_MM = $5,248,326.06**

### Verification

The money-market hedge produces approximately **$5.248 million at settlement**.

This closely matches the forward hedge because the Stage 4 forward rate was calculated using covered interest parity.

---

## 9. Put Option Hand Verification

The put option was verified using the 5% EUR depreciation scenario.

This scenario demonstrates how the put protects the company when the euro weakens.

### Step 1 — Calculate Terminal Spot Rate

The Stage 4 spot rate is:

`S0_in = 1.1535`

A 5% depreciation is:

`S_T = S0_in × 0.95`

### Calculation

`S_T = 1.1535 × 0.95`

**S_T = 1.095825**

### Step 2 — Determine Whether the Put Is Exercised

The put strike is:

`K_PUT = 1.1535`

Compare:

`S_T = 1.095825`

to:

`K_PUT = 1.1535`

Because:

`1.095825 < 1.1535`

the market rate is below the strike.

Therefore, the company exercises the put.

### Step 3 — Calculate Gross Protected Proceeds

### Formula

`Gross Put Proceeds = K_PUT × FC_AMT`

### Calculation

`Gross Put Proceeds = 1.1535 × 4,500,000`

**Gross Put Proceeds = $5,190,750.00**

### Step 4 — Calculate Put Premium

The Stage 4 put premium is:

`PREM_PUT = 0.0250 USD/EUR`

### Formula

`Premium Today = PREM_PUT × FC_AMT`

### Calculation

`Premium Today = 0.0250 × 4,500,000`

**Premium Today = $112,500.00**

The technical specification requires the premium to be future-valued to settlement.

### Formula

`FV_PREM_PUT = -PREM_PUT × FC_AMT × DF_USD`

### Calculation

`FV_PREM_PUT = -0.0250 × 4,500,000 × 1.0406569444`

`FV_PREM_PUT = -112,500 × 1.0406569444`

**FV_PREM_PUT = -$117,073.91**

### Step 5 — Calculate Net Put Proceeds

### Formula

`USD_PUT = MAX(S_T,K_PUT) × FC_AMT + FV_PREM_PUT`

Since the terminal spot rate is below the strike:

`MAX(1.095825,1.1535) = 1.1535`

### Calculation

`USD_PUT = 1.1535 × 4,500,000 - 117,073.91`

`USD_PUT = 5,190,750.00 - 117,073.91`

**USD_PUT = $5,073,676.09**

### Comparison With No Hedge

At the same terminal spot rate:

`USD_NO_HEDGE = S_T × FC_AMT`

`USD_NO_HEDGE = 1.095825 × 4,500,000`

**USD_NO_HEDGE = $4,931,212.50**

Protection provided by the put:

`5,073,676.09 - 4,931,212.50`

**$142,463.59**

The put therefore protects approximately **$142,464** of settlement proceeds relative to remaining unhedged in this scenario.

---

## 10. Hand-Verification Conclusion

The hand calculations confirm the core results produced by the independent LLM using the Stage 4 market-data inputs.

The manually verified results are:

- Forward hedge: **$5,248,326.06**
- Money-market hedge: **$5,248,326.06**
- Put hedge at 5% EUR depreciation: **$5,073,676.09**

The forward and money-market hedge results are nearly identical because of covered interest parity.

The put provides a lower guaranteed settlement amount because of the option premium, but it provides downside protection while preserving the ability to benefit from EUR appreciation.

---

## 11. Spec Retrospective

The independent LLM test revealed two areas where the project could be improved.

### Data-Readiness Issue

The first issue was a data-readiness problem.

The independent LLM correctly used the Stage 4 market-data memo, while my uploaded workbook was still populated with the Stage 2 placeholder values.

The workbook formulas passed the structural validation checks, but the Validation tab continued to show:

`Market Data Status = PLACEHOLDER`

I had documented the Stage 4 market values but had not completed the final population step in the saved workbook before beginning the Stage 5 comparison.

This showed me that having a mathematically correct model and having a production-ready model are not the same thing.

The specification stated that Stage 4 should replace the placeholder inputs, but it did not make the placeholder status a strong enough stopping condition in the workflow.

In a version 2 specification, I would require that the model cannot move into Stage 5 unless every required market input has:

- A non-placeholder status
- A documented source
- An as-of date
- Agreement with the Stage 4 market-data memo

I would also require the final data status to show `LIVE` or another approved final status before the model could be used for the recommendation.

This would prevent an analyst from accidentally comparing a live-data LLM analysis against an outdated workbook.

### Call Option Ambiguity

The second issue involved the call option.

The specification defines:

- `K_CALL`
- `PREM_CALL`

However, it also says that the call variables are included mainly for compatibility with a broader model and a foreign-currency payable scenario.

The specification does not clearly state whether the call should be treated as one of the primary hedge strategies for this EUR receivable.

It also does not provide a required receivable-plus-call formula.

The workbook therefore included an illustrative call calculation, while the independent LLM chose not to calculate a call hedge because doing so would require inventing a rule that was not explicitly defined.

I classify this difference as:

**Spec ambiguity**

In a version 2 specification, I would make the call treatment explicit.

I would either state that the call option should be excluded from the EUR receivable decision set because it does not protect against the primary risk of EUR depreciation, or I would provide the exact formula and interpretation required if the call must appear in the comparison.

### Retrospective Conclusion

Overall, the independent test showed that the core hedge formulas were reproducible from the specification.

However, the test also demonstrated why a strong specification needs to cover workflow controls and edge cases in addition to the mathematical formulas.

A model can be mathematically correct and still fail a production handoff if the data status or treatment of an instrument is unclear.

A future version of the specification would therefore include stronger market-data completion controls and clearer instructions for the call option.

---

## 12. Validation Conclusion

The Stage 5 validation identified two meaningful issues.

First, the saved workbook was still using Stage 2 placeholder market inputs even though the Stage 4 market-data memo contained updated values.

This caused the initial discrepancies between the workbook and the independent LLM.

The unhedged, forward, money-market, and put differences were classified as:

**Workbook error**

because the workbook formulas were intact but the market inputs had not been repopulated.

Second, the treatment of the call option was not fully defined for the EUR receivable.

This was classified as:

**Spec ambiguity**

When the workbook formulas are evaluated using the Stage 4 market-data values, the unhedged, forward, money-market, and put outcomes reconcile with the independent LLM results.

The hand calculations also independently confirm:

- Forward proceeds of **$5,248,326.06**
- Money-market hedge proceeds of **$5,248,326.06**
- Put proceeds of **$5,073,676.09** under a 5% EUR depreciation scenario

The validation therefore confirmed the core hedge calculations while also identifying an important workbook population issue and a specification gap related to the call option.

Before final submission, the actual Excel workbook must be repopulated with the Stage 4 market-data values so that the workbook saved in the repository reflects the reconciled results documented in this validation.
