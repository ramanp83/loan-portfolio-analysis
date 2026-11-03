SELECT
    CAST([Disbursement Date] AS DATE) AS Disbursement_Date,
    [Product Id],

    COUNT(*) AS Total_Records,

    SUM(
        CASE
            WHEN [Grrade] IS NULL
             AND [Sub Grade] IS NULL
            THEN 1 ELSE 0
        END
    ) AS Both_Missing_Count,

    CAST(
        100.0 * SUM(
            CASE
                WHEN [Grrade] IS NULL
                 AND [Sub Grade] IS NULL
                THEN 1 ELSE 0
            END
        ) / NULLIF(COUNT(*), 0)
        AS DECIMAL(6,2)
    ) AS Missing_Rate_Pct

FROM Banking_Data_3

WHERE [Product Code] = 'XL'
  AND [Product Id] IN (
      'CL14H',
      'CL28H',
      'CL42H',
      'CL6000',
      'CL84H',
      'CL87H',
      'CL142H'
  )
  AND [Disbursement Date] >= '2019-03-25'
  AND [Disbursement Date] < '2019-04-11'

GROUP BY
    CAST([Disbursement Date] AS DATE),
    [Product Id]

ORDER BY
    Disbursement_Date,
    [Product Id];

exec sp_help banking_data_3;
SELECT
    COUNT(*) AS Total_Records,
    MIN([Disbursement Date]) AS Earliest_Disbursement_Date,
    MAX([Disbursement Date]) AS Latest_Disbursement_Date,
    COUNT([Disbursement Date]) AS Non_Null_Disbursement_Dates,
    COUNT(DISTINCT [Account ID]) AS Unique_Accounts,
    COUNT(DISTINCT [Client ID]) AS Unique_Clients
FROM Banking_Data_3;