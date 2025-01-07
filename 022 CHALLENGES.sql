/*
#Problem: Count of Challenges Created by Hackers

## Problem Description

Julia asked her students to create some coding challenges. You are tasked with writing a query to print the `hacker_id`, `name`, and the total number of challenges created by each student. The output should be sorted in descending order by the total number of challenges. 

If more than one student created the same number of challenges, then sort the result by `hacker_id`. Moreover, if more than one student created the same number of challenges and the count is less than the maximum number of challenges created, exclude those students from the result.

### Input Tables

#### Hackers
| hacker_id | name  |
|-----------|-------|
| 5120      | Julia |
| 18425     | Anna |
| 20023     | Brian |
| 33625     | Jason |
| 41805     | Benjamin |
| 52462     | Nicholas |
| 64036     | Craig |
| 69471     | Michelle |
| 77173     | Mildred |
| 94278     | Dennis |

#### Challenges
| challenge_id | hacker_id |
|--------------|-----------|
| 1            | 5120      |
| 2            | 5120      |
| 3            | 5120      |
| 4            | 5120      |
| 5            | 18425     |
| 6            | 18425     |
| 7            | 18425     |
| 8            | 18425     |
| 9            | 18425     |
| 10           | 20023     |

### Sample Output

| hacker_id | name     | challenges_created |
|-----------|----------|--------------------|
| 5120      | Julia    | 50                 |
| 18425     | Anna     | 50                 |
| 20023     | Brian    | 50                 |
| 33625     | Jason    | 50                 |
| 41805     | Benjamin | 50                 |
| 52462     | Nicholas | 50                 |
| 64036     | Craig    | 50                 |
| 69471     | Michelle | 50                 |
| 77173     | Mildred  | 50                 |
| 94278     | Dennis   | 50                 |

*/

WITH ChallengeCounts AS (
    SELECT H.hacker_id, H.name, COUNT(C.challenge_id) AS challenge_count
    FROM hackers AS H
    INNER JOIN Challenges AS C ON H.hacker_id = C.hacker_id
    GROUP BY H.hacker_id, H.name
)
SELECT hacker_id,
       name,
       challenge_count
FROM ChallengeCounts
WHERE challenge_count = (SELECT MAX(challenge_count) FROM ChallengeCounts)
   OR challenge_count IN (
        SELECT challenge_count
        FROM ChallengeCounts
        GROUP BY challenge_count
        HAVING COUNT(challenge_count) = 1)
ORDER BY challenge_count DESC, hacker_id;


### Explanation

1. **Common Table Expression (CTE) - ChallengeCounts**:
    - This section calculates the number of challenges created by each hacker.
    - We join the `hackers` table with the `challenges` table on `hacker_id` to get the total number of challenges created by each hacker.
    - The `GROUP BY` clause groups the data by `hacker_id` and `name`, ensuring we have a row for each hacker.

2. **WHERE Clause - Filtering**:
    - We want to filter out the hackers who have created the most challenges and hackers who created a unique number of challenges (less than the maximum).
    - The first condition **`challenge_count = (SELECT MAX(challenge_count) FROM ChallengeCounts)`** ensures that we select hackers who created the maximum number of challenges.
    - The second condition **`challenge_count IN (...)`** ensures that we select hackers who created a unique number of challenges, excluding those whose counts are the same and less than the maximum.

3. **ORDER BY Clause - Sorting**:
    - **`ORDER BY challenge_count DESC, hacker_id`** ensures the results are sorted by the number of challenges in descending order.
    - If there are ties (multiple hackers created the same number of challenges), we sort by `hacker_id` in ascending order.

### Additional Notes

- **CTE (Common Table Expression)** is used to store the intermediate data that calculates the challenge counts for each hacker, which is then used in the main query.
- The **`MAX(challenge_count)`** subquery identifies the hacker(s) who created the most challenges.
- The **`HAVING COUNT(challenge_count) = 1`** part of the query ensures that only hackers who created a unique number of challenges (less than the maximum) are included.

---

Feel free to copy this into your GitHub repository!
