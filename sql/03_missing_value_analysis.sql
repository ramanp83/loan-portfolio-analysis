-- this query to quantify missing values in the fields we previously identified.
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

-------------------------------------------------------------

--Are these four fields missing together in the same records, or do their missing values occur in different records?
SELECT
    COUNT_BIG(*) AS Total_Rows,

    SUM(CASE
        WHEN [Grrade] IS NULL
         AND [Sub Grade] IS NULL
         AND ( [Home Ownership] IS NULL
               OR LTRIM(RTRIM([Home Ownership])) = '' )
         AND ( [Verification Status] IS NULL
               OR LTRIM(RTRIM([Verification Status])) = '' )
        THEN 1 ELSE 0
    END) AS All_Four_Missing,

    SUM(CASE
        WHEN [Grrade] IS NOT NULL
         AND [Sub Grade] IS NOT NULL
         AND [Home Ownership] IS NOT NULL
         AND LTRIM(RTRIM([Home Ownership])) <> ''
         AND [Verification Status] IS NOT NULL
         AND LTRIM(RTRIM([Verification Status])) <> ''
        THEN 1 ELSE 0
    END) AS All_Four_Present

FROM Banking_Data_3;

-------------------------------------------------------------

-- Are records with all four fields missing concentrated in particular loan statuses, or are they spread across all statuses?

SELECT
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
GROUP BY [Loan Status]
ORDER BY Missing_Rate_Pct DESC, Total_Loans DESC;

-------------------------------------------------------------

--does disbursement year matter too?
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

-------------------------------------------------------------

-- validate the pattern against product code

SELECT
    YEAR([Disbursement Date]) AS Disbursement_Year,
    [Product Code],
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
    [Product Code],
    [Loan Status]
ORDER BY
    Disbursement_Year,
    Missing_Rate_Pct DESC,
    Total_Loans DESC;


SELECT TOP (100)
    [Disbursement Date],
    [Product Code],
    [Loan Status],
    [Grrade],
    [Sub Grade],
    [Home Ownership],
    [Verification Status]
FROM Banking_Data_3
WHERE
    (
        YEAR([Disbursement Date]) = 2019
        AND [Product Code] = 'XTL'
        AND [Loan Status] = 'Active Loan'
    )
    OR
    (
        YEAR([Disbursement Date]) = 2020
        AND [Product Code] = 'XLG'
        AND [Loan Status] = 'Active Loan'
    )
ORDER BY
    [Disbursement Date],
    [Product Code];

-------------------------------------------------------------

--query to summarize the actual values in both groups without returning hundreds of rows.

SELECT
    YEAR([Disbursement Date]) AS Disbursement_Year,
    [Product Code],
    [Loan Status],
    COUNT(*) AS Total_Rows,

    SUM(CASE WHEN [Grrade] IS NULL
        THEN 1 ELSE 0 END) AS Grade_Null,

    SUM(CASE WHEN [Sub Grade] IS NULL
        THEN 1 ELSE 0 END) AS Sub_Grade_Null,

    SUM(CASE WHEN [Home Ownership] IS NULL
        OR LTRIM(RTRIM([Home Ownership])) = ''
        THEN 1 ELSE 0 END) AS Home_Ownership_Missing,

    SUM(CASE WHEN [Verification Status] IS NULL
        OR LTRIM(RTRIM([Verification Status])) = ''
        THEN 1 ELSE 0 END) AS Verification_Status_Missing

FROM Banking_Data_3
WHERE
    (YEAR([Disbursement Date]) = 2019
     AND [Product Code] = 'XTL'
     AND [Loan Status] = 'Active Loan')
    OR
    (YEAR([Disbursement Date]) = 2020
     AND [Product Code] = 'XLG'
     AND [Loan Status] = 'Active Loan')
GROUP BY
    YEAR([Disbursement Date]),
    [Product Code],
    [Loan Status]
ORDER BY
    Disbursement_Year,
    [Product Code];

-------------------------------------------------------------

--query to compare the four fields across products for Active Loan records in 2019 and 2020:
SELECT
    YEAR([Disbursement Date]) AS Disbursement_Year,
    [Product Code],
    COUNT(*) AS Total_Rows,

    SUM(CASE WHEN [Grrade] IS NULL
        AND [Sub Grade] IS NULL
        AND ([Home Ownership] IS NULL
             OR LTRIM(RTRIM([Home Ownership])) = '')
        AND ([Verification Status] IS NULL
             OR LTRIM(RTRIM([Verification Status])) = '')
        THEN 1 ELSE 0 END) AS All_Four_Missing,

    SUM(CASE WHEN [Grrade] IS NOT NULL
        AND [Sub Grade] IS NOT NULL
        AND [Home Ownership] IS NOT NULL
        AND LTRIM(RTRIM([Home Ownership])) <> ''
        AND [Verification Status] IS NOT NULL
        AND LTRIM(RTRIM([Verification Status])) <> ''
        THEN 1 ELSE 0 END) AS All_Four_Present

FROM Banking_Data_3
WHERE YEAR([Disbursement Date]) IN (2019, 2020)
  AND [Loan Status] = 'Active Loan'
GROUP BY
    YEAR([Disbursement Date]),
    [Product Code]
ORDER BY
    Disbursement_Year,
    [Product Code];

-------------------------------------------------------------

--examine the monthly pattern for 2019 and 2020
SELECT
    YEAR([Disbursement Date]) AS Disbursement_Year,
    MONTH([Disbursement Date]) AS Disbursement_Month,
    [Product Code],
    COUNT(*) AS Total_Rows,
    SUM(CASE
        WHEN [Grrade] IS NULL
         AND [Sub Grade] IS NULL
         AND ([Home Ownership] IS NULL
              OR LTRIM(RTRIM([Home Ownership])) = '')
         AND ([Verification Status] IS NULL
              OR LTRIM(RTRIM([Verification Status])) = '')
        THEN 1 ELSE 0
    END) AS All_Four_Missing,

    SUM(CASE
    WHEN [Grrade] IS NOT NULL
     AND [Sub Grade] IS NOT NULL
     AND [Home Ownership] IS NOT NULL
     AND LTRIM(RTRIM([Home Ownership])) <> ''
     AND [Verification Status] IS NOT NULL
     AND LTRIM(RTRIM([Verification Status])) <> ''
    THEN 1 ELSE 0
END) AS All_Four_Present

FROM Banking_Data_3
WHERE YEAR([Disbursement Date]) IN (2019, 2020)
  AND [Loan Status] = 'Active Loan'
GROUP BY
    YEAR([Disbursement Date]),
    MONTH([Disbursement Date]),
    [Product Code]
ORDER BY
    Disbursement_Year,
    Disbursement_Month,
    [Product Code];

-------------------------------------------------------------

SELECT
    YEAR([Disbursement Date]) AS Disbursement_Year,
    MONTH([Disbursement Date]) AS Disbursement_Month,
    [Product Code],
    [Loan Status],
    COUNT(*) AS Total_Rows,

    SUM(CASE
        WHEN [Grrade] IS NULL
         AND [Sub Grade] IS NULL
         AND ([Home Ownership] IS NULL
              OR LTRIM(RTRIM([Home Ownership])) = '')
         AND ([Verification Status] IS NULL
              OR LTRIM(RTRIM([Verification Status])) = '')
        THEN 1 ELSE 0
    END) AS All_Four_Missing,

    SUM(CASE
        WHEN [Grrade] IS NOT NULL
         AND [Sub Grade] IS NOT NULL
         AND [Home Ownership] IS NOT NULL
         AND LTRIM(RTRIM([Home Ownership])) <> ''
         AND [Verification Status] IS NOT NULL
         AND LTRIM(RTRIM([Verification Status])) <> ''
        THEN 1 ELSE 0
    END) AS All_Four_Present

FROM Banking_Data_3
WHERE [Disbursement Date] >= '2019-03-01'
  AND [Disbursement Date] < '2019-05-01'
  AND [Product Code] IN ('XL', 'XLG')
GROUP BY
    YEAR([Disbursement Date]),
    MONTH([Disbursement Date]),
    [Product Code],
    [Loan Status]
ORDER BY
    Disbursement_Year,
    Disbursement_Month,
    [Product Code],
    [Loan Status];

-------------------------------------------------------------

--check whether the pattern is specific to Active Loans
SELECT
    YEAR([Disbursement Date]) AS Disbursement_Year,
    MONTH([Disbursement Date]) AS Disbursement_Month,
    [Product Code],
    [Loan Status],
    COUNT(*) AS Total_Rows,

    SUM(CASE
        WHEN [Grrade] IS NULL
         AND [Sub Grade] IS NULL
         AND ([Home Ownership] IS NULL
              OR LTRIM(RTRIM([Home Ownership])) = '')
         AND ([Verification Status] IS NULL
              OR LTRIM(RTRIM([Verification Status])) = '')
        THEN 1 ELSE 0
    END) AS All_Four_Missing,

    SUM(CASE
        WHEN [Grrade] IS NOT NULL
         AND [Sub Grade] IS NOT NULL
         AND [Home Ownership] IS NOT NULL
         AND LTRIM(RTRIM([Home Ownership])) <> ''
         AND [Verification Status] IS NOT NULL
         AND LTRIM(RTRIM([Verification Status])) <> ''
        THEN 1 ELSE 0
    END) AS All_Four_Present

FROM Banking_Data_3
WHERE [Disbursement Date] >= '2019-03-01'
  AND [Disbursement Date] < '2019-05-01'
  AND [Product Code] IN ('XL', 'XLG')
GROUP BY
    YEAR([Disbursement Date]),
    MONTH([Disbursement Date]),
    [Product Code],
    [Loan Status]
ORDER BY
    Disbursement_Year,
    Disbursement_Month,
    [Product Code],
    [Loan Status];

-------------------------------------------------------------

SELECT
    YEAR([Disbursement Date]) AS Disbursement_Year,
    MONTH([Disbursement Date]) AS Disbursement_Month,
    [Product Code],
    COUNT(*) AS Total_Rows,

    SUM(CASE
        WHEN [Grrade] IS NULL
         AND [Sub Grade] IS NULL
         AND ([Home Ownership] IS NULL
              OR LTRIM(RTRIM([Home Ownership])) = '')
         AND ([Verification Status] IS NULL
              OR LTRIM(RTRIM([Verification Status])) = '')
        THEN 1 ELSE 0
    END) AS All_Four_Missing,

    SUM(CASE
        WHEN [Grrade] IS NOT NULL
         AND [Sub Grade] IS NOT NULL
         AND [Home Ownership] IS NOT NULL
         AND LTRIM(RTRIM([Home Ownership])) <> ''
         AND [Verification Status] IS NOT NULL
         AND LTRIM(RTRIM([Verification Status])) <> ''
        THEN 1 ELSE 0
    END) AS All_Four_Present

FROM Banking_Data_3
WHERE [Disbursement Date] >= '2019-01-01'
  AND [Disbursement Date] < '2019-07-01'
  AND [Product Code] IN ('XL', 'XLG')
GROUP BY
    YEAR([Disbursement Date]),
    MONTH([Disbursement Date]),
    [Product Code]
ORDER BY
    Disbursement_Year,
    Disbursement_Month,
    [Product Code];

-------------------------------------------------------------

SELECT
    YEAR([Disbursement Date]) AS Disbursement_Year,
    MONTH([Disbursement Date]) AS Disbursement_Month,
    COUNT(*) AS Total_Rows,

    SUM(CASE WHEN [Grrade] IS NULL
        THEN 1 ELSE 0 END) AS Grade_Null,

    SUM(CASE WHEN [Sub Grade] IS NULL
        THEN 1 ELSE 0 END) AS Sub_Grade_Null,

    SUM(CASE WHEN [Home Ownership] IS NULL
              OR LTRIM(RTRIM([Home Ownership])) = ''
        THEN 1 ELSE 0 END) AS Home_Ownership_Missing,

    SUM(CASE WHEN [Verification Status] IS NULL
              OR LTRIM(RTRIM([Verification Status])) = ''
        THEN 1 ELSE 0 END) AS Verification_Status_Missing

FROM Banking_Data_3
WHERE [Disbursement Date] >= '2019-01-01'
  AND [Disbursement Date] < '2019-07-01'
  AND [Product Code] = 'XL'
GROUP BY
    YEAR([Disbursement Date]),
    MONTH([Disbursement Date])
ORDER BY
    Disbursement_Year,
    Disbursement_Month;

-------------------------------------------------------------

--compare the individual fields for XL and XLG in March and April 2019, across all loan statuses.
SELECT
    YEAR([Disbursement Date]) AS Disbursement_Year,
    MONTH([Disbursement Date]) AS Disbursement_Month,
    [Product Code],
    COUNT(*) AS Total_Rows,

    SUM(CASE WHEN [Grrade] IS NULL
        THEN 1 ELSE 0 END) AS Grade_Null,

    SUM(CASE WHEN [Sub Grade] IS NULL
        THEN 1 ELSE 0 END) AS Sub_Grade_Null,

    SUM(CASE WHEN [Home Ownership] IS NULL
              OR LTRIM(RTRIM([Home Ownership])) = ''
        THEN 1 ELSE 0 END) AS Home_Ownership_Missing,

    SUM(CASE WHEN [Verification Status] IS NULL
              OR LTRIM(RTRIM([Verification Status])) = ''
        THEN 1 ELSE 0 END) AS Verification_Status_Missing

FROM Banking_Data_3
WHERE [Disbursement Date] >= '2019-03-01'
  AND [Disbursement Date] < '2019-05-01'
  AND [Product Code] IN ('XL', 'XLG')
GROUP BY
    YEAR([Disbursement Date]),
    MONTH([Disbursement Date]),
    [Product Code]
ORDER BY
    Disbursement_Year,
    Disbursement_Month,
    [Product Code];

-------------------------------------------------------------

SELECT
    COUNT_BIG(*) AS Total_Rows,

    SUM(CASE
        WHEN [Grrade] IS NULL
         AND [Sub Grade] IS NULL
         AND ([Home Ownership] IS NULL
              OR LTRIM(RTRIM([Home Ownership])) = '')
         AND ([Verification Status] IS NULL
              OR LTRIM(RTRIM([Verification Status])) = '')
        THEN 1 ELSE 0
    END) AS All_Four_Missing,

    SUM(CASE
        WHEN [Grrade] IS NOT NULL
         AND [Sub Grade] IS NOT NULL
         AND [Home Ownership] IS NOT NULL
         AND LTRIM(RTRIM([Home Ownership])) <> ''
         AND [Verification Status] IS NOT NULL
         AND LTRIM(RTRIM([Verification Status])) <> ''
        THEN 1 ELSE 0
    END) AS All_Four_Present,

    SUM(CASE
        WHEN NOT (
            [Grrade] IS NULL
            AND [Sub Grade] IS NULL
            AND ([Home Ownership] IS NULL
                 OR LTRIM(RTRIM([Home Ownership])) = '')
            AND ([Verification Status] IS NULL
                 OR LTRIM(RTRIM([Verification Status])) = '')
        )
        AND NOT (
            [Grrade] IS NOT NULL
            AND [Sub Grade] IS NOT NULL
            AND [Home Ownership] IS NOT NULL
            AND LTRIM(RTRIM([Home Ownership])) <> ''
            AND [Verification Status] IS NOT NULL
            AND LTRIM(RTRIM([Verification Status])) <> ''
        )
        THEN 1 ELSE 0
    END) AS Mixed_Pattern_Rows

FROM Banking_Data_3;

-------------------------------------------------------------

--the missingness by loan status and disbursement year together
SELECT
    YEAR([Disbursement Date]) as Disbursement_year,
    [Loan Status],
    COUNT_BIG(*) AS Total_Rows,

    SUM(CASE
        WHEN [Grrade] IS NULL
         AND [Sub Grade] IS NULL
         AND ([Home Ownership] IS NULL
              OR LTRIM(RTRIM([Home Ownership])) = '')
         AND ([Verification Status] IS NULL
              OR LTRIM(RTRIM([Verification Status])) = '')
        THEN 1 ELSE 0
    END) AS All_Four_Missing,

    SUM(CASE
        WHEN [Grrade] IS NOT NULL
         AND [Sub Grade] IS NOT NULL
         AND [Home Ownership] IS NOT NULL
         AND LTRIM(RTRIM([Home Ownership])) <> ''
         AND [Verification Status] IS NOT NULL
         AND LTRIM(RTRIM([Verification Status])) <> ''
        THEN 1 ELSE 0
    END) AS All_Four_Present,

    SUM(CASE
        WHEN NOT (
            [Grrade] IS NULL
            AND [Sub Grade] IS NULL
            AND ([Home Ownership] IS NULL
                 OR LTRIM(RTRIM([Home Ownership])) = '')
            AND ([Verification Status] IS NULL
                 OR LTRIM(RTRIM([Verification Status])) = '')
        )
        AND NOT (
            [Grrade] IS NOT NULL
            AND [Sub Grade] IS NOT NULL
            AND [Home Ownership] IS NOT NULL
            AND LTRIM(RTRIM([Home Ownership])) <> ''
            AND [Verification Status] IS NOT NULL
            AND LTRIM(RTRIM([Verification Status])) <> ''
        )
        THEN 1 ELSE 0
    END) AS Mixed_Pattern_Rows

FROM Banking_Data_3
group by 
    YEAR([Disbursement Date]),
    [Loan Status]
order by 
    YEAR([Disbursement Date]);

-------------------------------------------------------------

--calculate missing rates for every year/status group
SELECT
    YEAR([Disbursement Date]) AS Disbursement_Year,
    [Loan Status],
    COUNT_BIG(*) AS Total_Rows,

    SUM(CASE
        WHEN [Grrade] IS NULL
         AND [Sub Grade] IS NULL
         AND ([Home Ownership] IS NULL
              OR LTRIM(RTRIM([Home Ownership])) = '')
         AND ([Verification Status] IS NULL
              OR LTRIM(RTRIM([Verification Status])) = '')
        THEN 1 ELSE 0
    END) AS All_Four_Missing,

    CAST(
        100.0 * SUM(CASE
            WHEN [Grrade] IS NULL
             AND [Sub Grade] IS NULL
             AND ([Home Ownership] IS NULL
                  OR LTRIM(RTRIM([Home Ownership])) = '')
             AND ([Verification Status] IS NULL
                  OR LTRIM(RTRIM([Verification Status])) = '')
            THEN 1 ELSE 0
        END) / COUNT_BIG(*) AS DECIMAL(6,2)
    ) AS Missing_Rate_Pct

FROM Banking_Data_3
GROUP BY
    YEAR([Disbursement Date]),
    [Loan Status]
ORDER BY
    Disbursement_Year,
    Missing_Rate_Pct DESC;
