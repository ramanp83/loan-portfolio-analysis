use PortfolioProject;
SELECT
    CASE
        WHEN [Funded Amount] < 5000 THEN '< 5K'
        WHEN [Funded Amount] < 10000 THEN '5K - <10K'
        WHEN [Funded Amount] < 15000 THEN '10K - <15K'
        WHEN [Funded Amount] < 20000 THEN '15K - <20K'
        WHEN [Funded Amount] < 25000 THEN '20K - <25K'
        WHEN [Funded Amount] < 30000 THEN '25K - <30K'
        ELSE '30K+'
    END AS Funded_Amount_Band,
    COUNT(*) AS Record_Count,
    AVG([Funded Amount]) AS Avg__Amount,
    MIN([Funded Amount]) AS Min_Funded_Amount,
    MAX([Funded Amount]) AS Max_Funded_Amount
FROM Banking_Data_3
GROUP BY
    CASE
        WHEN [Funded Amount] < 5000 THEN '< 5K'
        WHEN [Funded Amount] < 10000 THEN '5K - <10K'
        WHEN [Funded Amount] < 15000 THEN '10K - <15K'
        WHEN [Funded Amount] < 20000 THEN '15K - <20K'
        WHEN [Funded Amount] < 25000 THEN '20K - <25K'
        WHEN [Funded Amount] < 30000 THEN '25K - <30K'
        ELSE '30K+'
    END
ORDER BY
    MIN([Funded Amount]);