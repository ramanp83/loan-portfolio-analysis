# Data Dictionary

## 1. Overview

This document describes the main dataset fields referenced in the SQL analysis and Excel portfolio dashboard.

The source table used in SQL analysis is `Banking_Data_3`.

Field names are retained as they appear in the source queries. Descriptions are based on field names and their usage in the analysis. Where the exact business definition is not confirmed, this is stated rather than assumed.

## 2. Portfolio and Loan Fields

| Source field | Description |
|---|---|
| `Account ID` | Account identifier used in account-level record checks. |
| `Client ID` | Client identifier used in client-level record checks. |
| `Loan Status` | Status category assigned to a loan record. Used to analyse portfolio distribution and funding by status. |
| `Loan Amount` | Loan amount recorded for the loan. Used for loan-size distribution and funding comparisons. |
| `Funded Amount` | Amount recorded as funded. Used to calculate funded portfolio totals and funding shortfall. |
| `Funded Amount Inv` | Investment-related funded amount field. Its exact business definition should be confirmed from the source documentation. |
| `Product Code` | Product classification code used in product-level analysis. |
| `Product Id` | Product identifier used for more detailed product-level analysis. |
| `Term` | Loan term field used to compare missing-value patterns across loan terms. The unit should be confirmed from the source data. |
| `Application Type` | Application classification field. Exact category definitions are not confirmed. |

## 3. Date Fields

| Source field | Description |
|---|---|
| `Disbursement Date` | Date associated with loan disbursement. Used for annual and monthly trend analysis. |
| `Closed Date` | Date associated with loan closure in the source data. Used in selected lifecycle analysis. |

## 4. Risk and Borrower-Related Classification Fields

| Source field | Description |
|---|---|
| `Grrade` | Grade classification field. This spelling is retained from the SQL source. |
| `Sub Grade` | Sub-grade classification associated with the grade field. |
| `Home Ownership` | Borrower home-ownership classification. Used in missing-value analysis. |
| `Verification Status` | Verification classification field. Used in missing-value analysis. |
| `Delinq 2 Yrs` | Field used to identify records with a delinquency value greater than zero in the active-loan delinquency proxy. Its full business definition should be confirmed. |

## 5. Payment and Recovery Fields

| Source field | Description |
|---|---|
| `Total Pymnt` | Total payment amount recorded. |
| `Total Pymnt inv` | Investment-related total payment field. Exact business definition is not confirmed. |
| `Total Rec Prncp` | Total principal recovered, as labelled in the source field. |
| `Total Rrec int` | Interest-related amount recorded. The source spelling is retained. |
| `Total Rec Late fee` | Late-fee amount recorded as recovered. |
| `Recoveries` | Recovery amount recorded in the dataset. |
| `Total Fees ` | Total fees field. The trailing space is retained as it appears in the SQL source. |
| `Collection Recovery fee` | Collection recovery fee amount recorded. |

## 6. Geographic and Operational Fields

| Source field | Description |
|---|---|
| `Tranfer Logic` | Source field examined during state-name and transfer-logic validation. Its exact business meaning is not confirmed. |
| `State Name` | State-name field examined during geographic validation. |
| ` State Abbr` | State abbreviation field with a leading space in the source column name. |
| `State Abbr` | Another state abbreviation field, without the leading space. Compared with ` State Abbr` during validation. |
| `Region Name` | Region classification used in geographic validation. |
| `Branch Name` | Branch classification used in geographic validation. |

## 7. Derived Fields and Analysis Outputs

The following are calculated in SQL or Excel and are not necessarily original source columns.

| Derived field / measure | Description |
|---|---|
| `Disbursement_Year` | Year extracted from `Disbursement Date`. |
| `Disbursement_Month` | Month extracted from `Disbursement Date`. |
| `Total_Rows` / `Total_Records` | Count of records included in the relevant query. |
| `Missing_Grade` | Count of records where the grade field is missing. |
| `Missing_Sub_Grade` | Count of records where the sub-grade field is missing. |
| `All_Four_Missing` | Count of records where Grade, Sub Grade, Home Ownership and Verification Status are all missing under the SQL conditions. |
| `Missing_Rate_Pct` | Missing-record count divided by the relevant group record count, expressed as a percentage. |
| `Loan_Amount_Band` | Grouping created from `Loan Amount` ranges for distribution analysis. |
| `Avg_Funding_Shortfall` | Average difference between Loan Amount and Funded Amount for records included in the relevant query. |

## 8. Data Dictionary Notes

- Source column names are retained to support matching with the SQL queries.
- Some source names contain spelling differences or spaces. These should not be silently corrected in SQL documentation.
- Descriptions of fields with unclear business meanings are provisional and require confirmation from the original data documentation.
- This dictionary focuses on fields relevant to the current analysis rather than reproducing every column in the source dataset.
- Customer-identifying fields are intentionally not documented here.
