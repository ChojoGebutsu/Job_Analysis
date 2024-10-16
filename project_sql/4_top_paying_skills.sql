/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries with location in Serbia
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/

SELECT 
    sd.skills,
    ROUND(AVG(jpf.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact AS jpf
JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Analyst' AND
    jpf.job_location LIKE '%Serbia%' AND
    jpf.salary_year_avg IS NOT NULL
GROUP BY
    sd.skills
ORDER BY
    avg_salary DESC;

/*
Here are some insights:
- SSIS leads with the highest average salary, followed closely by Power BI and Go.
- The difference between the top skills (SSIS, Power BI) and the next level (SQL, C#, Python) is significant, with a clear salary drop after the top three.
- SQL, C#, and Python are popular but fall into a mid-tier salary range compared to specialized skills like SSIS.

[
  {
    "skills": "ssis",
    "avg_salary": "105000"
  },
  {
    "skills": "power bi",
    "avg_salary": "103750"
  },
  {
    "skills": "go",
    "avg_salary": "102500"
  },
  {
    "skills": "sql",
    "avg_salary": "86838"
  },
  {
    "skills": "c#",
    "avg_salary": "79007"
  },
  {
    "skills": "python",
    "avg_salary": "79007"
  },
  {
    "skills": "excel",
    "avg_salary": "77757"
  },
  {
    "skills": "oracle",
    "avg_salary": "56700"
  },
  {
    "skills": "tableau",
    "avg_salary": "53014"
  },
  {
    "skills": "r",
    "avg_salary": "53014"
  },
  {
    "skills": "sas",
    "avg_salary": "53014"
  },
  {
    "skills": "spss",
    "avg_salary": "53014"
  }
]


*/
