use PortfolioProject;

SELECT
	Case
		when [Grrade] is null and [Sub Grade] is null
			then 'grade_missing'
		else 'grade_present' 
	end as grade_Status ,
    [Loan Status],
    [Disbursement Date],
    [Closed Date],

    CASE
        WHEN [Closed Date] IS NULL
          OR [Closed Date] = '1900-01-01'
          OR [Closed Date] < [Disbursement Date]
        THEN NULL
        ELSE DATEDIFF(
            day,
            [Disbursement Date],
            [Closed Date]
        )
    END AS Loan_Lifecycle_Days,

    CASE
        WHEN [Closed Date] IS NULL
          OR [Closed Date] = '1900-01-01'
          OR [Closed Date] < [Disbursement Date]
        THEN NULL
        ELSE DATEDIFF(
            month,
            [Disbursement Date],
            [Closed Date]
        )
    END AS Loan_Lifecycle_Months

FROM Banking_Data_3
where 
    [Closed Date] is not Null and 
    [Closed Date]<> '1900-01-01'and
    [Closed Date]>= [Disbursement Date]
ORDER BY
   CASE
        WHEN [Closed Date] IS NULL
          OR [Closed Date] = '1900-01-01'
          OR [Closed Date] < [Disbursement Date]
        THEN NULL
        ELSE DATEDIFF(
            month,
            [Disbursement Date],
            [Closed Date]
        )
    END desc;

------------------------------------------------------

select 
    [Purpose Category],
    count(*) as total_record,
    sum(case 
        when Grrade is null and [Sub Grade] is null 
            then 1
        else 0 
    end) as grade_missing,
    sum(case 
        when Grrade is not null and [Sub Grade] is not null 
            then 1
        else 0 
    end) as grade_present,
    cast(
        100.0 * sum(
                    case 
                        when Grrade is null and [Sub Grade] is null
                            then 1
                        else 0 
                end )/count(*) as decimal(10,2)
        ) grade_missing_rate
from Banking_Data_3
group by [Purpose Category]
order by [Purpose Category];
--------------------------------------------------------


SELECT
    CASE
        WHEN [Closed Date] IS NULL
            THEN 'NULL'
        WHEN [Closed Date] = '1900-01-01'
            THEN '1900 Placeholder'
        ELSE 'Valid Date'
    END AS Closed_Date_Status,

    [Loan Status],

    COUNT(*) AS Total_Records,

    SUM(
        CASE
            WHEN [Grrade] IS NULL
             AND [Sub Grade] IS NULL
            THEN 1
            ELSE 0
        END
    ) AS Missing_Grade,
    CAST(
        100.0 *
        SUM(
            CASE
                WHEN [Grrade] IS NULL
                 AND [Sub Grade] IS NULL
                THEN 1
                ELSE 0
            END
        ) / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Missing_Grade_Rate,

    min([Disbursement Date]) as min_Disbursement_Date,
    max([Disbursement Date]) as max_Disbursement_Date,

    min([Closed Date]) as min_Closed_Date,
    max([Closed Date]) as max_Closed_date
FROM Banking_Data_3
GROUP BY
    CASE
        WHEN [Closed Date] IS NULL
            THEN 'NULL'
        WHEN [Closed Date] = '1900-01-01'
            THEN '1900 Placeholder'
        ELSE 'Valid Date'
    END,
    [Loan Status]
ORDER BY Closed_Date_Status,
        [Loan Status];
-------------------------------------------------------------
SELECT
    [Closed Date],
    [Disbursement Date]
FROM Banking_Data_3
WHERE [Closed Date] <> '1900-01-01'
  AND [Closed Date] < [Disbursement Date];

  -----------------------------------------------------------
SELECT
	Case
		when [Grrade] is null and [Sub Grade] is null
			then 'grade_missing'
		else 'grade_present' 
	end as grade_Status ,
    [Loan Status],
    [Disbursement Date],
    [Closed Date],

    CASE
        WHEN [Closed Date] IS NULL
          OR [Closed Date] = '1900-01-01'
          OR [Closed Date] < [Disbursement Date]
        THEN NULL
        ELSE DATEDIFF(
            day,
            [Disbursement Date],
            [Closed Date]
        )
    END AS Loan_Lifecycle_Days,

    CASE
        WHEN [Closed Date] IS NULL
          OR [Closed Date] = '1900-01-01'
          OR [Closed Date] < [Disbursement Date]
        THEN NULL
        ELSE DATEDIFF(
            month,
            [Disbursement Date],
            [Closed Date]
        )
    END AS Loan_Lifecycle_Months

FROM Banking_Data_3
ORDER BY
    [Disbursement Date],
    [Closed Date];
---------------------------------------------------------

select 
    YEAR([Disbursement Date]) as year,
    month([Disbursement Date]) as months,
    [Loan Status],
    case
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 0 and 6 then '0-6 months'
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 7 and 12 then '7-12 months'
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 13 and 18 then '13-18 months'
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 19 and 24 then '19-24 months'
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 25 and 30 then '25-30 months'
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 31 and 36 then '31-36 months'
        else '37+ month'
    end as loan_lifecycle_months,

    count(*) as total_record,

    sum (
        case
            when Grrade is null and [Sub Grade] is null 
                then 1 
            else 0
        end
        ) as grade_missing,

     sum (
        case
            when Grrade is not null and [Sub Grade] is not null 
                then 1 
            else 0
        end
        ) as grade_present,

    CAST(
        100.0 *  sum (
        case
            when Grrade is null and [Sub Grade] is null 
                then 1 
            else 0
        end
        )/ count(*) as decimal(10,2)
        ) as grade_missing_rate
from 
    Banking_Data_3
where 
    [Loan Status] = 'Active Loan' and
    [Closed Date] is not Null and 
    [Closed Date]<> '1900-01-01'and
    [Closed Date]>= [Disbursement Date]
group by 
    YEAR([Disbursement Date]),
    month([Disbursement Date]),
    [Loan Status],
    case
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 0 and 6 then '0-6 months'
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 7 and 12 then '7-12 months'
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 13 and 18 then '13-18 months'
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 19 and 24 then '19-24 months'
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 25 and 30 then '25-30 months'
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 31 and 36 then '31-36 months'
        else '37+ month'
    end
order by 
    YEAR([Disbursement Date]),
    month([Disbursement Date]),
    CASE
        WHEN MIN(DATEDIFF(month, [Disbursement Date], [Closed Date])) BETWEEN 0 AND 6 THEN 1
        WHEN MIN(DATEDIFF(month, [Disbursement Date], [Closed Date])) BETWEEN 7 AND 12 THEN 2
        WHEN MIN(DATEDIFF(month, [Disbursement Date], [Closed Date])) BETWEEN 13 AND 18 THEN 3
        WHEN MIN(DATEDIFF(month, [Disbursement Date], [Closed Date])) BETWEEN 19 AND 24 THEN 4
        WHEN MIN(DATEDIFF(month, [Disbursement Date], [Closed Date])) BETWEEN 25 AND 30 THEN 5
        WHEN MIN(DATEDIFF(month, [Disbursement Date], [Closed Date])) BETWEEN 31 AND 36 THEN 6
        ELSE 7
    end;
--------------------------------------------------------


select 
    YEAR([Disbursement Date]) as year,
    [Product Code],
    case
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 0 and 6 then '0-6 months'
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 7 and 12 then '7-12 months'
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 13 and 18 then '13-18 months'
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 19 and 24 then '19-24 months'
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 25 and 30 then '25-30 months'
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 31 and 36 then '31-36 months'
        else '37+ month'
    end as loan_lifecycle_months,

    count(*) as total_record,

    sum (
        case
            when Grrade is null and [Sub Grade] is null 
                then 1 
            else 0
        end
        ) as grade_missing,

     sum (
        case
            when Grrade is not null and [Sub Grade] is not null 
                then 1 
            else 0
        end
        ) as grade_present,

    CAST(
        100.0 *  sum (
        case
            when Grrade is null and [Sub Grade] is null 
                then 1 
            else 0
        end
        )/ count(*) as decimal(10,2)
        ) as grade_missing_rate
from 
    Banking_Data_3
where
    
    [Loan Status] = 'Active Loan' and
    [Closed Date] is not Null and 
    [Closed Date]<> '1900-01-01'and
    [Closed Date]>= [Disbursement Date]
group by 
    YEAR([Disbursement Date]),
    [Product Code],
    case
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 0 and 6 then '0-6 months'
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 7 and 12 then '7-12 months'
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 13 and 18 then '13-18 months'
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 19 and 24 then '19-24 months'
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 25 and 30 then '25-30 months'
        when DATEDIFF(Month, [Disbursement Date],[Closed Date]) between 31 and 36 then '31-36 months'
        else '37+ month'
    end
order by 
    YEAR([Disbursement Date]),
    [Product Code],
    CASE
        WHEN MIN(DATEDIFF(month, [Disbursement Date], [Closed Date])) BETWEEN 0 AND 6 THEN 1
        WHEN MIN(DATEDIFF(month, [Disbursement Date], [Closed Date])) BETWEEN 7 AND 12 THEN 2
        WHEN MIN(DATEDIFF(month, [Disbursement Date], [Closed Date])) BETWEEN 13 AND 18 THEN 3
        WHEN MIN(DATEDIFF(month, [Disbursement Date], [Closed Date])) BETWEEN 19 AND 24 THEN 4
        WHEN MIN(DATEDIFF(month, [Disbursement Date], [Closed Date])) BETWEEN 25 AND 30 THEN 5
        WHEN MIN(DATEDIFF(month, [Disbursement Date], [Closed Date])) BETWEEN 31 AND 36 THEN 6
        ELSE 7
    end;

    -----------------------------------------------------

select 
    [Loan Status],
    [Closed Date],
    [Close Client]
from 
    Banking_Data_3
where 
    [Closed Date] <> 1900-01-01 and 
    [Closed Date] is not Null and 
    [Closed Date]<> '1900-01-01'and
    [Closed Date]>= [Disbursement Date]
--group by
--    [Loan Status],
--    [Close Client]
order by 
    [Loan Status],
    [Close Client];
 ----------------------------------------------------------------------------------------
 
 select 
    YEAR([Disbursement Date]) as 'Year',
    [Close Client],
    COUNT(*) as total_record,
        CASE
            when Grrade is not null and [Sub Grade] is not null then 'Grade Present' else 'Grade absent' 
        end as Grade_availability,
    SUM(
        CASE
            when Grrade is not null and [Sub Grade] is not null then 1 else 0 end 
        ) as Grade_availability_count
from Banking_Data_3
where 
    [Closed Date] <> 1900-01-01 and 
    [Closed Date] is not Null and 
    [Closed Date]<> '1900-01-01'and
    [Closed Date]>= [Disbursement Date]
    
group by 
    [Close Client],
    YEAR([Disbursement Date]),
    CASE
            when Grrade is not null and [Sub Grade] is not null then 'Grade Present' else 'Grade absent' end ,
    CASE
            when Grrade is not null and [Sub Grade] is not null then 1 else 0 end 
order by 
    YEAR([Disbursement Date]),
    [Close Client];

select * from Banking_Data_3 where 
    [Closed Date] <> 1900-01-01 and 
    [Closed Date] is not Null and 
    [Closed Date]<> '1900-01-01'and
    [Closed Date]>= [Disbursement Date];

----------------------------------------------------------------------------------------------

SELECT 
    YEAR([Disbursement Date]) AS [Year],
    MONTH([Disbursement Date]) AS Month_Number,
    DATENAME(MONTH, [Disbursement Date]) AS [Month],
    [Close Client],

    COUNT(*) AS Total_Records,

    SUM(
        CASE
            WHEN [Grrade] IS NOT NULL
             AND [Sub Grade] IS NOT NULL
            THEN 1
            ELSE 0
        END
    ) AS Grade_Available,

    SUM(
        CASE
            WHEN [Grrade] IS NULL
             AND [Sub Grade] IS NULL
            THEN 1
            ELSE 0
        END
    ) AS Grade_Missing,

    CAST(
        100.0 *
        SUM(
            CASE
                WHEN [Grrade] IS NULL
                 AND [Sub Grade] IS NULL
                THEN 1
                ELSE 0
            END
        ) / COUNT(*)
        AS DECIMAL(10,2)
    ) AS Grade_Missing_Rate

FROM Banking_Data_3

WHERE
    [Closed Date] IS NOT NULL
    AND [Closed Date] <> '1900-01-01'
    AND [Closed Date] >= [Disbursement Date]

GROUP BY
    YEAR([Disbursement Date]),
    MONTH([Disbursement Date]),
    DATENAME(MONTH, [Disbursement Date]),
    [Close Client]

ORDER BY
    YEAR([Disbursement Date]),
    MONTH([Disbursement Date]),
    [Close Client];