/*
Question: What skills are required for the top-paying data analyst jobs in Serbia?
- Use the top highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS (
    SELECT
        jpf.job_id,
        cd.name As company_name,
        jpf.job_title,
        jpf.job_location,
        jpf.salary_year_avg
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
)

SELECT 
    top_paying_jobs.*,
    sd.skills
FROM top_paying_jobs
JOIN skills_job_dim AS sjd ON
    top_paying_jobs.job_id = sjd.job_id
JOIN skills_dim AS sd ON
    sjd.skill_id = sd.skill_id
ORDER BY 
    salary_year_avg DESC;

/*
Here are the top five skills found in the dataset, based on frequency:
- SQL appears 3 times.
- Python appears 2 times.
- C# appears 2 times.
- Power BI appears 2 times.
- Excel appears 2 times.

[
  {
    "job_id": 337688,
    "company_name": "Bosch Group",
    "job_title": "Medior Data Analyst",
    "job_location": "Belgrade, Serbia",
    "salary_year_avg": "105000.0",
    "skills": "sql"
  },
  {
    "job_id": 337688,
    "company_name": "Bosch Group",
    "job_title": "Medior Data Analyst",
    "job_location": "Belgrade, Serbia",
    "salary_year_avg": "105000.0",
    "skills": "python"
  },
  {
    "job_id": 337688,
    "company_name": "Bosch Group",
    "job_title": "Medior Data Analyst",
    "job_location": "Belgrade, Serbia",
    "salary_year_avg": "105000.0",
    "skills": "c#"
  },
  {
    "job_id": 337688,
    "company_name": "Bosch Group",
    "job_title": "Medior Data Analyst",
    "job_location": "Belgrade, Serbia",
    "salary_year_avg": "105000.0",
    "skills": "power bi"
  },
  {
    "job_id": 337688,
    "company_name": "Bosch Group",
    "job_title": "Medior Data Analyst",
    "job_location": "Belgrade, Serbia",
    "salary_year_avg": "105000.0",
    "skills": "ssis"
  },
  {
    "job_id": 470330,
    "company_name": "Bosch Group",
    "job_title": "Sustainability Data Analyst",
    "job_location": "Belgrade, Serbia",
    "salary_year_avg": "102500.0",
    "skills": "sql"
  },
  {
    "job_id": 470330,
    "company_name": "Bosch Group",
    "job_title": "Sustainability Data Analyst",
    "job_location": "Belgrade, Serbia",
    "salary_year_avg": "102500.0",
    "skills": "go"
  },
  {
    "job_id": 470330,
    "company_name": "Bosch Group",
    "job_title": "Sustainability Data Analyst",
    "job_location": "Belgrade, Serbia",
    "salary_year_avg": "102500.0",
    "skills": "excel"
  },
  {
    "job_id": 470330,
    "company_name": "Bosch Group",
    "job_title": "Sustainability Data Analyst",
    "job_location": "Belgrade, Serbia",
    "salary_year_avg": "102500.0",
    "skills": "power bi"
  },
  {
    "job_id": 407256,
    "company_name": "PSI CRO",
    "job_title": "Clinical Data Manager",
    "job_location": "Belgrade, Serbia",
    "salary_year_avg": "56700.0",
    "skills": "oracle"
  },
  {
    "job_id": 762562,
    "company_name": "Telesign",
    "job_title": "Data Analyst",
    "job_location": "Belgrade, Serbia",
    "salary_year_avg": "53014.0",
    "skills": "sql"
  },
  {
    "job_id": 762562,
    "company_name": "Telesign",
    "job_title": "Data Analyst",
    "job_location": "Belgrade, Serbia",
    "salary_year_avg": "53014.0",
    "skills": "python"
  },
  {
    "job_id": 762562,
    "company_name": "Telesign",
    "job_title": "Data Analyst",
    "job_location": "Belgrade, Serbia",
    "salary_year_avg": "53014.0",
    "skills": "r"
  },
  {
    "job_id": 762562,
    "company_name": "Telesign",
    "job_title": "Data Analyst",
    "job_location": "Belgrade, Serbia",
    "salary_year_avg": "53014.0",
    "skills": "sas"
  },
  {
    "job_id": 762562,
    "company_name": "Telesign",
    "job_title": "Data Analyst",
    "job_location": "Belgrade, Serbia",
    "salary_year_avg": "53014.0",
    "skills": "c#"
  },
  {
    "job_id": 762562,
    "company_name": "Telesign",
    "job_title": "Data Analyst",
    "job_location": "Belgrade, Serbia",
    "salary_year_avg": "53014.0",
    "skills": "excel"
  },
  {
    "job_id": 762562,
    "company_name": "Telesign",
    "job_title": "Data Analyst",
    "job_location": "Belgrade, Serbia",
    "salary_year_avg": "53014.0",
    "skills": "tableau"
  },
  {
    "job_id": 762562,
    "company_name": "Telesign",
    "job_title": "Data Analyst",
    "job_location": "Belgrade, Serbia",
    "salary_year_avg": "53014.0",
    "skills": "sas"
  },
  {
    "job_id": 762562,
    "company_name": "Telesign",
    "job_title": "Data Analyst",
    "job_location": "Belgrade, Serbia",
    "salary_year_avg": "53014.0",
    "skills": "spss"
  }
]

*/