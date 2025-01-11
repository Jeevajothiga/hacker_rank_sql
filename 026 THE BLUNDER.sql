---Samantha calculated the average salary but didn't notice her keyboard's '0' key was broken. This caused zeros to be removed from the salaries before calculating the average.

---Your task: Write a query to find the difference between the correct average salary and Samantha's miscalculated average (with zeros removed), and round it up to the next integer.
SELECT 
  CEIL(AVG(salary) - AVG(CAST(REPLACE(salary, '0', '') AS DECIMAL))) AS error
FROM employees
