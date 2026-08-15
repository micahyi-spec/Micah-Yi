---
title: "EUR Receivable FX Hedge — Stage 5 Independent LLM Analysis"
author: "Micah Yi"
date: "2026-08-14"
version: "1.0"
---

# EUR Receivable FX Hedge — Stage 5 Independent LLM Analysis

## 1. Independent LLM Execution

For this analysis, the LLM was provided only the following two documents:

1. `docs/specs/2026-08-07-Yi-eur-receivable-hedge-spec.md`
2. `data/2026-08-07-Yi-market-data.md`

No workbook results, previous calculations, or corrections were provided.

### Prompt Used

> Using only the attached hedge specification and market-data memo, independently calculate the outcomes for the unhedged position, forward hedge, money-market hedge, put option hedge, and call option where applicable. Evaluate the strategies across representative terminal EUR/USD spot rates, explain the sensitivity of each strategy, and recommend the most appropriate hedge strategy for the firm. Show the calculations and assumptions used.

---

## 2. Inputs and Assumptions

| Input | Value |
|---|---:|
| `FC_AMT` | €4,500,000 |
| `S0_in` | 1.1535 USD/EUR |
| `F0_in` | 1.1662946810 USD/EUR |
| `R_USD` | 4.01% |
| `R_FC` | 2.884% |
| `T_DAYS` | 365 |
| `BASIS` | 360 |
| `K_PUT` | 1.1535 USD/EUR |
| `PREM_PUT` | 0.0250 USD/EUR |
| `K_CALL` | 1.1535 USD/EUR |
| `PREM_CALL` | 0.0250 USD/EUR |

The model uses simple annual interest with an ACT/360 convention.

Option premiums are paid upfront and future-valued using the USD interest rate so that all strategies are compared at the settlement date.

---

## 3. Derived Values

### USD Accumulation Factor

Formula:

`DF_USD = 1 + R_USD × T_DAYS / BASIS`

Calculation:

`DF_USD = 1 + 0.0401 × 365 / 360`

Result:

`DF_USD = 1.0406569444`

### EUR Accumulation Factor

Formula:

`DF_FC = 1 + R_FC × T_DAYS / BASIS`

Calculation:

`DF_FC = 1 + 0.02884 × 365 / 360`

Result:

`DF_FC = 1.0292405556`

### Future Value of Put Premium

Initial premium:

`PREM_PUT × FC_AMT`

`0.0250 × 4,500,000 = $112,500`

Settlement-date economic cost:

`FV_PREM_PUT = -PREM_PUT × FC_AMT × DF_USD`

`FV_PREM_PUT = -0.0250 × 4,500,000 × 1.0406569444`

Result:

`FV_PREM_PUT = -$117,073.91`

---

# 4. Unhedged Position

Formula:

`USD_NO_HEDGE = S_T × FC_AMT`

Three representative terminal EUR/USD scenarios were evaluated.

## EUR Depreciates 5%

`S_T = 1.1535 × 0.95`

`S_T = 1.095825`

Calculation:

`USD_NO_HEDGE = 1.095825 × 4,500,000`

Result:

**$4,931,212.50**

## EUR Remains Unchanged

`S_T = 1.1535`

Calculation:

`USD_NO_HEDGE = 1.1535 × 4,500,000`

Result:

**$5,190,750.00**

## EUR Appreciates 5%

`S_T = 1.1535 × 1.05`

`S_T = 1.211175`

Calculation:

`USD_NO_HEDGE = 1.211175 × 4,500,000`

Result:

**$5,450,287.50**

The unhedged position has full exposure to EUR/USD movements.

Every $0.01 movement in the EUR/USD rate changes the value of the €4,500,000 receivable by approximately:

`$0.01 × 4,500,000 = $45,000`

---

# 5. Forward Hedge

Formula:

`USD_FWD = FC_AMT × F0_in`

Calculation:

`USD_FWD = 4,500,000 × 1.1662946810`

Result:

**$5,248,326.06**

The forward hedge produces the same USD proceeds regardless of the terminal EUR/USD exchange rate.

| Terminal EUR/USD | Unhedged | Forward | Forward Advantage / (Disadvantage) |
|---:|---:|---:|---:|
| 1.095825 | $4,931,212.50 | $5,248,326.06 | +$317,113.56 |
| 1.153500 | $5,190,750.00 | $5,248,326.06 | +$57,576.06 |
| 1.211175 | $5,450,287.50 | $5,248,326.06 | -$201,961.44 |

The forward removes downside risk but also prevents the company from benefiting from favorable EUR appreciation.

---

# 6. Money-Market Hedge

The money-market hedge consists of three steps.

## Step 1 — Borrow EUR Today

Formula:

`FC_BORROW = FC_AMT / DF_FC`

Calculation:

`FC_BORROW = 4,500,000 / 1.0292405556`

Result:

**€4,372,155.74**

At settlement:

`4,372,155.74 × 1.0292405556 ≈ €4,500,000`

The future receivable therefore repays the EUR borrowing.

## Step 2 — Convert Borrowed EUR to USD

Formula:

`USD_NOW = FC_BORROW × S0_in`

Calculation:

`USD_NOW = 4,372,155.74 × 1.1535`

Result:

**$5,043,281.64**

## Step 3 — Invest USD Until Settlement

Formula:

`USD_MM = USD_NOW × DF_USD`

Calculation:

`USD_MM = 5,043,281.64 × 1.0406569444`

Result:

**$5,248,326.06**

The money-market hedge therefore produces approximately the same settlement proceeds as the forward hedge.

---

## 7. Covered Interest Parity Check

Formula:

`F_implied = S0_in × DF_USD / DF_FC`

Calculation:

`F_implied = 1.1535 × 1.0406569444 / 1.0292405556`

Result:

**1.1662946810 USD/EUR**

This matches the Stage 4 forward rate:

`F0_in = 1.1662946810`

Because the Stage 4 forward rate was calculated using covered interest parity, the forward and money-market hedge produce effectively identical results.

---

# 8. Put Option Hedge

Formula:

`USD_PUT = MAX(S_T, K_PUT) × FC_AMT + FV_PREM_PUT`

Where:

`K_PUT = 1.1535`

and:

`FV_PREM_PUT = -$117,073.91`

---

## EUR Depreciates 5%

Terminal rate:

`S_T = 1.095825`

Because:

`1.095825 < 1.1535`

the put is exercised.

Gross proceeds:

`1.1535 × 4,500,000 = $5,190,750.00`

Subtract premium cost:

`$5,190,750.00 - $117,073.91`

Result:

**$5,073,676.09**

Compared with remaining unhedged:

`$5,073,676.09 - $4,931,212.50`

Benefit:

**+$142,463.59**

---

## EUR Remains Unchanged

At:

`S_T = 1.1535`

Put proceeds:

`$5,190,750.00 - $117,073.91`

Result:

**$5,073,676.09**

Compared with unhedged:

`$5,073,676.09 - $5,190,750.00`

Difference:

**-$117,073.91**

The difference represents the settlement-date economic cost of the option premium.

---

## EUR Appreciates 5%

Terminal rate:

`S_T = 1.211175`

Because:

`1.211175 > 1.1535`

the put expires unused.

Gross proceeds:

`1.211175 × 4,500,000`

`= $5,450,287.50`

Subtract premium cost:

`$5,450,287.50 - $117,073.91`

Result:

**$5,333,213.59**

The put allows the company to participate in EUR appreciation while maintaining protection against depreciation.

---

# 9. Call Option

The specification includes `K_CALL` and `PREM_CALL`, but it does not define a call-option hedge formula for the EUR receivable.

The specification states that the call variables are included primarily for compatibility with the broader model and a foreign-currency payable scenario.

For this transaction, the company will receive EUR.

The company's primary risk is:

**EUR depreciation against the USD.**

A purchased EUR put protects against this risk.

A purchased EUR call would primarily protect against EUR appreciation, which is favorable for a EUR receivable.

Therefore, a call-option hedge is considered **not applicable to the primary receivable hedge analysis** based strictly on the supplied specification.

---

# 10. Sensitivity Analysis

| Change from Spot | Terminal Rate `S_T` | No Hedge | Forward | Money Market | Put Option |
|---:|---:|---:|---:|---:|---:|
| -5% | 1.095825 | $4,931,212.50 | $5,248,326.06 | $5,248,326.06 | $5,073,676.09 |
| -4% | 1.107360 | $4,983,120.00 | $5,248,326.06 | $5,248,326.06 | $5,073,676.09 |
| -3% | 1.118895 | $5,035,027.50 | $5,248,326.06 | $5,248,326.06 | $5,073,676.09 |
| -2% | 1.130430 | $5,086,935.00 | $5,248,326.06 | $5,248,326.06 | $5,073,676.09 |
| -1% | 1.141965 | $5,138,842.50 | $5,248,326.06 | $5,248,326.06 | $5,073,676.09 |
| 0% | 1.153500 | $5,190,750.00 | $5,248,326.06 | $5,248,326.06 | $5,073,676.09 |
| +1% | 1.165035 | $5,242,657.50 | $5,248,326.06 | $5,248,326.06 | $5,125,583.59 |
| +2% | 1.176570 | $5,294,565.00 | $5,248,326.06 | $5,248,326.06 | $5,177,491.09 |
| +3% | 1.188105 | $5,346,472.50 | $5,248,326.06 | $5,248,326.06 | $5,229,398.59 |
| +4% | 1.199640 | $5,398,380.00 | $5,248,326.06 | $5,248,326.06 | $5,281,306.09 |
| +5% | 1.211175 | $5,450,287.50 | $5,248,326.06 | $5,248,326.06 | $5,333,213.59 |

---

# 11. Sensitivity Interpretation

## EUR Depreciation

When the euro weakens, the forward and money-market hedges provide the strongest protection.

At a 5% EUR depreciation:

- No hedge: **$4,931,212.50**
- Forward: **$5,248,326.06**
- Money market: **$5,248,326.06**
- Put: **$5,073,676.09**

The forward and money-market strategies protect approximately:

**$317,113.56**

relative to remaining unhedged.

The put also protects the company from a weaker euro, but the option premium reduces the protected proceeds.

---

## EUR Near Current Spot

At:

`S_T = 1.1535`

the forward and money-market hedge each produce:

**$5,248,326.06**

The unhedged position produces:

**$5,190,750.00**

The put produces:

**$5,073,676.09**

At this exchange rate, the forward and money-market hedge provide approximately:

**$57,576.06**

more than remaining unhedged.

---

## EUR Appreciation

When the euro appreciates, the unhedged position benefits the most.

At a 5% EUR appreciation:

- No hedge: **$5,450,287.50**
- Put: **$5,333,213.59**
- Forward: **$5,248,326.06**
- Money market: **$5,248,326.06**

The put maintains upside participation but continues to trail the unhedged position because of the option premium.

The forward and money-market hedge sacrifice favorable upside in exchange for certainty.

---

# 12. Independent LLM Recommendation

Based only on the hedge specification and Stage 4 market-data memo, the recommended strategy is the **forward hedge** for the full €4,500,000 receivable.

The forward locks in approximately:

**$5,248,326.06**

at settlement.

This completely eliminates the company's exposure to EUR depreciation.

At a 5% EUR depreciation, the forward produces approximately:

**$317,113.56**

more than remaining unhedged.

At the current spot-rate scenario, the forward produces approximately:

**$57,576.06**

more than the unhedged position.

The money-market hedge produces essentially the same result because the Stage 4 forward rate was calculated using covered interest parity. However, the forward hedge is operationally simpler because it does not require the company to borrow EUR, convert the borrowing into USD, and invest the USD proceeds.

The put option is also a defensible alternative if management places greater importance on participating in possible EUR appreciation. The put creates a downside floor of approximately:

**$5,073,676.09**

while still allowing the company to benefit from a stronger euro.

However, this flexibility has a settlement-date economic premium cost of approximately:

**$117,073.91**

Based on the supplied inputs, the forward provides the best combination of downside protection, cash-flow certainty, and simplicity.

---

# 13. Important Limitation

The Stage 4 forward rate is a **CIP-implied rate**, not a directly observed executable dealer forward quote.

The option premium of:

`0.0250 USD/EUR`

is also a scenario assumption rather than a live market option quote.

Therefore, the recommendation reflects the economics of the supplied Stage 4 model inputs and should not be interpreted as proof that an actual executable forward contract would necessarily outperform a live market-priced option.

---

# 14. Independent Conclusion

Based strictly on the supplied Stage 2 specification and Stage 4 market-data memo:

- **Forward hedge:** strongest recommendation for certainty and downside protection.
- **Money-market hedge:** economically equivalent to the forward under the supplied CIP-based inputs.
- **Put option:** provides downside protection and upside participation but carries a meaningful premium cost.
- **No hedge:** provides maximum upside but leaves the company fully exposed to EUR depreciation.
- **Call option:** not applicable as the primary hedge for this EUR receivable under the supplied specification.

The independent LLM therefore recommends the **forward hedge** as the primary strategy for the €4,500,000 EUR receivable.
