The task is to find the total number of unique hackers who made at least one submission each day during a contest (March 1, 2016, to March 15, 2016), and for each day, identify the hacker who made the maximum number of submissions. If more than one hacker has the maximum submissions, select the one with the lowest `hacker_id`. The results should be sorted by date.

### Output Requirements:
- For each day of the contest:
  1. The date.
  2. The count of unique hackers who made submissions.
  3. The hacker ID and name of the hacker who made the maximum submissions.

### Tables:
- `Hackers` (with `hacker_id` and `name`).
- `Submissions` (with `submission_id`, `submission_date`, `hacker_id`, and `score`).


SELECT S.s_d,
       SH.h_cnt,
       SMH.min_h_id,
       H.NAME
FROM   (SELECT submission_date AS s_d
        FROM   submissions
        GROUP  BY submission_date
        ORDER  BY submission_date) S
       INNER JOIN (SELECT submission_date,
                          Max(score)                   AS max_score,
                          Count(DISTINCT SA.hacker_id) AS h_cnt
                   FROM   (SELECT submission_date,
                                  hacker_id,
                                  Count(submission_id) AS score
                           FROM   submissions
                           GROUP  BY submission_date,
                                     hacker_id) SA
                          INNER JOIN (SELECT sd,
                                             sr.hacker_id
                                      FROM   (SELECT s.submission_date
                                                     AS sd,
                                                     s.hacker_id,
                                     Count(DISTINCT s2.submission_date)
                                     AS cnt
                                              FROM   submissions s
                                                     JOIN submissions s2
                                                       ON s.hacker_id =
                                                          s2.hacker_id
                                                          AND s2.submission_date
                                                              <=
                                                              s.submission_date
                                              GROUP  BY s.submission_date,
                                                        hacker_id) sr
                                      WHERE  sd - Cast('2016-03-01' AS DATE) + 1
                                             = cnt)
                                     hsdw2
                                  ON hsdw2.sd = SA.submission_date
                                     AND SA.hacker_id = hsdw2.hacker_id
                   GROUP  BY submission_date) SH
               ON S.s_d = SH.submission_date
       INNER JOIN (SELECT submission_date,
                          Max(score) AS max_score
                   FROM   (SELECT submission_date,
                                  hacker_id,
                                  Count(submission_id) AS score
                           FROM   submissions
                           GROUP  BY submission_date,
                                     hacker_id) SA
                   GROUP  BY submission_date) SM
               ON S.s_d = SM.submission_date
       LEFT JOIN (SELECT submission_date   AS d,
                         score,
                         Min(SG.hacker_id) AS min_h_id
                  FROM   (SELECT submission_date,
                                 S0.hacker_id,
                                 Count(submission_id) AS score
                          FROM   submissions S0
                          GROUP  BY submission_date,
                                    hacker_id) SG
                  GROUP  BY submission_date,
                            score) SMH
              ON S.s_d = SMH.d
                 AND SMH.score = SM.max_score
       LEFT JOIN hackers H
              ON H.hacker_id = SMH.min_h_id
ORDER  BY s_d 
