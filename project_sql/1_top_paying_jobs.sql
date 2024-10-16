/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available in Serbia.
- Identify the companies that posted these job offers.
- Focus is on the job postings with specified salaries (without NULLs).
- Why? Highlight the top-paying opportunities for Data Analysts in Serbia, offering insights into employment options and location.
*/

SELECT
    jpf.job_id,
    cd.name As company_name,
    jpf.job_title,
    jpf.job_location,
    jpf.job_schedule_type,
    jpf.salary_year_avg,
    jpf.job_posted_date
FROM
    job_postings_fact AS jpf
JOIN
    company_dim AS cd ON 
    jpf.company_id = cd.company_id
WHERE
    jpf.job_title_short = 'Data Analyst' AND
    jpf.job_location ILIKE '%Serbia%' AND
    jpf.salary_year_avg IS NOT NULL
ORDER BY
    jpf.salary_year_avg DESC
LIMIT 10;