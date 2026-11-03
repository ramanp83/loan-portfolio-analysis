use PortfolioProject;

 -- Check the current table's row count
SELECT
    COUNT_BIG(*) AS Total_Rows
FROM Banking_Data_3;

-------------------------------------------------------------

-- check whether the table contains duplicate combinations of Account ID and Client id:
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
