/*
Question: What are the most in-demand skills for Data Analysts in Serbia?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings in Serbia.
- Why? Retrieves the top skills with the highest demand in the job market in Serbia, 
    providing insights into the most valuable skills for job seekers.
*/

SELECT 
    sd.skills,
    COUNT(sjd.job_id) AS demand_count
FROM job_postings_fact AS jpf
JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Analyst' AND
    jpf.job_location LIKE '%Serbia%'
GROUP BY
    sd.skills
ORDER BY
    demand_count DESC
LIMIT 5;