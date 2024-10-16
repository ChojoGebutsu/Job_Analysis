# Introduction
📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql/).
# Background
Driven by a quest to navigate the data analyst job market in Serbia more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

Data hails from [here](https://lukebarousse.com/sql). It's packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my SQL queries were:
1. What are the top-paying data analyst jobs in Serbia?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts in Serbia?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?


# Tools I Used
I utilized the power of several tools:

- **SQL**: The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL**: The chosen database management system, ideal for handling the job posting data.
- **VS Code**: A go-to for database management and executing SQL queries.
# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market in Serbia. Here’s a breakdown:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location. This query highlights the high paying opportunities in the field.

```sql
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
```
### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
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
```
Here are the top five skills found in the dataset, based on frequency:
- **SQL** appears 3 times.
- **Python** appears 2 times.
- **C#** appears 2 times.
- **Power BI** appears 2 times.
- **Excel** appears 2 times.

![Slika_1](assets\output.png)
*Bar graph visualizing the count of skills for the top paying jobs for data analysts in Serbia

### 3. In-Demand Skills for Data Analysts
This query helped identify the skills most frequently requested in job postings regardless of the salary, directing focus to areas with high demand.

```sql
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
```

- Here is the bar chart showing the demand count for top 5 skills among data analysts in Serbia, regardless of the salary. **SQL** has the highest demand, followed by **Python**, **Tableau**, **Excel**, and **Power BI**. This gives a clear view of which skills are most sought after in the data analytics field.
![Slika_2](assets\output_2.png)
*Bar graph of visualizing the demand for the top 5 skills in data analyst job postings


### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
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
```

Here are the main insights:
- **SSIS** leads with the highest average salary, followed closely by **Power BI** and **Go**.
- The difference between the top skills (**SSIS**, **Power BI**) and the next level (**SQL**, **C#**, **Python**) is significant, with a clear salary drop after the top three.
- **SQL**, **C#**, and **Python** are popular but fall into a mid-tier salary range compared to specialized skills like **SSIS**.





![Slika_3](assets\output_4.png)
*Bar graph of visualizing the average salary for the top paying skills for data analysts in Serbia


## 5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location LIKE '%Serbia%' 
GROUP BY
    skills_dim.skill_id
ORDER BY
    demand_count DESC,
    avg_salary DESC;
```
| Skill ID | Skills  | Demand Count | Average Salary (USD) |
|----------|---------|--------------|----------------------|
| 0        | SQL     | 3            | $86,838.00           |
| 183      | Power BI| 2            | $103,750.00          |
| 14       | C#      | 2            | $79,007.00           |
| 1        | Python  | 2            | $79,007.00           |
| 181      | Excel   | 2            | $77,757.00           |
| 194      | SSIS    | 1            | $105,000.00          |
| 8        | Go      | 1            | $102,500.00          |
| 79       | Oracle  | 1            | $56,700.00           |
| 182      | Tableau | 1            | $53,014.00           |
| 7        | SAS     | 1            | $53,014.00           |
| 186      | SAS     | 1            | $53,014.00           |
| 5        | R       | 1            | $53,014.00           |
| 199      | SPSS    | 1            | $53,014.00           |
*Table of the most optimal skills for data analyst

The table above highlights the demand and average salaries (in USD) for various skills among data analysts in Serbia in 2023. The demand count represents the number of job postings requiring each skill, while the average salary indicates the typical annual compensation associated with that skill.

**SSIS** and **Power BI** offer the highest average salaries, reflecting their specialized use in business intelligence and ETL processes.
**SQL** remains highly in demand, with the highest number of job postings, but offers a mid-range salary.
Other key skills like **Python**, **C#**, and **Excel** are in moderate demand with competitive salaries.
**R**, **SAS**, and **SPSS** have lower demand and are associated with lower average salaries, reflecting their niche use cases in statistical analysis.

# What I Learned
Throughout this adventure, I've enriched my SQL toolkit with some serious firepower:

- 🧩 Complex Query Crafting: Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- 📊 Data Aggregation: Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- 💡 Analytical Wizardry: Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Closing Thoughts
This project enhanced my SQL skills and provided insights into the data analyst job market in Serbia. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.
