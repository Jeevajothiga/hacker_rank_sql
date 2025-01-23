Samantha interviews many candidates from different colleges using coding challenges and contests. Write a query to print the contest_id, hacker_id, name, and the sums of total_submissions, total_accepted_submissions, total_views, and total_unique_views for each contest sorted by contest_id. Exclude the contest from the result if all four sums are .

Note: A specific contest can be used to screen candidates at more than one college, but each college only holds  screening contest.

Input Format

The following tables hold interview data:

Contests: The contest_id is the id of the contest, hacker_id is the id of the hacker who created the contest, and name is the name of the hacker.

Colleges: The college_id is the id of the college, and contest_id is the id of the contest that Samantha used to screen the candidates.

Challenges: The challenge_id is the id of the challenge that belongs to one of the contests whose contest_id Samantha forgot, and college_id is the id of the college where the challenge was given to candidates.

View_Stats: The challenge_id is the id of the challenge, total_views is the number of times the challenge was viewed by candidates, and total_unique_views is the number of times the challenge was viewed by unique candidates.

Submission_Stats: The challenge_id is the id of the challenge, total_submissions is the number of submissions for the challenge, and total_accepted_submission is the number of submissions that achieved full scores.

SELECT C.contest_id, C.hacker_id, C.name, SUM(TS),SUM(TA),SUM(TV), SUM(TU)
FROM Contests AS C
JOIN Colleges CO ON C.contest_id=CO.contest_id
JOIN Challenges CH ON CO.college_id=CH.college_id
LEFT JOIN (
SELECT 
challenge_id, SUM(total_views) AS TV, 
SUM( total_unique_views) AS TU
FROM View_Stats
GROUP BY challenge_id 
) V
            ON CH.challenge_id=V.challenge_id
LEFT JOIN (
SELECT 
challenge_id, SUM( total_submissions) AS TS, 
SUM( total_accepted_submissions) AS TA
FROM Submission_Stats
GROUP BY challenge_id 
)  S
            ON CH.challenge_id=S.challenge_id
GROUP BY C.contest_id, C.hacker_id, C.name
HAVING
SUM( TS)+SUM(TA)+SUM(TV)+ SUM(TU) >0
ORDER BY C.contest_id;
