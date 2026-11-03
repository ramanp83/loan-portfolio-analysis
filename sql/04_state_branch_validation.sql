SELECT TOP (100)
    [State Name],
    [Tranfer Logic],
    [ State Abbr],
    [State Abbr],
    [Branch Name],
    [Product Code],
    [Loan Status],
    [Disbursement Date]
FROM Banking_Data_3
WHERE LTRIM(RTRIM([State Name])) = 'State Name'
   OR UPPER(LTRIM(RTRIM([Tranfer Logic]))) IN (
        'ASSAM',
        'ODISHA',
        'BIHAR',
        'UTTAR PRADESH'
   );

-------------------------------------------------------------

SELECT
    COUNT(*) AS TotalRows,
    SUM(CASE
        WHEN LTRIM(RTRIM([State Name])) = 'State Name'
        THEN 1 ELSE 0
    END) AS StateNameLiteralRows,
    SUM(CASE
        WHEN UPPER(LTRIM(RTRIM([Tranfer Logic]))) IN (
            'ASSAM',
            'ODISHA',
            'BIHAR',
            'UTTAR PRADESH'
        )
        THEN 1 ELSE 0
    END) AS StateNamesInTransferLogic,
    SUM(CASE
        WHEN LTRIM(RTRIM([State Name])) = 'State Name'
         AND UPPER(LTRIM(RTRIM([Tranfer Logic]))) IN (
            'ASSAM',
            'ODISHA',
            'BIHAR',
            'UTTAR PRADESH'
         )
        THEN 1 ELSE 0
    END) AS BothConditions
FROM Banking_Data_3;

-------------------------------------------------------------

SELECT
    LTRIM(RTRIM([Tranfer Logic])) AS TransferLogicValue,
    COUNT(*) AS RowCounts
FROM Banking_Data_3
WHERE LTRIM(RTRIM([State Name])) = 'State Name'
GROUP BY LTRIM(RTRIM([Tranfer Logic]))
ORDER BY RowCounts DESC;

-------------------------------------------------------------

SELECT
    LTRIM(RTRIM([Tranfer Logic])) AS SuspectedStateName,
    LTRIM(RTRIM([ State Abbr])) AS StateAbbrLeadingSpace,
    LTRIM(RTRIM([State Abbr])) AS StateAbbr,
    COUNT(*) AS RowCounts,
    SUM(CASE
        WHEN LTRIM(RTRIM([ State Abbr]))
             = LTRIM(RTRIM([State Abbr]))
        THEN 1 ELSE 0
    END) AS AbbreviationsMatch,
    SUM(CASE
        WHEN [ State Abbr] IS NULL
          OR [State Abbr] IS NULL
        THEN 1 ELSE 0
    END) AS RowsWithNullAbbreviation
FROM Banking_Data_3
WHERE LTRIM(RTRIM([State Name])) = 'State Name'
GROUP BY
    LTRIM(RTRIM([Tranfer Logic])),
    LTRIM(RTRIM([ State Abbr])),
    LTRIM(RTRIM([State Abbr]))
ORDER BY RowCounts DESC;

-------------------------------------------------------------

select 
    [Tranfer Logic],
    count(*) as total_record
from Banking_Data_3
group by [Tranfer Logic]

-------------------------------------------------------------

SELECT
    [State Name],
    [Tranfer Logic],
    [ State Abbr],
    [State Abbr],
    [Branch Name],
    [Branch Name],
    [Product Code],
    [Loan Status],
    [Disbursement Date]
FROM Banking_Data_3
WHERE LTRIM(RTRIM([State Name])) = 'State Name'
  AND (
       (
           LTRIM(RTRIM([Tranfer Logic])) = 'BIHAR'
           AND LTRIM(RTRIM([ State Abbr])) = 'UP'
           AND LTRIM(RTRIM([State Abbr])) = 'BR'
       )
       OR
       (
           LTRIM(RTRIM([Tranfer Logic])) = 'ODISHA'
           AND LTRIM(RTRIM([ State Abbr])) = 'RJ'
           AND LTRIM(RTRIM([State Abbr])) = 'OR'
       )
  )
ORDER BY [Tranfer Logic] ;

-------------------------------------------------------------

SELECT
    COLUMN_NAME,
    ORDINAL_POSITION,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Banking_Data_3'
  AND COLUMN_NAME LIKE '%State%'
ORDER BY ORDINAL_POSITION;

-------------------------------------------------------------

SELECT
    ORDINAL_POSITION,
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Banking_Data_3'
ORDER BY ORDINAL_POSITION;

-------------------------------------------------------------

SELECT TOP (30)
    [Account ID],
    [Region Name],
    [Religion],
    [Verification Status],
    [ State Abbr],
    [State Abbr],
    [State Name],
    [Tranfer Logic],
    [Is Delinquent Loan],
    [Is Default Loan],
    [Product Code],
    [Branch Name],
    [Disbursement Date]
FROM Banking_Data_3
WHERE LTRIM(RTRIM([State Name])) = 'State Name'
ORDER BY [Tranfer Logic], [Account ID];

-------------------------------------------------------------

SELECT
    CASE
        WHEN LTRIM(RTRIM([State Name])) = 'State Name'
            THEN 'Placeholder in State Name'
        ELSE 'Other State Name Value'
    END AS StateNameGroup,
    LTRIM(RTRIM([Tranfer Logic])) AS TransferLogicValue,
    COUNT(*) AS RowCounts
FROM Banking_Data_3
GROUP BY
    CASE
        WHEN LTRIM(RTRIM([State Name])) = 'State Name'
            THEN 'Placeholder in State Name'
        ELSE 'Other State Name Value'
    END,
    LTRIM(RTRIM([Tranfer Logic]))
ORDER BY
    StateNameGroup,
    RowCounts DESC;

-------------------------------------------------------------

SELECT TOP (20)
    [Account ID],
    [ State Abbr],
    [State Abbr],
    [State Name],
    [Tranfer Logic],
    [Region Name],
    [Branch Name],
    [Disbursement Date]
FROM Banking_Data_3
WHERE LTRIM(RTRIM([State Name])) <> 'State Name'
  AND [State Name] IS NOT NULL
ORDER BY [Disbursement Date];

-------------------------------------------------------------

SELECT
    LTRIM(RTRIM([Tranfer Logic])) AS SuspectedStateName,
    LTRIM(RTRIM([ State Abbr])) AS AbbrColumn1,
    LTRIM(RTRIM([State Abbr])) AS AbbrColumn2,
    COUNT(*) AS TotalRows,
    SUM(CASE
        WHEN LTRIM(RTRIM([ State Abbr]))
           = LTRIM(RTRIM([State Abbr]))
        THEN 1 ELSE 0
    END) AS MatchingAbbreviations,
    SUM(CASE
        WHEN LTRIM(RTRIM([ State Abbr]))
           <> LTRIM(RTRIM([State Abbr]))
        THEN 1 ELSE 0
    END) AS MismatchingAbbreviations
FROM Banking_Data_3
WHERE LTRIM(RTRIM([State Name])) = 'State Name'
GROUP BY
    LTRIM(RTRIM([Tranfer Logic])),
    LTRIM(RTRIM([ State Abbr])),
    LTRIM(RTRIM([State Abbr]))
ORDER BY TotalRows DESC;

-------------------------------------------------------------

SELECT
    YEAR([Disbursement Date]) as Disbursement_year,
    LTRIM(RTRIM([Tranfer Logic])) AS SuspectedState,
    LTRIM(RTRIM([ State Abbr])) AS FirstAbbr,
    LTRIM(RTRIM([State Abbr])) AS SecondAbbr,
    [Region Name],
    [Branch Name],
    [Product Code],
    [Loan Status],
    COUNT(*) AS RowCounts
FROM Banking_Data_3
WHERE LTRIM(RTRIM([State Name])) = 'State Name'
  AND LTRIM(RTRIM([ State Abbr]))
      <> LTRIM(RTRIM([State Abbr]))
GROUP BY
    YEAR([Disbursement Date]),
    LTRIM(RTRIM([Tranfer Logic])),
    LTRIM(RTRIM([ State Abbr])),
    LTRIM(RTRIM([State Abbr])),
    [Region Name],
    [Branch Name],
    [Product Code],
    [Loan Status]
ORDER BY
    SuspectedState,
    RowCounts DESC;

-------------------------------------------------------------

SELECT
    [ State Abbr] as state_1,
    [State Abbr] as state_2,
    [Region Name],
    CASE
        WHEN [ State Abbr] IS NULL
          OR [State Abbr] IS NULL
            THEN 'At least one abbreviation is NULL'
        WHEN LTRIM(RTRIM([ State Abbr]))
           = LTRIM(RTRIM([State Abbr]))
            THEN 'Abbreviations Match'
        ELSE 'Abbreviations Mismatch'
    END AS AbbreviationCheck,
    COUNT(*) AS RowCounts
FROM Banking_Data_3
GROUP BY
     [ State Abbr],
    [State Abbr],
    [Region Name],
    CASE
        WHEN [ State Abbr] IS NULL
          OR [State Abbr] IS NULL
            THEN 'At least one abbreviation is NULL'
        WHEN LTRIM(RTRIM([ State Abbr]))
           = LTRIM(RTRIM([State Abbr]))
            THEN 'Abbreviations Match'
        ELSE 'Abbreviations Mismatch'
    END
ORDER BY RowCounts DESC;

-------------------------------------------------------------

SELECT
    LTRIM(RTRIM([ State Abbr])) AS State1,
    LTRIM(RTRIM([State Abbr])) AS State2,
    LTRIM(RTRIM([State Name])) AS StateName,
    LTRIM(RTRIM([Tranfer Logic])) AS TransferLogic,
    [Region Name],
    COUNT(*) AS RowCounts
FROM Banking_Data_3
WHERE
    LTRIM(RTRIM([ State Abbr]))
        <> LTRIM(RTRIM([State Abbr]))
GROUP BY
    LTRIM(RTRIM([ State Abbr])),
    LTRIM(RTRIM([State Abbr])),
    LTRIM(RTRIM([State Name])),
    LTRIM(RTRIM([Tranfer Logic])),
    [Region Name]
ORDER BY RowCounts DESC;

-------------------------------------------------------------

SELECT  
    [Account ID],
    [ State Abbr] AS State1,
    [State Abbr] AS State2,
    [State Name],
    [Tranfer Logic],
    [Region Name],
    [Branch Name],
    [Product Code],
    [Loan Status],
    [Disbursement Date]
FROM Banking_Data_3
WHERE LTRIM(RTRIM([ State Abbr])) = 'RJ'
  AND LTRIM(RTRIM([State Abbr])) = 'OR'
  AND LTRIM(RTRIM([State Name])) = 'ODISHA'
ORDER BY [Disbursement Date], [Account ID];

-------------------------------------------------------------

SELECT
    [ State Abbr] AS State1,
    [State Abbr] AS State2,
    [State Name],
    [Tranfer Logic],
    [Region Name],
    [Branch Name],
    [Product Code],
    [Loan Status],
    YEAR([Disbursement Date]) AS DisbursementYear,
    COUNT(*) AS RowCounts
FROM Banking_Data_3
WHERE LTRIM(RTRIM([ State Abbr])) = 'RJ'
  AND LTRIM(RTRIM([State Abbr])) = 'OR'
  AND LTRIM(RTRIM([State Name])) = 'ODISHA'
GROUP BY
    [ State Abbr],
    [State Abbr],
    [State Name],
    [Tranfer Logic],
    [Region Name],
    [Branch Name],
    [Product Code],
    [Loan Status],
    YEAR([Disbursement Date])
ORDER BY RowCounts DESC;

-------------------------------------------------------------

SELECT
    LTRIM(RTRIM([ State Abbr])) AS State1,
    LTRIM(RTRIM([State Abbr])) AS State2,
    LTRIM(RTRIM([State Name])) AS StateName,
    LTRIM(RTRIM([Tranfer Logic])) AS TransferLogic,
    LTRIM(RTRIM([Region Name])) AS RegionName,
    LTRIM(RTRIM([Branch Name])) AS BranchName,
    [Product Code],
    [Loan Status],
    YEAR([Disbursement Date]) AS DisbursementYear,
    COUNT(*) AS RowCounts
FROM Banking_Data_3
WHERE LTRIM(RTRIM([ State Abbr]))
   <> LTRIM(RTRIM([State Abbr]))
GROUP BY
    LTRIM(RTRIM([ State Abbr])),
    LTRIM(RTRIM([State Abbr])),
    LTRIM(RTRIM([State Name])),
    LTRIM(RTRIM([Tranfer Logic])),
    LTRIM(RTRIM([Region Name])),
    LTRIM(RTRIM([Branch Name])),
    [Product Code],
    [Loan Status],
    YEAR([Disbursement Date])
ORDER BY RowCounts DESC;

-------------------------------------------------------------

SELECT
    CASE
        WHEN LTRIM(RTRIM([State Name])) = 'State Name'
            THEN 'Placeholder State Name'
        WHEN LTRIM(RTRIM([State Name])) = 'ODISHA'
             AND LTRIM(RTRIM([ State Abbr])) = 'RJ'
             AND LTRIM(RTRIM([State Abbr])) = 'OR'
            THEN 'Odisha Abbreviation Conflict'
        WHEN LTRIM(RTRIM([State Name])) = 'RAJASTHAN'
             AND LTRIM(RTRIM([ State Abbr])) = 'OD'
             AND LTRIM(RTRIM([State Abbr])) = 'RJ'
            THEN 'Rajasthan Exception'
        ELSE 'Other Abbreviation Conflict'
    END AS AnomalyType,
    COUNT(*) AS RowCounts
FROM Banking_Data_3
WHERE LTRIM(RTRIM([ State Abbr]))
   <> LTRIM(RTRIM([State Abbr]))
GROUP BY
    CASE
        WHEN LTRIM(RTRIM([State Name])) = 'State Name'
            THEN 'Placeholder State Name'
        WHEN LTRIM(RTRIM([State Name])) = 'ODISHA'
             AND LTRIM(RTRIM([ State Abbr])) = 'RJ'
             AND LTRIM(RTRIM([State Abbr])) = 'OR'
            THEN 'Odisha Abbreviation Conflict'
        WHEN LTRIM(RTRIM([State Name])) = 'RAJASTHAN'
             AND LTRIM(RTRIM([ State Abbr])) = 'OD'
             AND LTRIM(RTRIM([State Abbr])) = 'RJ'
            THEN 'Rajasthan Exception'
        ELSE 'Other Abbreviation Conflict'
    END
ORDER BY RowCounts DESC;

select 
[State Abbr],
[ State Abbr],
[State Name],
count(*) as rowcounts
from Banking_Data_3
WHERE LTRIM(RTRIM([ State Abbr]))
   <> LTRIM(RTRIM([State Abbr]))
group by 
    
[State Abbr],
[ State Abbr],
[State Name]
order by [State Abbr]

-------------------------------------------------------------

SELECT
    LTRIM(RTRIM([State Name])) AS StateName,
    COUNT(*) AS RowCounts
FROM Banking_Data_3
GROUP BY LTRIM(RTRIM([State Name]))
ORDER BY RowCounts DESC;

-------------------------------------------------------------

SELECT
    COUNT(*) AS TotalRows,
    SUM(CASE WHEN [State Name] IS NULL
             THEN 1 ELSE 0 END) AS NullStateNames,
    SUM(CASE WHEN [State Name] IS NOT NULL
              AND LTRIM(RTRIM([State Name])) = ''
             THEN 1 ELSE 0 END) AS BlankOrWhitespaceStateNames,
    SUM(CASE WHEN LTRIM(RTRIM([State Name])) = 'State Name'
             THEN 1 ELSE 0 END) AS PlaceholderStateNames
FROM Banking_Data_3;

-------------------------------------------------------------

SELECT
    CASE
        WHEN [Tranfer Logic] IS NULL
          OR LTRIM(RTRIM([Tranfer Logic])) = ''
            THEN 'Missing Transfer Logic'
        WHEN LTRIM(RTRIM([Tranfer Logic])) = 'Yes'
            THEN 'Transfer Logic is Yes'
        WHEN LTRIM(RTRIM([Tranfer Logic])) = 'No'
            THEN 'Transfer Logic is No'
        ELSE 'State Name Available'
    END AS TransferLogicCheck,
    COUNT(*) AS RowCounts
FROM Banking_Data_3
WHERE LTRIM(RTRIM([State Name])) = 'State Name'
GROUP BY
    CASE
        WHEN [Tranfer Logic] IS NULL
          OR LTRIM(RTRIM([Tranfer Logic])) = ''
            THEN 'Missing Transfer Logic'
        WHEN LTRIM(RTRIM([Tranfer Logic])) = 'Yes'
            THEN 'Transfer Logic is Yes'
        WHEN LTRIM(RTRIM([Tranfer Logic])) = 'No'
            THEN 'Transfer Logic is No'
        ELSE 'State Name Available'
    END
ORDER BY RowCounts DESC;

-------------------------------------------------------------

SELECT
    LTRIM(RTRIM([Tranfer Logic])) AS Candidate_State,
    LTRIM(RTRIM([ State Abbr])) AS State_Abbr_1,
    LTRIM(RTRIM([State Abbr])) AS State_Abbr_2,
    LTRIM(RTRIM([Region Name])) AS Region_Name,
    COUNT(*) AS RowCounts
FROM Banking_Data_3
WHERE LTRIM(RTRIM([State Name])) = 'State Name'
GROUP BY
    LTRIM(RTRIM([Tranfer Logic])),
    LTRIM(RTRIM([ State Abbr])),
    LTRIM(RTRIM([State Abbr])),
    LTRIM(RTRIM([Region Name]))
ORDER BY RowCounts DESC;

-------------------------------------------------------------

SELECT
    LTRIM(RTRIM([Tranfer Logic])) AS Candidate_State,
    LTRIM(RTRIM([ State Abbr])) AS State_Abbr_1,
    LTRIM(RTRIM([State Abbr])) AS State_Abbr_2,
    LTRIM(RTRIM([Region Name])) AS Region_Name,
    LTRIM(RTRIM([Branch Name])) AS Branch_Name,
    COUNT(*) AS RowCounts
FROM Banking_Data_3
WHERE
    LTRIM(RTRIM([ State Abbr]))
        <> LTRIM(RTRIM([State Abbr]))
GROUP BY
    LTRIM(RTRIM([Tranfer Logic])),
    LTRIM(RTRIM([ State Abbr])),
    LTRIM(RTRIM([State Abbr])),
    LTRIM(RTRIM([Region Name])),
    LTRIM(RTRIM([Branch Name]))
ORDER BY RowCounts DESC;

-------------------------------------------------------------

SELECT
    [Client ID],
    [Account ID],
    [ State Abbr],
    [State Abbr],
    [State Name],
    [Tranfer Logic],
    [Region Name],
    [Branch Name],
    [Product Code],
    [Loan Status],
    [Disbursement Date]
FROM Banking_Data_3
WHERE
    LTRIM(RTRIM([ State Abbr])) = 'RJ'
    AND LTRIM(RTRIM([State Abbr])) = 'OR'
    AND LTRIM(RTRIM([Region Name])) = 'BHUBANESWAR'
    AND LTRIM(RTRIM([Branch Name])) = 'JAJPUR'

ORDER BY
    [State Name],
    [Tranfer Logic],
    [Product Code],
    [Disbursement Date];

-------------------------------------------------------------

SELECT [ State Abbr],
    [State Abbr],
    [State Name],
    [Tranfer Logic],
    [Region Name],
    COUNT(*) AS ROWCOUNTS
FROM Banking_Data_3
WHERE [Tranfer Logic] = 'BIHAR' 
GROUP BY [ State Abbr],
    [State Abbr],
    [State Name],
    [Tranfer Logic],
    [Region Name]

-------------------------------------------------------------

SELECT
    [Tranfer Logic],
    COUNT(*) AS RecordCount,
    COUNT(DISTINCT [State Name]) AS DistinctStateNames,
    COUNT(DISTINCT [Region Name]) AS DistinctRegions,
    COUNT(DISTINCT [Branch Name]) AS DistinctBranches
FROM Banking_Data_3
GROUP BY [Tranfer Logic]
ORDER BY RecordCount DESC;

-------------------------------------------------------------

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
    [Region Name],
    [Branch Name],
    COUNT(*) AS Record_Count
FROM StateReference
WHERE
    UPPER(LTRIM(RTRIM([Branch Name]))) IN
        ('KOTWA', 'JAJPUR', 'DEOGARH')
GROUP BY
    Derived_State_Name,
    [ State Abbr],
    [State Abbr],
    [Region Name],
    [Branch Name]
ORDER BY
    [Branch Name],
    Record_Count DESC;

-------------------------------------------------------------

select 
    YEAR([Disbursement Date]) as Disbursement_year,
    MONTH([Disbursement Date]) as Disbursement_month
from Banking_Data_3
group by YEAR([Disbursement Date]) ,MONTH([Disbursement Date])
order by YEAR([Disbursement Date]) ,MONTH([Disbursement Date])
