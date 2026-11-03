USE PortfolioProject;

SELECT   [Loan Status],
         SUM([Total Pymnt]) AS Total_Payments,
         SUM([Total Rec Prncp]) AS Principal_Recovered,
         SUM([Total Rrec int]) AS Interest_Received,
         SUM([Total Rec Late fee]) AS Late_Fees_Received,
         SUM([Recoveries]) AS Recoveries,
         SUM([Total Fees ]) AS Fees_Received,
         SUM([Total Pymnt]) - SUM([Total Rec Prncp]) - SUM([Total Rrec int]) - SUM([Total Rec Late fee]) - SUM([Recoveries]) AS Difference_Without_Fees
FROM     Banking_Data_3
GROUP BY [Loan Status]
ORDER BY Difference_Without_Fees DESC;

-----------------------------------------------------------------
SELECT   [Loan Status],
        COUNT(*) AS [Total Loan Count],
        SUM([Loan Amount]) AS [Total Original Principal],
        SUM([Total Rec Prncp]) AS [Total Principal Recovered],
        SUM([Loan Amount]-[Total Rec Prncp]) as [Unrecovered Principal],

        CAST(100.0 * SUM([Loan Amount]-[Total Rec Prncp])/ SUM([Loan Amount]) as decimal(10,2) ) as [Unrecovered Principal (%) ]
FROM     Banking_Data_3
GROUP BY [Loan Status];

-----------------------------------------------------------------

SELECT
    COUNT(*) AS Total_Records,
    COUNT([Total Fees ]) AS Non_Null_Fee_Records,

    SUM(CASE
        WHEN [Total Fees ] = 0 THEN 1
        ELSE 0
    END) AS Zero_Fee_Records,

    SUM(CASE
        WHEN [Total Fees ] > 0 THEN 1
        ELSE 0
    END) AS Positive_Fee_Records,

    SUM(CASE
        WHEN [Total Fees ] < 0 THEN 1
        ELSE 0
    END) AS Negative_Fee_Records,

    MIN([Total Fees ]) AS Minimum_Fee,
    MAX([Total Fees ]) AS Maximum_Fee,
    AVG([Total Fees ]) AS Average_Fee,
    SUM([Total Fees ]) AS Total_Fees_Recorded

FROM Banking_Data_3;
---------------------------------------------------------

SELECT TOP 50
    [Account ID],
    [Loan Status],
    [Total Pymnt],
    [Total Rec Prncp],
    [Total Rrec int],
    [Total Fees ],
    [Total Rec Late fee],
    [Recoveries],

    [Total Pymnt]
      - [Total Rec Prncp]
      - [Total Rrec int]
      - [Total Rec Late fee]
      - [Recoveries] AS Payment_Reconciliation_Difference,

    [Total Fees ]
      - [Total Rec Late fee] AS Fee_Minus_Late_Fee

FROM Banking_Data_3
ORDER BY [Total Fees ] DESC;
---------------------------------------------------------

SELECT
    [Product Code],
    [Loan Status],
    COUNT(*) AS Total_Loans,
    AVG([Loan Amount]) AS Average_Loan_Amount,
    AVG([Total Fees ]) AS Average_Fee,
    MIN([Total Fees ]) AS Minimum_Fee,
    MAX([Total Fees ]) AS Maximum_Fee,
    SUM([Total Fees ]) AS Total_Fees

FROM Banking_Data_3
GROUP BY
    [Product Code],
    [Loan Status]
ORDER BY
    [Product Code],
    Average_Fee DESC;
--------------------------------------------------------

select 
    [Loan Status],


    case
        when max([Loan Amount]) = MAX([Total Fees ]) then 1 else 0 end as max_loan_max_fees_same,
    case
        when max([Loan Amount]) < MAX([Total Fees ]) then 1 else 0 end as max_loan_smaller_than_max_fees,
    case
        when max([Loan Amount]) > MAX([Total Fees ]) then 1 else 0 end as max_loan_greater_than_max_fees
   
from Banking_Data_3
group by [Loan Status]
--------------------------------------------------------


SELECT
    CASE
        WHEN [Loan Amount] < 5000 THEN 'Below 5,000'
        WHEN [Loan Amount] < 10000 THEN '5,000–9,999'
        WHEN [Loan Amount] < 15000 THEN '10,000–14,999'
        WHEN [Loan Amount] < 20000 THEN '15,000–19,999'
        ELSE '20,000 and above'
    END AS Loan_Amount_Band,

    COUNT(*) AS Total_Loans,
    AVG([Loan Amount]) AS Average_Loan_Amount,
    AVG([Total Fees ]) AS Average_Fee,
    MIN([Total Fees ]) AS Minimum_Fee,
    MAX([Total Fees ]) AS Maximum_Fee

FROM Banking_Data_3
GROUP BY
    CASE
        WHEN [Loan Amount] < 5000 THEN 'Below 5,000'
        WHEN [Loan Amount] < 10000 THEN '5,000–9,999'
        WHEN [Loan Amount] < 15000 THEN '10,000–14,999'
        WHEN [Loan Amount] < 20000 THEN '15,000–19,999'
        ELSE '20,000 and above'
    END
ORDER BY MIN([Loan Amount]);
-------------------------------------------------------
SELECT
    [Product Code],
    [Loan Status],
    [Loan Amount],
    [Total Fees ],
    [Total Rec Late fee],
    year([Disbursement Date]) as Disbursement_year
FROM Banking_Data_3
WHERE [Total Fees ] >= 100
ORDER BY [Total Fees ];

---------------------------------------------

SELECT
    [Product Code],
    COUNT(*) AS Total_Loans,
    SUM(CASE WHEN [Total Fees ] = 912.08 THEN 1 ELSE 0 END)
        AS Loans_With_Max_Fee,
    AVG([Total Fees ]) AS Average_Fee,
    MIN([Total Fees ]) AS Minimum_Fee,
    MAX([Total Fees ]) AS Maximum_Fee
FROM Banking_Data_3
GROUP BY [Product Code]
ORDER BY Maximum_Fee DESC, Total_Loans DESC;
--------------------------------------------------------
SELECT
    YEAR([Disbursement Date]) AS Disbursement_Year,
    [Product Code],
    COUNT(*) AS Total_Loans,
    AVG([Total Fees ]) AS Average_Fee,
    MAX([Total Fees ]) AS Maximum_Fee
FROM Banking_Data_3
WHERE [Disbursement Date] IS NOT NULL
GROUP BY
    YEAR([Disbursement Date]),
    [Product Code]
ORDER BY
    Disbursement_Year,
    [Product Code];

--------------------------------------------------------

select 
    [Loan Status],
    [Application Type],
    [Loan Amount],
    [Funded Amount],
    [Funded Amount Inv],
    Term,
    [Total Pymnt],
    [Total Pymnt inv],
    [Total Rec Prncp],
    [Total Fees ],
    [Total Rrec int],
    [Total Rec Late fee],
    Recoveries,
    [Collection Recovery fee]
from Banking_Data_3
where [Total Fees ] >= 100 and [Total Rec Late fee] <> 0

--------------------------------------------------------

SELECT 
    [Product Code],
    [Loan Status],
    count(*) as total_record,
    sum([Total Fees ]) total_fees,
    -- All three columns are equal
    SUM(CASE WHEN [Loan Amount] = [Funded Amount] AND [Funded Amount] = [Funded Amount Inv] THEN 1 ELSE 0 END) AS loan_funded_inves_same,
    
    -- Exactly two columns are equal (Loan = Funded)
    SUM(CASE WHEN [Loan Amount] = [Funded Amount] AND [Funded Amount] <> [Funded Amount Inv] THEN 1 ELSE 0 END) AS loan_equal_funded_but_not_invest,
    
    -- Exactly two columns are equal (Funded = Invested)
    SUM(CASE WHEN [Funded Amount] = [Funded Amount Inv] AND [Loan Amount] <> [Funded Amount] THEN 1 ELSE 0 END) AS funded_equal_invest_but_not_loan,
    
    -- Exactly two columns are equal (Loan = Invested)
    SUM(CASE WHEN [Loan Amount] = [Funded Amount Inv] AND [Funded Amount Inv] <> [Funded Amount] THEN 1 ELSE 0 END) AS loan_equal_invest_but_not_funded,
    
    -- None of the columns are equal
    SUM(CASE WHEN [Loan Amount] <> [Funded Amount] AND [Funded Amount] <> [Funded Amount Inv] AND [Loan Amount] <> [Funded Amount Inv] THEN 1 ELSE 0 END) AS none_are_equal
    ,

    min([Total Fees ]) as min_fees,
    max([Total Fees ]) as maxfees,
    avg([Total Fees ]) as avg_fees
FROM Banking_Data_3
GROUP BY 
    [Product Code],
    [Loan Status]
---------------------------------------------------

SELECT 
    CASE 
        WHEN [Loan Amount] - [Funded Amount] = 0 THEN '0. Fully Funded (No Haircut)'
        WHEN [Loan Amount] - [Funded Amount] = [Total Fees ] THEN '1. Haircut Exactly Equals Total Fees'
        ELSE '2. Haircut Disconnected from Total Fees'
    END AS Disb_Haircut_Category,
    COUNT(*) AS Total_Loans,
    AVG([Loan Amount] - [Funded Amount]) AS Avg_Haircut,
    AVG([Total Fees ]) AS Avg_Fee
FROM Banking_Data_3
GROUP BY 
    CASE 
        WHEN [Loan Amount] - [Funded Amount] = 0 THEN '0. Fully Funded (No Haircut)'
        WHEN [Loan Amount] - [Funded Amount] = [Total Fees ] THEN '1. Haircut Exactly Equals Total Fees'
        ELSE '2. Haircut Disconnected from Total Fees'
    END;
 ------------------------------------
 SELECT
    [Product Code],
    [Loan Status],
    COUNT(*) AS Total_Loans,

    AVG([Loan Amount] - [Funded Amount])
        AS Avg_Funding_Shortfall,

    AVG([Total Fees ])
        AS Avg_Total_Fee,

    SUM(CASE
        WHEN [Funded Amount] < [Loan Amount]
        THEN 1 ELSE 0
    END) AS Loans_With_Shortfall,

    SUM(CASE
        WHEN [Total Fees ] >= 100
        THEN 1 ELSE 0
    END) AS Loans_With_Fees_100_Plus

FROM Banking_Data_3
WHERE [Loan Amount] > [Funded Amount]
GROUP BY
    [Product Code],
    [Loan Status]
ORDER BY
    COUNT(*) DESC;
-------------------------------------------

SELECT
    year([Disbursement Date]) as Disbursement_year,
    [Product Code],
    [Loan Status],
    COUNT(*) AS Total_Loans,

    SUM(CASE
        WHEN [Loan Amount] > [Funded Amount]
        THEN 1 ELSE 0
    END) AS Loans_With_Shortfall,

    CAST(
        100.0 * SUM(CASE
            WHEN [Loan Amount] > [Funded Amount]
            THEN 1 ELSE 0
        END) / COUNT(*) AS DECIMAL(6,2)
    ) AS Shortfall_Rate_Pct,

    AVG(CASE
        WHEN [Loan Amount] > [Funded Amount]
        THEN [Loan Amount] - [Funded Amount]
    END) AS Avg_Shortfall_When_Present

FROM Banking_Data_3
GROUP BY
    year([Disbursement Date]) ,
    [Product Code],
    [Loan Status]
ORDER BY
    Shortfall_Rate_Pct DESC,
    Total_Loans DESC;

select COUNT_BIG(*) as total_rows
FROM banking_data_3

SELECT
    COUNT(*) AS Duplicate_Account_Client_Groups
FROM (
    SELECT
        [Account ID],
        [Client id]
    FROM Banking_Data_3
    GROUP BY
        [Account ID],
        [Client id]
    HAVING COUNT(*) > 1
) AS DuplicateGroups;

SELECT
    COUNT_BIG(*) AS Total_Rows,

    SUM(CASE
        WHEN [Grrade] IS NULL THEN 1 ELSE 0
    END) AS Missing_Grade,

    SUM(CASE
        WHEN [Sub Grade] IS NULL THEN 1 ELSE 0
    END) AS Missing_Sub_Grade,

    SUM(CASE
        WHEN [Home Ownership] IS NULL
          OR LTRIM(RTRIM([Home Ownership])) = ''
        THEN 1 ELSE 0
    END) AS Missing_Home_Ownership,

    SUM(CASE
        WHEN [Verification Status] IS NULL
          OR LTRIM(RTRIM([Verification Status])) = ''
        THEN 1 ELSE 0
    END) AS Missing_Verification_Status

FROM Banking_Data_3;

----------------------------------------------

SELECT 
    COUNT_BIG(*) as total_record,
    sum(
        case    
            when Grrade is null 
                and [Sub Grade] is null 
                and ([Home Ownership]is null or LTRIM(RTRIM([Home Ownership])) = '')
                and ([Verification Status] is null or LTRIM(RTRIM([Verification Status])) = '')
                then 1 else 0 
        end ) as all_four_missing,
    sum(
        case    
            when Grrade is not null 
                and [Sub Grade] is not null 
                and ([Home Ownership]is not null or LTRIM(RTRIM([Home Ownership])) <> '')
                and ([Verification Status] is not null or LTRIM(RTRIM([Verification Status])) <> '')
                then 1 else 0 
        end ) as all_four_present
FROM Banking_Data_3;

-------------------------------------------------------------

SELECT
    YEAR([Disbursement Date]) AS Disbursement_Year,
    [Loan Status],
    COUNT(*) AS Total_Loans,

    SUM(CASE
        WHEN [Grrade] IS NULL
         AND [Sub Grade] IS NULL
         AND (
             [Home Ownership] IS NULL
             OR LTRIM(RTRIM([Home Ownership])) = ''
         )
         AND (
             [Verification Status] IS NULL
             OR LTRIM(RTRIM([Verification Status])) = ''
         )
        THEN 1 ELSE 0
    END) AS All_Four_Missing,

    CAST(
        100.0 * SUM(CASE
            WHEN [Grrade] IS NULL
             AND [Sub Grade] IS NULL
             AND (
                 [Home Ownership] IS NULL
                 OR LTRIM(RTRIM([Home Ownership])) = ''
             )
             AND (
                 [Verification Status] IS NULL
                 OR LTRIM(RTRIM([Verification Status])) = ''
             )
            THEN 1 ELSE 0
        END) / COUNT(*) AS DECIMAL(6,2)
    ) AS Missing_Rate_Pct

FROM Banking_Data_3
GROUP BY
    YEAR([Disbursement Date]),
    [Loan Status]
ORDER BY
    Disbursement_Year,
    Missing_Rate_Pct DESC;

-----------------------------------------------


SELECT
    [Tranfer Logic],
    [State Name],
    [ State Abbr],
    [State Abbr],
    [Region Name],
    [Branch Name],
    COUNT(*) AS RecordCount
FROM Banking_Data_3
WHERE UPPER(LTRIM(RTRIM([Tranfer Logic])))  IN ('YES', 'NO') and [State Name] <> 'State Name'
GROUP BY
    [Tranfer Logic],
    [State Name],
    [ State Abbr],
    [State Abbr],
    [Region Name],
    [Branch Name]
ORDER BY
    [Tranfer Logic],
    RecordCount DESC;


select
    count(*) as rowscount,
    sum(
        case 
            when UPPER(LTRIM(RTRIM([Tranfer Logic])))  IN ('YES', 'NO') then 1 else 0 end ) as 'count of yes/no present',
    sum(
        case 
            when UPPER(LTRIM(RTRIM([Tranfer Logic]))) NOT IN ('YES', 'NO') then 1 else 0 end ) as 'count of state name present',
    sum(
        case 
            when [State Name] = 'State Name' then 1 else 0 end ) as 'count placeholder in [State Name]',
    sum(
        case 
            when [State Name] <> 'State Name' then 1 else 0 end ) as 'count state name in [State Name]'
    
    
from Banking_Data_3


SELECT
    CASE
        WHEN [Tranfer Logic] IS NULL THEN 'NULL'
        WHEN UPPER(LTRIM(RTRIM([Tranfer Logic]))) IN ('YES', 'NO')
            THEN 'YES / NO'
        ELSE 'STATE NAME / OTHER'
    END AS Transfer_Logic_Group,

    CASE
        WHEN [State Name] IS NULL THEN 'NULL'
        WHEN UPPER(LTRIM(RTRIM([State Name]))) = 'STATE NAME'
            THEN 'PLACEHOLDER'
        WHEN LTRIM(RTRIM([State Name])) = ''
            THEN 'BLANK'
        ELSE 'ACTUAL VALUE'
    END AS State_Name_Group,

    COUNT(*) AS RecordCount

FROM Banking_Data_3

GROUP BY
    CASE
        WHEN [Tranfer Logic] IS NULL THEN 'NULL'
        WHEN UPPER(LTRIM(RTRIM([Tranfer Logic]))) IN ('YES', 'NO')
            THEN 'YES / NO'
        ELSE 'STATE NAME / OTHER'
    END,
    CASE
        WHEN [State Name] IS NULL THEN 'NULL'
        WHEN UPPER(LTRIM(RTRIM([State Name]))) = 'STATE NAME'
            THEN 'PLACEHOLDER'
        WHEN LTRIM(RTRIM([State Name])) = ''
            THEN 'BLANK'
        ELSE 'ACTUAL VALUE'
    END

ORDER BY
    Transfer_Logic_Group,
    State_Name_Group;
---------------------------------------------

WITH StateReference AS
(
    SELECT
        CASE
            WHEN UPPER(LTRIM(RTRIM([Tranfer Logic]))) IN ('YES', 'NO')
                THEN UPPER(LTRIM(RTRIM([State Name])))
            ELSE UPPER(LTRIM(RTRIM([Tranfer Logic])))
        END AS Derived_State_Name,

        UPPER(LTRIM(RTRIM([ State Abbr]))) AS Abbr_1,
        UPPER(LTRIM(RTRIM([State Abbr]))) AS Abbr_2

    FROM Banking_Data_3
)
SELECT
    Derived_State_Name,
    Abbr_1,
    Abbr_2,
    COUNT(*) AS RecordCount
FROM StateReference
GROUP BY
    Derived_State_Name,
    Abbr_1,
    Abbr_2
ORDER BY
    Derived_State_Name,
    RecordCount DESC;
-----------------------------------------

WITH StateReference AS
(
    SELECT
        CASE
            WHEN UPPER(LTRIM(RTRIM([Tranfer Logic]))) IN ('YES', 'NO')
                THEN UPPER(LTRIM(RTRIM([State Name])))
            ELSE UPPER(LTRIM(RTRIM([Tranfer Logic])))
        END AS Derived_State_Name,

        UPPER(LTRIM(RTRIM([ State Abbr]))) AS Abbr_1,
        UPPER(LTRIM(RTRIM([State Abbr]))) AS Abbr_2

    FROM Banking_Data_3
),
StateCounts AS
(
    SELECT
        Derived_State_Name,
        Abbr_1,
        Abbr_2,
        COUNT(*) AS RecordCount,

        SUM(CASE
            WHEN Abbr_1 <> Abbr_2 THEN 1
            ELSE 0
        END) AS Abbreviation_Conflict

    FROM StateReference
    GROUP BY Derived_State_Name, Abbr_1, Abbr_2
)
SELECT
    SUM(RecordCount) AS Total_Records,
    SUM(Abbreviation_Conflict) AS Total_Conflicts,
    CAST(
        100.0 * SUM(Abbreviation_Conflict) / SUM(RecordCount)
        AS DECIMAL(10,2)
    ) AS Conflict_Percentage
FROM StateCounts;
-----------------------------------
WITH StateReference AS
(
    SELECT
        *,
        CASE
            WHEN UPPER(LTRIM(RTRIM([Tranfer Logic]))) IN ('YES', 'NO')
                THEN UPPER(LTRIM(RTRIM([State Name])))
            ELSE UPPER(LTRIM(RTRIM([Tranfer Logic])))
        END AS Derived_State_Name
    FROM Banking_Data_3
)
SELECT
    Derived_State_Name,
    [ State Abbr] AS Abbr_1,
    [State Abbr] AS Abbr_2,
    [Tranfer Logic],
    [State Name],
    [Region Name],
    [Branch Name],
    [Product Code],
    [Loan Status],
    YEAR([Disbursement Date]) AS Disbursement_Year,
    COUNT(*) AS Record_Count
FROM StateReference
WHERE
    UPPER(LTRIM(RTRIM([ State Abbr])))
    <>
    UPPER(LTRIM(RTRIM([State Abbr])))
GROUP BY
    Derived_State_Name,
    [ State Abbr],
    [State Abbr],
    [Tranfer Logic],
    [State Name],
    [Region Name],
    [Branch Name],
    [Product Code],
    [Loan Status],
    YEAR([Disbursement Date])
ORDER BY
    Derived_State_Name,
    Record_Count DESC;

WITH StateReference AS
(
    SELECT
        CASE
            WHEN UPPER(LTRIM(RTRIM([Tranfer Logic]))) IN ('YES', 'NO')
                THEN UPPER(LTRIM(RTRIM([State Name])))
            ELSE UPPER(LTRIM(RTRIM([Tranfer Logic])))
        END AS Derived_State_Name,

        UPPER(LTRIM(RTRIM([ State Abbr]))) AS Abbr_1,
        UPPER(LTRIM(RTRIM([State Abbr]))) AS Abbr_2,

        UPPER(LTRIM(RTRIM([Region Name]))) AS Region_Name,
        UPPER(LTRIM(RTRIM([Branch Name]))) AS Branch_Name

    FROM Banking_Data_3
)
SELECT
    Derived_State_Name,
    Abbr_1,
    Abbr_2,
    Region_Name,
    Branch_Name,
    COUNT(*) AS Record_Count
FROM StateReference
WHERE Branch_Name IN ('KOTWA', 'JAJPUR', 'DEOGARH')
GROUP BY
    Derived_State_Name,
    Abbr_1,
    Abbr_2,
    Region_Name,
    Branch_Name
ORDER BY
    Branch_Name,
    Record_Count DESC;