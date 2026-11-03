# Loan Portfolio Analysis

**Tools:** SQL Server | Microsoft Excel

## Project Overview

This project analyses a loan portfolio containing 65,535 loan records covering the period 2016–2020.

The objective was to examine portfolio composition, funding distribution, loan products, disbursement trends and selected portfolio risk indicators.

SQL was used for data profiling and quality checks, while Microsoft Excel was used for KPI calculations, PivotTable analysis and the development of an interactive dashboard.

## Project Scope

- Profile loan records and assess data quality using SQL.
- Examine missing values and identifier uniqueness.
- Analyse loan status and product-level contribution.
- Evaluate funding trends and loan amount distribution.
- Develop an interactive Excel dashboard using KPI cards, charts and slicers.

## Tools Used

- SQL Server — data profiling and validation
- Microsoft Excel — KPI calculations, PivotTables, PivotCharts and slicers

## Key Portfolio Findings

- Total loan records: 65,535
- Gross funded portfolio: ₹73.27 crore
- Active loan records: 55.46% of the portfolio
- JLG30K and JLG35K together represent 80.57% of the funded amount.

## Dashboard Preview

![Loan Portfolio Dashboard](screenshots/dashboard_overview.png)

## Repository Structure

- `sql/` — SQL profiling and analytical queries
- `excel/` — Excel analysis and dashboard
- `screenshots/` — Dashboard and chart previews
- `docs/` — Methodology, KPI definitions and data dictionary

## Important Notes

This is an independent practice assignment and portfolio project. The analysis describes patterns in the supplied dataset and should not be interpreted as evidence of actual lending performance or causation.

The realized yield is not annualized, the delinquency indicator is a proxy, and the NPA + Write-Off measure is based on record counts rather than monetary exposure.
