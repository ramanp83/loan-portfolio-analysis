# KPI Definitions

## 1. Overview

This document explains the six Key Performance Indicators (KPIs) displayed on the Loan Portfolio Analysis Dashboard.

The KPIs provide a summary of portfolio size, funding, yield, delinquency indicators and loan-record distribution.

The dashboard displays the following measures:

| KPI | Dashboard Value |
|---|---:|
| Gross Funded Portfolio | ₹73.27 Cr |
| Funding Shortfall Rate | 4.67% |
| Portfolio Realized Yield | 21.21% |
| Active Loan Delinquency Proxy | 10.68% |
| NPA + Write-Off Record Rate | 0.94% |
| Total Loan Records | 65,535 |

## 2. KPI Definitions

### 2.1 Gross Funded Portfolio

**Dashboard value:** ₹73.27 crore

**Purpose:** Measures the total funded amount represented in the dataset.

**Calculation concept:**

Sum of the `Funded Amount` field across the records included in the calculation.

**Interpretation:** The dataset represents a gross funded portfolio of approximately ₹73.27 crore.

**Limitation:** This is the aggregate funded amount in the supplied extract. It should not be interpreted as the current outstanding loan balance.

### 2.2 Funding Shortfall Rate

**Dashboard value:** 4.67%

**Purpose:** Represents the funding shortfall indicator displayed on the dashboard.

**Calculation fields:** `Loan Amount` and `Funded Amount` are relevant to the funding comparison.

**Calculation formula:** To be verified against the original Excel KPI formula before documenting the exact numerator and denominator.

**Interpretation:** The dashboard reports a funding shortfall rate of 4.67%.

**Limitation:** The exact calculation logic has not yet been independently verified. The value should not be interpreted as a default rate, loss rate or collection shortfall.

### 2.3 Portfolio Realized Yield

**Dashboard value:** 21.21%

**Purpose:** Represents the portfolio yield indicator calculated in the Excel workbook.

**Relevant source fields:** Payment and funded-amount fields are used in the portfolio analysis.

**Calculation formula:** To be verified against the original Excel KPI formula before specifying the exact numerator and denominator.

**Interpretation:** The dashboard reports a portfolio realized yield of 21.21%.

**Limitation:** This is a cumulative extract-level measure, not an annualized yield or an annual interest rate. It should not be used to compare annual returns without further calculation and validation.

### 2.4 Active Loan Delinquency Proxy

**Dashboard value:** 10.68%

**Purpose:** Provides an indicator of delinquency within records classified as `Active Loan`.

**Relevant fields:**
- `Loan Status`
- `Delinq 2 Yrs`

**Calculation logic:** Uses records classified as `Active Loan` and identifies records where `Delinq 2 Yrs` is greater than zero.

**Interpretation:** The dashboard reports that 10.68% of the active-loan records meet this delinquency-proxy condition.

**Limitation:** This is a proxy based on the available field. It should not be presented as a verified current delinquency rate, days-past-due measure or regulatory portfolio-at-risk metric. The business definition of `Delinq 2 Yrs` should be confirmed.

### 2.5 NPA + Write-Off Record Rate

**Dashboard value:** 0.94%

**Purpose:** Measures the share of records classified as `NPA` or `Write Off` among the total loan records.

**Calculation concept:**

\[
(NPA records + Write-Off records)*100/(Total loan records)
\]

**Dataset values:**
- NPA records: 530
- Write-Off records: 85
- Combined records: 615
- Total loan records: 65,535

**Interpretation:** Approximately 0.94% of the dataset's loan records are classified as NPA or Write Off.

**Limitation:** This is a record-count measure, not a monetary NPA ratio, outstanding exposure ratio, provision coverage ratio or loss rate.

### 2.6 Total Loan Records

**Dashboard value:** 65,535

**Purpose:** Shows the total number of loan records included in the dataset.

**Calculation concept:**

Count of records included in the relevant dataset or dashboard calculation.

**Interpretation:** The analysis covers 65,535 loan records from the 2016–2020 period.

**Limitation:** Record count should not automatically be interpreted as the number of unique borrowers unless borrower-level uniqueness has been established for the relevant calculation.

## 3. KPI Summary and Limitations

| KPI | Measure type | Important limitation |
|---|---|---|
| Gross Funded Portfolio | Monetary total | Not current outstanding balance |
| Funding Shortfall Rate | Percentage | Exact formula requires verification |
| Portfolio Realized Yield | Percentage | Cumulative extract-level measure; not annualized |
| Active Loan Delinquency Proxy | Percentage | Based on `Delinq 2 Yrs > 0`; proxy only |
| NPA + Write-Off Record Rate | Record-count percentage | Not a monetary exposure or loss ratio |
| Total Loan Records | Record count | Not necessarily unique borrowers |

## 4. General Notes

- KPI values reflect the supplied dataset and the calculations in the Excel workbook.
- KPI calculations should be interpreted in the context of the available fields and their definitions.
- The Funding Shortfall Rate and Portfolio Realized Yield formulas must be checked against the original workbook before their exact calculation logic is published.
- The Active Loan Delinquency Proxy is an indicator, not a confirmed measure of current delinquency.
- NPA + Write-Off is based on record counts rather than funded amount or outstanding exposure.
- These KPIs describe the supplied extract and should not be interpreted as verified live lending performance.

## 5. Related Project Documentation

- `Project_methodology.md` — project workflow, tools and analysis approach.
- `data_dictionary.md` — descriptions of the source and derived fields.
- `kpi_definitions.md` — dashboard KPI descriptions, calculation concepts and limitations.
