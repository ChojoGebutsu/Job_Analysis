WITH q1 AS ( 
    SELECT
        q1_jps.job_id,
        q1_jps.salary_year_avg
    FROM (
        SELECT *
        FROM january_jobs
        UNION ALL
        SELECT *
        FROM february_jobs
        UNION ALL
        SELECT *
        FROM march_jobs
        ) as q1_jps
    WHERE
        q1_jps.job_title_short = 'Data Analyst' AND
        q1_jps.salary_year_avg > 70000
), aa AS (
    SELECT
        sjd.job_id,
        sd.skill_id,
        sd.skills,
        sd.type
    FROM
        skills_job_dim AS sjd
    JOIN
        skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
)

SELECT 
    q1.job_id,
    aa.skills AS name,
    aa.type,
    q1.salary_year_avg AS salary
FROM q1
JOIN aa
ON q1.job_id = aa.job_id;
