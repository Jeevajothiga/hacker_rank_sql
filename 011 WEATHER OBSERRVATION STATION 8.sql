---Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION
WHERE UPPER(LEFT(CITY, 1)) IN ('A', 'E', 'I', 'O', 'U')
  AND UPPER(RIGHT(CITY, 1)) IN ('A', 'E', 'I', 'O', 'U');
