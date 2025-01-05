---Query a list of CITY and STATE from the STATION table.
----where LAT_N is the northern latitude and LONG_W is the western longitude. 
--here is that catch since parameters for LAT_N AND LONG_W is not provided we dont need to consider them 
SELECT CITY, STATE
FROM STATION;
