---
title: "EUR Receivable FX Hedge — Stage 4 Market Data and Population"
author: "Micah Yi"
date: "2026-08-07"
version: "0.1"
---

# EUR Receivable FX Hedge — Stage 4 Market Data and Population

**Student:** Micah Yi  
**Course:** FIN 321 — International Business Finance  
**Section:** 701  
**Scenario:** €4,500,000 EUR Receivable  
**Workbook:** `models/builds/2026-08-07-Yi-eur-receivable-hedge-model.xlsx`  
**Retrieval Date:** 2026-08-07  

---

## 1. Purpose

This memo documents the market data used to replace the Stage 3 placeholder inputs in the EUR receivable hedging workbook.

Each populated input is identified as one of the following:

- Live market observation
- Public-market proxy
- CIP-implied value
- Scenario value
- Explicit assumption

The purpose of this memo is to make the Stage 4 market-data population reproducible and auditable. Another analyst should be able to return to the cited sources, identify the same dated observations, and understand the reasoning behind any proxy or computation used.

The company expects to receive **€4,500,000** in one year and reports in U.S. dollars.

All FX rates are quoted as:

`USD per EUR`

---

## 2. Stage 4 Market Inputs

| Named Range | Stage 4 Value | Classification | Source / Method | As-of Date | Rationale |
|---|---:|---|---|---|---|
| `FC_AMT` | €4,500,000 | Scenario | Assigned EUR receivable | 2026-08-07 | Fixed transaction amount |
| `S0_in` | 1.1535 USD/EUR | Live market reference | European Central Bank EUR/USD reference rate | 2026-08-07 | Official daily ECB EUR/USD reference rate |
| `R_USD` | 4.01% | Live public-market proxy | U.S. Treasury 1-year Treasury yield | 2026-08-07 | One-year USD government-yield proxy matching the hedge horizon |
| `R_FC` | 2.884% | Latest available EUR benchmark | 12-month Euribor | 2026-08-06 | One-year EUR benchmark; latest public observation available because of delayed release |
| `F0_in` | 1.1662946810 USD/EUR | CIP-implied | Calculated from spot and interest rates | 2026-08-07 | No directly comparable live 1-year dealer forward quote was used |
| `K_PUT` | 1.1535 USD/EUR | Assumption | Set equal to live spot | 2026-08-07 | At-the-money strike |
| `K_CALL` | 1.1535 USD/EUR | Assumption | Set equal to live spot | 2026-08-07 | At-the-money strike |
| `PREM_PUT` | 0.0250 USD/EUR | Scenario assumption | Scenario-given premium | 2026-08-07 | Retained as instructed because retail-accessible FX option quotes are unreliable |
| `PREM_CALL` | 0.0250 USD/EUR | Scenario assumption | Scenario-given premium | 2026-08-07 | Retained as instructed |
| `T_DAYS` | 365 days | Scenario | Assigned one-year settlement horizon | 2026-08-07 | Fixed scenario value |
| `BASIS` | 360 days | Course convention | FIN 321 model convention | 2026-08-07 | Simple interest using ACT/360 |

---

## 3. Spot Rate

The Stage 4 EUR/USD spot rate used in the workbook is:

`S0_in = 1.1535 USD/EUR`

The rate was taken from the European Central Bank's EUR foreign-exchange reference rates for August 7, 2026.

Source:

`https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/index.en.html`

The rate was also cross-checked using the Bank of Finland exchange-rate data.

Cross-check source:

`https://www.suomenpankki.fi/en/statistics/interest-rates-and-exchange-rates/exchange-rates/`

Both sources showed:

`1 EUR = 1.1535 USD`

for August 7, 2026.

---

## 4. USD Interest Rate

The USD interest-rate input is:

`R_USD = 4.01%`

I selected the 1-year U.S. Treasury rate because the EUR receivable has an approximately one-year settlement horizon.

The assignment permits a government yield or deposit/reference rate for each currency, so the 1-year Treasury provides a transparent one-year USD benchmark.

Source:

`https://home.treasury.gov/resource-center/data-chart-center/interest-rates/`

The rate is treated as a public-market proxy rather than the exact borrowing or investment rate available to the company.

---

## 5. EUR Interest Rate

The foreign-currency interest-rate input is:

`R_FC = 2.884%`

I selected the 12-month Euribor rate because the company's EUR exposure has a one-year horizon.

The observation used is dated August 6, 2026 because the public Euribor series is published with a delay.

Source:

`https://www.suomenpankki.fi/en/statistics/interest-rates-and-exchange-rates/euribor-rates/`

The European Money Markets Institute is the official administrator of Euribor.

Additional source:

`https://www.emmi-benchmarks.eu/benchmarks/euribor/rate/`

Using 12-month Euribor provides a one-year EUR money-market benchmark that matches the approximate hedge horizon.

---

## 6. CIP-Implied Forward Rate

A directly comparable live 1-year EUR/USD dealer forward quote was not used.

Therefore, following the Stage 4 instructions, the forward rate was calculated using covered interest parity.

The required formula is:

`F0_in = S0_in × (1 + R_USD × T_DAYS / BASIS) / (1 + R_FC × T_DAYS / BASIS)`

Using:

```text
S0_in   = 1.1535
R_USD   = 0.0401
R_FC    = 0.02884
T_DAYS  = 365
BASIS   = 360
