/*
Question: What are the most optimal skills to learn?
- Identify skills in high demand and associated with high avergae salaries for data analyst positions
- Concentrate on remote postitions with specific salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
    offering strategic insights for career development in data analysis
*/

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) As demand_count,
    ROUND(AVG(Job_postings_fact.salary_year_avg), 0) AS avg_salary
fROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND Job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING
COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

