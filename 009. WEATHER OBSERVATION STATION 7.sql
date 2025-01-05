--Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION
WHERE UPPER(CITY) LIKE '%A'
   OR UPPER(CITY) LIKE '%E'
   OR UPPER(CITY) LIKE '%I'
   OR UPPER(CITY) LIKE '%O'
   OR UPPER(CITY) LIKE '%U';
