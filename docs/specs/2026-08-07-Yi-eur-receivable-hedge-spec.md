<div style="border-top: 6px solid #024731; border-bottom: 1px solid #B2B2B2; padding: 12px 0; margin-bottom: 24px; font-family: 'Open Sans', Helvetica, Arial, sans-serif;">
  <div style="color: #024731; font-weight: 700; letter-spacing: 0.06em; text-transform: uppercase; font-size: 0.85rem;">University of Hawaiʻi at Mānoa · Shidler College of Business</div>
  <div style="color: #000000; font-weight: 700; font-size: 1.25rem; margin-top: 4px;">FIN-321 International Finance &amp; Securities</div>
  <div style="color: #525252; font-weight: 400; font-size: 0.95rem;">FX Transaction Hedging Project — Technical Specification</div>
</div>

<!--
BRAND FORMATTING — applied per docs/_branding/design.json (v1.0.0)

Primary green: #024731
Primary black: #000000
Silver: #B2B2B2
White: #FFFFFF
Neutral-600: #525252
UH Green 700: #013D26
UH Green 50: #E6F2EF
Yellow (Excel inputs only): #FFFF00

Headings:
Open Sans Bold / Semibold

Body:
Open Sans Regular

Print:
Avenir Bold / Avenir Book

Accessibility:
- ADA-compliant contrast
- No red body type
- No custom gradients
- No custom color palettes outside approved brand standards
-->

# Company — EUR Receivable FX Transaction Hedge Model · Technical Specification

> <span style="color:#024731; font-weight:700;">Technical specification</span> for the EUR receivable foreign-exchange transaction hedge model. This document defines the named-range contract, workbook architecture, calculation flow, outputs, sensitivity analysis, assumptions, and validation checks precisely enough that an AI or another analyst could build or rebuild the workbook without additional instructions.

| Field | Value |
|------|------|
| **Created by** | Micah Yi |
| **Updated by** | Micah Yi |
| **Date Created** | 2026-08-07 |
| **Date Updated** | 2026-08-07 |
| **Version** | 0.2 |
| **LLM Used** | ChatGPT (GPT-5.6 Sol) — used to draft and refine the technical specification from the Stage 1 memo and course template |
| **Role** | Treasury Analyst / FP&A Analyst |
| **Audience** | CFO / Director of Treasury |
| **Companion Workbook** | `docs/spreadsheets/FIN 321 - Chapter 8 Transaction Hedging_2026_Yi.xlsx` |

---

## 1. Problem Statement

The company expects to receive a **€4,500,000 EUR-denominated receivable** one year after the original transaction date. The company's functional and reporting currency is the U.S. dollar, and all exchange rates in this model are quoted as **USD per EUR**.

Because the company will receive euros and ultimately convert them into U.S. dollars, a depreciation of the euro against the dollar would reduce the realized USD value of the receivable. For example, a decrease in EUR/USD from 1.10 to 1.00 would reduce the unhedged USD value of the €4,500,000 receivable from $4,950,000 to $4,500,000.

The objective of the model is to quantify and compare four strategies: **no hedge, forward hedge, money-market hedge, and put-option hedge**. The model will evaluate the trade-off between certainty, downside protection, premium cost, and participation in favorable EUR appreciation before a final recommendation is made.

The model is intended for corporate treasury decision support. It does not automatically recommend a hedge. Live market inputs will replace the Stage 2 placeholders in a later stage before management relies on the results.

---

## 2. Inputs (Known Variables)

All major inputs must be exposed through workbook **named ranges** so that the formulas remain readable, auditable, and portable between Excel, Python, documentation, and AI prompts.

Market inputs are the only values the analyst should normally change during scenario analysis.

All placeholder market values must be labeled:

**Indicative — replaced with live market data at Stage 4.**

### 2.1 Core Inputs

| Standardized Name | Description | Unit | Legacy Name / Alias | Stage 2 Placeholder |
|-------------------|-------------|------|---------------------|--------------------:|
| `FC_AMT` | EUR receivable amount | EUR | `recievable` *(legacy typo; retire)* | 4,500,000 |
| `S0_in` | EUR/USD spot exchange rate at inception | USD per EUR | `current_spot_price` | 1.1000 |
| `F0_in` | EUR/USD forward rate to settlement | USD per EUR | `for_EURUSD` | 1.1000 |
| `R_USD` | USD money-market interest rate | Annual % | `rate_us_1y` | 5.30% |
| `R_FC` | EUR money-market interest rate | Annual % | `rate_eur_1y` | 3.00% |
| `T_DAYS` | Days from inception to settlement | Days | — | 365 |
| `BASIS` | Day-count denominator used in simplified model | Days | — | 360 |
| `K_PUT` | EUR put-option strike | USD per EUR | `x_put` | 1.1000 |
| `K_CALL` | EUR call-option strike | USD per EUR | `call_strike` | 1.1000 |
| `PREM_PUT` | Put premium per EUR | USD per EUR | `put_price` | 0.0250 |
| `PREM_CALL` | Call premium per EUR | USD per EUR | `call_price` | 0.0250 |

`FC_AMT` is established by the underlying transaction and is not a market placeholder.

`S0_in`, `F0_in`, `R_USD`, `R_FC`, `K_PUT`, `K_CALL`, `PREM_PUT`, and `PREM_CALL` are indicative Stage 2 values and must be replaced with current market information in Stage 4.

`T_DAYS` should ultimately equal the exact number of calendar days between the transaction valuation date and the settlement date.

### Stage 4 Market Data Requirements

| Input | Stage 4 Requirement |
|------|----------------------|
| `S0_in` | Current EUR/USD spot rate from an approved market-data source |
| `F0_in` | Forward quote matching the remaining maturity of the receivable |
| `R_USD` | USD money-market rate matching the hedge horizon |
| `R_FC` | EUR money-market rate matching the hedge horizon |
| `K_PUT` | Selected EUR put strike at or near spot |
| `K_CALL` | Selected EUR call strike at or near spot |
| `PREM_PUT` | Market premium for the selected EUR put |
| `PREM_CALL` | Market premium for the selected EUR call |
| `T_DAYS` | Exact days remaining until settlement |

The workbook `Inputs` area must record a **source, access date, and PLACEHOLDER/LIVE status** for each market input.

### 2.2 Derived / Intermediate Values

| Name | Description | Formula / Source |
|------|-------------|------------------|
| `DF_USD` | USD accumulation factor through settlement | `1 + R_USD × T_DAYS / BASIS` |
| `DF_FC` | EUR accumulation factor through settlement | `1 + R_FC × T_DAYS / BASIS` |
| `FV_PREM_PUT` | Future value of put premium at settlement | `−PREM_PUT × FC_AMT × DF_USD` |
| `FV_PREM_CALL` | Future value of call premium at settlement | `−PREM_CALL × FC_AMT × DF_USD` |
| `S_T_grid` | Terminal EUR/USD sensitivity grid | `S0_in × 0.95` through `S0_in × 1.05` |
| `USD_NO_HEDGE` | USD proceeds without hedging | `S_T × FC_AMT` |
| `USD_FWD` | USD proceeds under forward hedge | `FC_AMT × F0_in` |
| `USD_MM` | USD proceeds under money-market hedge | `(FC_AMT / DF_FC) × S0_in × DF_USD` |
| `USD_PUT` | USD proceeds under put-option hedge | `MAX(S_T, K_PUT) × FC_AMT + FV_PREM_PUT` |
| `F_implied` | Forward rate implied by covered interest parity | `S0_in × DF_USD / DF_FC` |

The standardized names must be used throughout the production workbook. Legacy names may be retained temporarily as aliases only if required for compatibility with an existing course workbook.

---

## 3. Assumptions & Constraints

The following assumptions apply throughout the model.

- **Exposure type:** EUR-denominated receivable.
- **Functional currency:** USD.
- **Quote convention:** All FX rates are expressed as **USD per EUR**.
- **Direction of risk:** EUR depreciation reduces USD proceeds.
- **Horizon:** Single-settlement transaction approximately one year from inception.
- **Settlement timing:** `T_DAYS = 365` in the Stage 2 placeholder model and must be replaced with the exact remaining maturity when live market data are inserted.
- **Day-count basis:** The simplified workbook uses `BASIS = 360`. All interest calculations therefore use `T_DAYS / BASIS`.
- **Interest convention:** Simple annual money-market interest.
- **Forward hedge:** Assumed to have no upfront premium and to settle at the same time as the receivable.
- **Money-market hedge:** Borrow EUR today, convert the borrowed EUR to USD, and invest the USD to settlement.
- **Covered interest parity:** The money-market hedge should economically replicate the forward hedge when quoted market inputs are consistent.
- **Option premium:** Paid upfront in USD and treated as a negative cash flow. The premium is future-valued at `R_USD` so the cost is expressed at the same settlement date as all other hedge proceeds.
- **Put option:** Used as the primary option hedge for the EUR receivable because it establishes a minimum EUR selling rate while retaining upside if EUR appreciates.
- **Call option:** Included in the named-range structure for compatibility with the broader model and payable variant, but is not the primary hedge instrument for this receivable.
- **Option contract multiplier:** None. Premiums are quoted directly per 1 EUR.
- **Transaction costs:** Bid-ask spreads, commissions, brokerage fees, credit charges, taxes, margin costs, and other execution costs are excluded from the base model.
- **Counterparty risk:** Excluded.
- **Credit risk:** Excluded.
- **Tax treatment:** Excluded.
- **Hedge-accounting treatment:** Excluded.
- **Probability assumptions:** None. Terminal spot scenarios are deterministic rather than probability weighted.
- **Notional:** The model assumes the full €4,500,000 exposure is hedged rather than partially or dynamically hedged.
- **Rounding:** Calculations retain full precision. FX rates should display at least four decimal places and monetary values should display in USD or EUR with appropriate separators.
- **Recommendation timing:** No final strategy recommendation should be generated until live market data replace the placeholders and all validation checks have been completed.

---

## 4. Calculation Flow

All formulas are described using named-range notation. Stage 3 should translate these formulas directly into Excel without replacing named ranges with hard-coded cell references.

### Step 1 — Derived Inputs

Calculate the USD accumulation factor:

`DF_USD = 1 + R_USD × T_DAYS / BASIS`

Calculate the foreign-currency accumulation factor:

`DF_FC = 1 + R_FC × T_DAYS / BASIS`

Calculate the settlement-date economic cost of the put premium:

`FV_PREM_PUT = −PREM_PUT × FC_AMT × DF_USD`

Calculate the settlement-date economic cost of the call premium:

`FV_PREM_CALL = −PREM_CALL × FC_AMT × DF_USD`

The premium values are negative because they represent costs to the company.

---

### Step 2 — Forward Hedge

The company sells the €4,500,000 future receivable forward.

Calculate:

`USD_FWD = FC_AMT × F0_in`

The result represents the USD proceeds locked in at inception.

`USD_FWD` must remain constant for every value of `S_T`.

The forward hedge provides certainty but prevents the company from benefiting from a stronger euro at settlement.

---

### Step 3 — Money-Market Hedge

The money-market hedge replicates the economic effect of selling EUR forward using borrowing, spot conversion, and investment.

#### 3.1 Borrow EUR Today

Calculate the present amount of EUR that will grow to exactly `FC_AMT` at settlement:

`FC_BORROW = FC_AMT / DF_FC`

Equivalent expanded form:

`FC_BORROW = FC_AMT / (1 + R_FC × T_DAYS / BASIS)`

At maturity:

`FC_BORROW × DF_FC = FC_AMT`

The future €4,500,000 receivable therefore exactly repays the foreign-currency loan.

#### 3.2 Convert the EUR Borrowing to USD

Immediately convert the borrowed EUR at the inception spot rate:

`USD_NOW = FC_BORROW × S0_in`

Expanded:

`USD_NOW = (FC_AMT / DF_FC) × S0_in`

#### 3.3 Invest USD Until Settlement

Invest the USD received from the spot conversion:

`USD_MM = USD_NOW × DF_USD`

Expanded:

`USD_MM = (FC_AMT / DF_FC) × S0_in × DF_USD`

At settlement, the company receives the accumulated USD investment while the EUR customer payment repays the EUR borrowing.

#### 3.4 Covered Interest Parity Check

Calculate the forward rate implied by the two interest rates:

`F_implied = S0_in × DF_USD / DF_FC`

Expanded:

`F_implied = S0_in × (1 + R_USD × T_DAYS / BASIS) / (1 + R_FC × T_DAYS / BASIS)`

If quoted market inputs satisfy covered interest parity:

`F_implied ≈ F0_in`

and:

`USD_MM ≈ USD_FWD`

A persistent gap should be reported and investigated rather than hidden by changing the formulas.

---

### Step 4 — Option Hedge

The company purchases a put option on EUR with strike `K_PUT`.

The option establishes a downside floor while allowing the company to benefit from EUR appreciation.

At inception, the company pays:

`PREM_PUT × FC_AMT`

The settlement-date economic cost of that premium is:

`FV_PREM_PUT = −PREM_PUT × FC_AMT × DF_USD`

For each terminal exchange rate `S_T`, calculate:

`USD_PUT(S_T) = S_T × FC_AMT + MAX(0, (K_PUT − S_T) × FC_AMT) + FV_PREM_PUT`

Equivalent simplified form:

`USD_PUT(S_T) = MAX(S_T, K_PUT) × FC_AMT + FV_PREM_PUT`

#### When `S_T < K_PUT`

The put finishes in the money.

The company effectively converts the receivable at the strike rate.

`USD_PUT = K_PUT × FC_AMT + FV_PREM_PUT`

#### When `S_T = K_PUT`

The option is at the money.

`USD_PUT = K_PUT × FC_AMT + FV_PREM_PUT`

#### When `S_T > K_PUT`

The company allows the option to expire and converts the EUR at the more favorable market rate.

`USD_PUT = S_T × FC_AMT + FV_PREM_PUT`

The premium cost is incurred under all scenarios.

---

### Step 5 — No-Hedge Position

For every terminal EUR/USD rate in the sensitivity grid:

`USD_NO_HEDGE(S_T) = S_T × FC_AMT`

The no-hedge strategy provides full upside if EUR appreciates but also exposes the company to the full downside if EUR depreciates.

---

### Step 6 — Sensitivity Table

Construct:

`S_T_grid = S0_in × {0.95, 0.96, 0.97, 0.98, 0.99, 1.00, 1.01, 1.02, 1.03, 1.04, 1.05}`

For each terminal spot value, calculate:

| Column | Output | Formula |
|--------|--------|---------|
| Terminal spot | `S_T` | `S0_in × scenario factor` |
| No hedge | `USD_NO_HEDGE(S_T)` | `S_T × FC_AMT` |
| Forward | `USD_FWD` | `FC_AMT × F0_in` |
| Money market | `USD_MM` | `(FC_AMT / DF_FC) × S0_in × DF_USD` |
| Put option | `USD_PUT(S_T)` | `MAX(S_T, K_PUT) × FC_AMT + FV_PREM_PUT` |
| Forward hedge profit | `HEDGE_PROFIT_FWD` | `USD_FWD − USD_NO_HEDGE` |
| MM hedge profit | `HEDGE_PROFIT_MM` | `USD_MM − USD_NO_HEDGE` |
| Put hedge profit | `HEDGE_PROFIT_PUT` | `USD_PUT − USD_NO_HEDGE` |
| Overall winner | `WINNER_ALL` | Strategy with maximum USD proceeds |
| Best active hedge | `WINNER_HEDGE` | Maximum of forward, MM, and put only |

For the receivable:

`WINNER_ALL = ARGMAX(USD_NO_HEDGE, USD_FWD, USD_MM, USD_PUT)`

and:

`WINNER_HEDGE = ARGMAX(USD_FWD, USD_MM, USD_PUT)`

The output should return readable strategy labels such as:

- `No Hedge`
- `Forward`
- `Money Market`
- `Put Option`

---

### Step 7 — Summary Metrics

Calculate the minimum put-protected outcome across the grid:

`USD_FLOOR_PUT = MIN(USD_PUT across S_T_grid)`

Calculate the base-case outcome for each strategy at:

`S_T = S0_in`

Required base-case metrics:

`USD_BASE_NO_HEDGE`

`USD_BASE_FWD`

`USD_BASE_MM`

`USD_BASE_PUT`

Also calculate:

`PARITY_RATE_GAP = F0_in − F_implied`

and:

`PARITY_USD_GAP = USD_FWD − USD_MM`

These values support the validation process.

---

## 5. Outputs

The workbook must provide the following outputs in a clear and auditable structure.

| Output | Description | Format | Purpose |
|--------|-------------|--------|---------|
| Input panel | All named-range inputs with values, units, sources, and access dates | Input table | Single source of truth |
| Strategy summary | Base-case USD proceeds for all four strategies | Summary table | Executive comparison |
| `USD_FWD` | Locked forward USD proceeds | USD | Forward benchmark |
| `USD_MM` | Money-market USD proceeds | USD | Replication benchmark |
| `USD_FLOOR_PUT` | Minimum put-protected proceeds across sensitivity grid | USD | Downside protection |
| `F_implied` | CIP-implied forward rate | USD/EUR | Parity validation |
| `PARITY_RATE_GAP` | Difference between quoted and implied forward rates | USD/EUR | Data/parity check |
| `PARITY_USD_GAP` | Forward proceeds minus MM proceeds | USD | Formula/parity check |
| Sensitivity table | Strategy proceeds for every terminal FX scenario | Table | Core analytical evidence |
| Hedge-profit columns | Hedge outcome minus no-hedge outcome | USD | Hedge value-add |
| Overall winner | Highest USD proceeds including no hedge | Text label | Scenario decision cue |
| Best active hedge | Highest USD proceeds among hedge alternatives | Text label | Hedge comparison |
| Sensitivity chart | USD proceeds versus terminal EUR/USD | Line chart | Visual trade-off |
| Model status | PASS / FAIL | Status cell | Audit signal |
| Data status | PLACEHOLDER / LIVE | Status cell | Stage readiness |

### 5.1 Computed Base-Case Values

The base-case row is defined as:

`S_T = S0_in`

Using the Stage 2 placeholder values, the workbook must populate this table automatically after build.

| Strategy | USD Proceeds | Hedge Profit vs. No Hedge |
|----------|-------------:|--------------------------:|
| No hedge | calculated | — |
| Forward | calculated | calculated |
| Money market | calculated | calculated |
| Put option | calculated | calculated |

Do not hard-code these values into the specification or workbook.

They must be calculated from the named inputs so they update automatically when Stage 4 market data are entered.

---

## 6. Model Review — What Worked & What to Improve

### 6.1 What Worked

- **Standardized named-range structure.** The model uses consistent variables such as `FC_AMT`, `S0_in`, `F0_in`, `R_USD`, and `R_FC`, making the logic readable without relying on cell addresses.
- **Four strategies are compared on one basis.** No hedge, forward, money market, and put option are measured as USD proceeds at settlement.
- **Money-market pipeline is visible.** Borrowing, spot conversion, and USD investment are calculated separately rather than being hidden in one nested formula.
- **Covered interest parity provides a built-in error detector.** The forward and money-market hedge results can be checked against each other.
- **The option premium is placed on the same settlement-date basis as other proceeds.** This improves comparability across strategies.
- **Sensitivity analysis includes the baseline.** The `S_T = S0_in` row provides a recognizable reference point.
- **Winner labels improve readability.** Management can see both the overall winner and the strongest active hedge under each scenario.
- **Put payoff is calculated across the entire sensitivity grid.** This makes the option's downside floor and upside participation visible.

### 6.2 What to Improve

- **Live market information is not yet populated.** Stage 2 values are placeholders only. Stage 4 must replace spot, forward, rates, strikes, and premiums with sourced market observations.
- **A single `BASIS` is a simplification.** A more rigorous market implementation could use separate `BASIS_USD` and `BASIS_FC` values if the underlying instruments use different conventions.
- **Transaction costs are excluded.** Real-world forward spreads, option bid-ask spreads, bank charges, and execution costs could change the relative attractiveness of strategies.
- **Credit and counterparty risk are excluded.** The model assumes all counterparties perform as promised.
- **The model assumes a full hedge.** Partial or layered hedging could provide a different balance between certainty and flexibility.
- **Option premium is treated as an externally supplied input.** The model does not independently price the option using implied volatility.
- **The sensitivity range is limited to ±5%.** More severe stress scenarios could be added if management wants tail-risk analysis.
- **No probabilities are assigned.** The model compares outcomes but does not estimate how likely each terminal exchange rate is.
- **Call variables are retained for compatibility but are not central to this receivable model.** A payable version would use the call option as the primary option hedge.
- **The final recommendation is intentionally deferred.** The hedge decision should not be made until live market data are added and validation is complete.

### 6.3 Auditability Checklist

- [ ] `FC_AMT` is defined as €4,500,000
- [ ] Every major input has a standardized named range
- [ ] No major hedge formula relies on hard-coded market values
- [ ] All exchange rates use USD per EUR
- [ ] `T_DAYS` is positive
- [ ] `BASIS` is defined
- [ ] `DF_USD = 1 + R_USD × T_DAYS / BASIS`
- [ ] `DF_FC = 1 + R_FC × T_DAYS / BASIS`
- [ ] EUR borrowing grows to exactly `FC_AMT`
- [ ] Spot conversion equals `FC_BORROW × S0_in`
- [ ] Money-market proceeds equal `USD_NOW × DF_USD`
- [ ] `F_implied = S0_in × DF_USD / DF_FC`
- [ ] Forward and money-market proceeds are approximately equal when inputs satisfy parity
- [ ] Forward proceeds remain constant throughout the sensitivity grid
- [ ] Money-market proceeds remain constant throughout the sensitivity grid
- [ ] No-hedge proceeds equal `S_T × FC_AMT`
- [ ] Put proceeds equal `MAX(S_T, K_PUT) × FC_AMT + FV_PREM_PUT`
- [ ] Put payoff at `S_T = K_PUT` equals `K_PUT × FC_AMT + FV_PREM_PUT`
- [ ] Put proceeds are floored below `K_PUT`
- [ ] Put proceeds participate in EUR appreciation above `K_PUT`
- [ ] Sensitivity grid contains 11 observations
- [ ] First sensitivity observation equals `0.95 × S0_in`
- [ ] Baseline sensitivity observation equals `1.00 × S0_in`
- [ ] Final sensitivity observation equals `1.05 × S0_in`
- [ ] Hedge-profit columns equal hedge proceeds minus no-hedge proceeds
- [ ] Winner formulas compare the correct strategies
- [ ] Notes tab records market sources and access dates
- [ ] Placeholder inputs are clearly marked
- [ ] Input cells are visually distinguishable from formula cells
- [ ] Formula cells contain no unexplained constants
- [ ] Sensitivity chart references the same data as the sensitivity table
- [ ] Model integrity status is separated from market-data readiness status

### Validation Tolerances

Use the following default tolerances unless the course requires stricter limits.

**EUR loan repayment check**

`ABS(FC_BORROW × DF_FC − FC_AMT) <= 1 EUR`

**USD formula check**

Difference no greater than:

`$1.00`

**FX-rate formula check**

Difference no greater than:

`0.0001 USD/EUR`

**Forward/MM parity review**

A small real-market gap may exist.

Therefore:

- A formula mismatch is a model error.
- A quoted-market parity difference is a market observation and must not be hidden by overwriting `F0_in`.

### Model Status

`MODEL_STATUS = PASS`

only when all structural and formula checks pass.

Market-data status must be tracked separately:

`DATA_STATUS = PLACEHOLDER`

during Stage 2 / Stage 3.

After Stage 4 data replacement:

`DATA_STATUS = LIVE`

if all required market observations include sources and access dates.

---

## 7. Sensitivity Plan

The model must construct an 11-row terminal EUR/USD grid centered on the inception spot rate.

### Required Grid

`S_T_grid = S0_in × (1 + n × 1%)`

where:

`n = −5, −4, −3, −2, −1, 0, 1, 2, 3, 4, 5`

Therefore:

- `0.95 × S0_in`
- `0.96 × S0_in`
- `0.97 × S0_in`
- `0.98 × S0_in`
- `0.99 × S0_in`
- `1.00 × S0_in`
- `1.01 × S0_in`
- `1.02 × S0_in`
- `1.03 × S0_in`
- `1.04 × S0_in`
- `1.05 × S0_in`

### Strategies Compared

The sensitivity table must display:

1. No hedge
2. Forward hedge
3. Money-market hedge
4. Put-option hedge

### Hedge-Profit Analysis

For every scenario:

`HEDGE_PROFIT_FWD = USD_FWD − USD_NO_HEDGE`

`HEDGE_PROFIT_MM = USD_MM − USD_NO_HEDGE`

`HEDGE_PROFIT_PUT = USD_PUT − USD_NO_HEDGE`

A positive hedge-profit figure means the hedge produces greater USD proceeds than remaining unhedged under that terminal exchange-rate scenario.

A negative hedge-profit figure means the unhedged position would have produced greater proceeds.

### Winner Columns

For each row:

`WINNER_ALL = ARGMAX(USD_NO_HEDGE, USD_FWD, USD_MM, USD_PUT)`

and:

`WINNER_HEDGE = ARGMAX(USD_FWD, USD_MM, USD_PUT)`

The labels must display the strategy name rather than only the numerical maximum.

### Primary Chart

Create one line chart.

**Horizontal axis:**

`Terminal EUR/USD Exchange Rate (S_T)`

**Vertical axis:**

`USD Proceeds at Settlement`

**Series:**

- No Hedge
- Forward Hedge
- Money-Market Hedge
- Put Option Hedge

The chart should allow the CFO to see:

- The no-hedge strategy rises as EUR appreciates and falls as EUR depreciates.
- The forward hedge provides a constant USD outcome.
- The money-market hedge produces a similarly constant outcome.
- The put hedge establishes a downside floor.
- The put hedge retains upside participation above the strike.
- The cost of the option reduces proceeds relative to an otherwise identical unhedged outcome.

### Chart Formatting

Use:

| Series | Line Color | Style | Weight |
|--------|-----------:|-------|-------:|
| No hedge | `#000000` | Solid | 1.5 pt |
| Forward hedge | `#024731` | Solid | 2.0 pt |
| Money-market hedge | `#013D26` | Dashed | 1.5 pt |
| Put-option hedge | `#525252` | Dotted | 2.0 pt |

Other requirements:

- Horizontal gridlines only
- Gridlines: `#B2B2B2`
- No 3-D effects
- No shadows
- No gradients
- Chart title and axes in Open Sans Semibold where available
- Legend positioned at top or right

---

## 8. Limitations & Next Steps

### Limitations

This specification does not incorporate:

- Partial hedging
- Layered hedging
- Dynamic hedge rebalancing
- Multiple settlement dates
- Multiple foreign currencies
- Counterparty credit risk
- Settlement risk
- Forward bid-ask spreads
- Option bid-ask spreads
- Bank transaction charges
- Tax consequences
- ASC 815 hedge-accounting treatment
- IFRS 9 hedge-accounting treatment
- Implied-volatility option pricing
- Black-Scholes option valuation
- Probability-weighted exchange-rate forecasts
- Value-at-Risk calculations
- Expected-shortfall calculations
- Correlated multi-currency exposures

The model is therefore a static, full-notional transaction-hedging model designed to compare the fundamental economics of the available strategies.

### Next Steps

The next stages should:

1. Build the workbook directly from this specification.
2. Create every standardized named range.
3. Create the calculation areas using the formulas in §4.
4. Create the 11-row sensitivity grid.
5. Create the sensitivity chart.
6. Add all validation checks from §6.3.
7. Audit every generated formula.
8. Correct any AI-generated formula or reference errors.
9. Replace placeholder market values with live market information.
10. Record each market source and access date.
11. Re-run all model validation checks.
12. Compare the final live-market hedge results.
13. Prepare the final CFO recommendation using quantitative evidence from the completed model.

No final hedging recommendation should be made solely from the Stage 2 placeholder values.

---

## 9. Writing a Strong Specification

> <span style="color:#024731; font-weight:600;">This specification is a handoff document, not a lab notebook.</span>

The specification must be detailed enough that another treasury analyst or an AI can reproduce the workbook without having to guess what the author intended.

The model should follow these principles:

- **Professional communication:** use concise and precise financial language.
- **Named-range discipline:** variables should be meaningful and standardized.
- **No cell-address dependency:** business logic belongs in named-range notation rather than references such as `$F$7`.
- **Reproducibility:** formulas should be implementable in Excel, Python, or another modeling tool.
- **Auditability:** intermediate steps should remain visible.
- **Consistency:** every strategy must be evaluated on the same settlement-date USD basis.
- **Transparency:** limitations and placeholder data must be disclosed.
- **Executive relevance:** outputs should help management understand risk, certainty, flexibility, and cost.
- **Validation:** each major calculation must have an independent check where possible.
- **AI readiness:** instructions must be explicit enough that Stage 3 can use this specification directly as the model-build prompt.

Ambiguous instructions should be treated as specification defects.

For example:

Incorrect:

`Use a reasonable EUR interest rate.`

Correct:

`R_FC = 3.00% annual placeholder; replace with a current EUR money-market rate of matching maturity in Stage 4 and record the source and access date.`

Incorrect:

`Calculate a money-market hedge.`

Correct:

`Borrow FC_AMT / DF_FC EUR today, convert the proceeds at S0_in, and accumulate the USD amount by DF_USD until settlement.`

---

## 10. How This Sets Up the Next Stage

| What Is Defined in This Specification | What It Enables |
|----------------------------------------|-----------------|
| Standardized named ranges | AI can build formulas without inventing variables |
| Exact hedge formulas | AI can reproduce forward, MM, and put calculations |
| Intermediate MM pipeline | Auditor can trace borrow → convert → invest |
| Covered-interest-parity check | Formula errors can be detected quickly |
| Settlement-date premium treatment | All strategies are compared on a consistent basis |
| Exact sensitivity grid | Stage 3 does not need to guess scenario ranges |
| Winner and hedge-profit outputs | Management can compare strategy performance |
| Validation tolerances | Stage 3 audit has objective PASS/FAIL criteria |
| Chart specification | Stage 3 can build the intended CFO visualization |
| Placeholder/live data status | Stage 4 data replacement can be tracked |
| Model limitations | Final recommendation can acknowledge what the model does not capture |

The Stage 3 AI build should use this specification directly as its instruction set.

The build should not improvise alternative formulas, names, sensitivity ranges, premium treatment, or worksheet architecture without documenting the change and explaining why it was necessary.

---

## Appendix A — Change Log

| Version | Date | Author | Change |
|---------|------|--------|--------|
| 0.1 | 2026-08-07 | Micah Yi | Initial Stage 2 specification drafted from EUR receivable framing memo |
| 0.2 | 2026-08-07 | Micah Yi | Revised to follow FIN-321 technical-specification template, standardized named ranges, settlement-date premium treatment, full sensitivity design, model-review section, validation checklist, and UH Mānoa formatting standards |

---

## Appendix B — AI Drafting and Editing Evidence

### Initial AI Draft

The initial AI-assisted specification correctly identified the major hedge families but used several custom names, including:

- `EUR_Receivable`
- `Spot_EURUSD`
- `EUR_Rate`
- `USD_Rate`
- `Time_Years`

It also treated the put premium by subtracting the raw premium directly from settlement proceeds rather than placing the upfront premium cost on the same settlement-date basis as the other strategy outcomes.

### Gap Identified

The FIN-321 template requires standardized variable naming and specifies the settlement-date future value of the option premium.

The initial version would therefore have created two problems:

1. The Stage 3 workbook would not follow the standardized named-range structure.
2. Option proceeds would not follow the template's required premium treatment.

### Correction

The custom variables were replaced with the standardized model vocabulary:

- `FC_AMT`
- `S0_in`
- `F0_in`
- `R_USD`
- `R_FC`
- `T_DAYS`
- `BASIS`
- `K_PUT`
- `K_CALL`
- `PREM_PUT`
- `PREM_CALL`

The option-premium calculation was revised to:

`FV_PREM_PUT = −PREM_PUT × FC_AMT × DF_USD`

and put proceeds were revised to:

`USD_PUT(S_T) = MAX(S_T, K_PUT) × FC_AMT + FV_PREM_PUT`

The specification was also expanded to include:

- Covered-interest-parity validation
- Hedge-profit columns
- Overall-winner labels
- Best-active-hedge labels
- Model auditability checklist
- Sensitivity chart requirements
- Placeholder/live market-data status
- Model-review and limitations sections

These revisions make the final specification suitable for direct use as the Stage 3 AI workbook-build prompt.

---

## Appendix C — Brand & Formatting Standards

All FIN-321 deliverables should follow the University of Hawaiʻi at Mānoa brand standards contained in:

`docs/_branding/design.json`

### C.1 Color Palette

#### Primary Colors

| Token | Hex | Usage |
|-------|-----|-------|
| UH Green | `#024731` | Headings, banners, major accents |
| Black | `#000000` | Body text and formulas |
| Silver | `#B2B2B2` | Borders and separators |
| White | `#FFFFFF` | Backgrounds |

#### Extended Tokens

| Purpose | Hex |
|---------|----:|
| Secondary text | `#525252` |
| Tertiary text | `#737373` |
| UH Green 700 | `#013D26` |
| UH Green 50 | `#E6F2EF` |
| Table borders | `#E5E5E5` |

Custom gradients and unapproved color palettes should not be used.

### C.2 Typography

| Element | Preferred Typeface |
|---------|-------------------|
| H1 / H2 | Open Sans Bold |
| H3 / H4 | Open Sans Semibold |
| Body | Open Sans Regular |
| Print headings | Avenir Bold |
| Print body | Avenir Book |
| Formula / code | Consolas or monospace |

Printed body copy should generally be 11–12 pt.

Body text should be flush left with a ragged right edge.

### C.3 Workbook Formatting

| Element | Formatting |
|---------|------------|
| Section headings | UH Green `#024731`, bold |
| Editable input cells | Yellow fill `#FFFF00` |
| Hard-coded assumption values | Blue text `#0000FF` |
| Formula cells | Black text `#000000` |
| Cross-tab references | UH Green text `#024731` |
| External links | Dark red `#B43232`, used sparingly |
| Table separators | Silver `#B2B2B2` |
| Header rows | UH Green fill with white text |
| Summary/output cells | Gray or silver treatment, non-editable |

Workbook default font:

`Open Sans`

Fallback:

`Arial`

Do not use Calibri as the intended default workbook font.

### C.4 Sensitivity Chart

| Series | Line Color | Style | Weight |
|--------|-----------:|-------|-------:|
| No hedge | `#000000` | Solid | 1.5 pt |
| Forward hedge | `#024731` | Solid | 2.0 pt |
| Money-market hedge | `#013D26` | Dashed | 1.5 pt |
| Put-option hedge | `#525252` | Dotted | 2.0 pt |

Chart requirements:

- No 3-D formatting
- No shadows
- No gradients
- Horizontal gridlines only
- Silver gridlines
- Clearly labeled axes
- Legend at top or right
- Minimum 10 pt chart text where possible

### C.5 Accessibility

- All text/background combinations should meet ADA AA contrast requirements.
- Do not use red for ordinary body copy.
- Do not use dark backgrounds for large sections of printed content.
- Do not rely on color alone to communicate PASS/FAIL status.
- Include readable text labels in addition to formatting.
- Avoid low-contrast combinations.
- Avoid custom palettes not defined by the official brand standards.

### C.6 File & Deliverable Conventions

**Specification file:**

`docs/specs/2026-08-07-Yi-eur-receivable-hedge-spec.md`

**Workbook file:**

`docs/spreadsheets/FIN 321 - Chapter 8 Transaction Hedging_2026_Yi.xlsx`

All major project files should include:

- Author
- Date
- Version
- Descriptive title
- Appropriate UH Mānoa branding
- Consistent naming conventions

---

<div style="border-top: 1px solid #B2B2B2; padding-top: 8px; margin-top: 24px; font-family: 'Open Sans', Helvetica, Arial, sans-serif; font-size: 0.8rem; color: #525252;">
  Prepared per UH Mānoa brand standards (<code>docs/_branding/design.json</code> v1.0.0). Primary green <code>#024731</code> · Black <code>#000000</code> · Silver <code>#B2B2B2</code> · Body type Open Sans Regular, 11–12 pt for printed copies · ADA-compliant contrast · Flush-left, ragged-right alignment · No red body type · No custom palettes or gradients.
</div>
