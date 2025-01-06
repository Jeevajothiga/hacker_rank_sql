--P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):

* 
* * 
* * * 
* * * * 
* * * * *
--Write a query to print the pattern P(20).


WITH RECURSIVE recursive_cte AS (
    SELECT 1 AS RowNumber -- Base case: Start with 1
    UNION ALL
    SELECT RowNumber + 1 -- Recursive step: Add 1 to the previous value
    FROM recursive_cte
    WHERE RowNumber < 20 -- Stop when RowNumber is 20
)
SELECT REPEAT('* ', RowNumber) AS PatternRow -- Print 'RowNumber' number of stars
FROM recursive_cte;
