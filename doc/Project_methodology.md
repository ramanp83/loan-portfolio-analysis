# Project Methodology

## 1. Project Overview

This project analyses a loan portfolio containing 65,535 records covering the period 2016–2020.

The analysis focuses on understanding portfolio composition, funding distribution, product contribution, disbursement trends, loan amount distribution and selected data-quality indicators.

SQL Server was used for data profiling, validation and analytical queries. Microsoft Excel was used for KPI calculations, PivotTable analysis and the interactive dashboard.

## 2. Analysis Approach

The project followed these stages:

### Stage 1: Dataset Understanding

- Reviewed the dataset structure and available fields.
- Checked the total number of records.
- Examined loan identifiers and their combinations.
- Reviewed the date fields and loan-related attributes.

### Stage 2: Data Quality Assessment

SQL queries were used to examine:

- Total record count.
- Duplicate combinations of Account ID and Client ID.
- Missing values in Grade and Sub Grade.
- Missing values in Home Ownership and Verification Status.
- Missing-value patterns across loan statuses, disbursement years and products.
- State, abbreviation, region and branch mapping consistency.

### Stage 3: Exploratory and Portfolio Analysis

The analysis examined:

- Loan distribution by Loan Status.
- Funded amount by loan status.
- Product-level funded amount and contribution.
- Annual and monthly funding trends.
- Distribution of funded amounts across loan amount ranges.
- Selected loan lifecycle and missing-value patterns.

### Stage 4: KPI Development

Portfolio-level KPIs were calculated in Excel to summarise funding, record distribution and selected portfolio indicators.

The KPI calculation logic and limitations are documented separately in `kpi_definitions.md`.

### Stage 5: Dashboard Development

An interactive Excel dashboard was developed with:

- KPI cards.
- Six charts covering portfolio status, funding, product contribution, time trends and loan amount distribution.
- Three slicers: Disbursement Year, Product ID and Loan Status.

The slicers allow users to explore the dashboard using individual or combined selections.

## 3. Tools Used

| Tool | Purpose |
|---|---|
| SQL Server | Data profiling, quality checks, validation and analysis |
| Microsoft Excel | KPI calculations, PivotTables, PivotCharts and dashboard |

## 4. Key Findings

- The dataset contains 65,535 loan records.
- Gross funded portfolio is approximately ₹73.27 crore.
- Active Loan records represent 55.46% of the dataset.
- JLG30K and JLG35K together account for 80.57% of the funded amount.
- Grade and Sub Grade are both missing in 25,818 records.

## 5. Interpretation and Limitations

- The analysis describes patterns in the supplied dataset; it does not establish causation.
- Portfolio realized yield is a cumulative extract-level ratio and is not annualized.
- The active-loan delinquency indicator is a proxy.
- NPA + Write-Off is measured using record counts, not monetary exposure.
- The years 2016 and 2020 represent partial-year periods in the dataset.

## 6. Project Output

The project produces SQL analysis files, supporting documentation, an Excel analysis workbook and an interactive portfolio dashboard.

This is an independent practice project, not an analysis of verified live lending operations.
