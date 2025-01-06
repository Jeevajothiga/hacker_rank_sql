/*Problem:
You have two tables: Students and Grades.

The Students table contains three columns:

ID (Student ID)
Name (Student's Name)
Marks (Student's Marks)
The Grades table contains the following columns:

min_mark (minimum mark required for a grade)
max_mark (maximum mark for that grade)
Your task is to generate a report containing three columns: Name, Grade, and Marks. Follow these requirements:

If a student's grade is greater than or equal to 8, show their Name in the report.
If a student's grade is lower than 8, show NULL as their Name.
The report should be ordered by the Grade (in descending order, higher grades first).
If there are multiple students with the same grade (8-10), order them alphabetically by their Name.
If a student's grade is lower than 8, list them by their marks (ascending order).
Sample Input:
Students Table:
ID	Name	Marks
1	Maria	90
2	Jane	80
3	Julia	85
4	Scarlet	75
Grades Table:
min_mark	max_mark
1	7
8	10
Sample Output:
Name	Grade	Marks
Maria	10	90
Julia	9	85
Jane	8	80
NULL	7	75
Explanation:
Maria has a grade of 10 and is shown with her name.
Julia has a grade of 9 and is shown with her name.
Jane has a grade of 8 and is shown with her name.
Scarlet has a grade of 7 and is shown as NULL because her grade is below 8.
Your Goal:
Write a SQL query to generate the report as described above.*/
SELECT
    CASE
        WHEN g.grade < 8 THEN NULL
        ELSE s.name
    END AS student_name,
    g.grade,
    s.marks
FROM students s
JOIN
    grades g
ON
    s.marks BETWEEN g.min_mark AND g.max_mark
ORDER BY
    g.grade DESC,
    CASE
        WHEN g.grade >= 8 THEN s.name
        ELSE s.marks
    END ASC;
