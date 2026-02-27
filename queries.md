# Organizational Insights Using SQL & Power BI

## 📊 Overview

This project explores an HR dataset to understand workforce composition, employee demographics, job role distribution, and department-level retention patterns.  
and the analysis was conducted using SQL in MySQL Workbench, and the results were visualized through an interactive Power BI dashboard to present key organizational insights.

## ❓ Analysis Questions & SQL Queries

 1. What is the gender breakdown of employees in the company?

SELECT gender, COUNT(*) AS employee_count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY gender;

2. What is the race/ethnicity breakdown of employees?
   
SELECT race, COUNT(*) AS employee_count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY race
ORDER BY employee_count DESC;

4. What is the age distribution of employees?
SELECT
    CASE
        WHEN age BETWEEN 18 AND 24 THEN '18–24'
        WHEN age BETWEEN 25 AND 34 THEN '25–34'
        WHEN age BETWEEN 35 AND 44 THEN '35–44'
        WHEN age BETWEEN 45 AND 54 THEN '45–54'
        WHEN age BETWEEN 55 AND 64 THEN '55–64'
        ELSE '65+'
    END AS age_group,
    COUNT(*) AS employee_count
FROM hr
WHERE termdate IS NULL
GROUP BY age_group
ORDER BY age_group;

5. How are employees distributed between headquarters and remote locations?
SELECT location, COUNT(*) AS employee_count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY location;

6. What is the distribution of job titles across the organization?
SELECT jobtitle, COUNT(*) AS employee_count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY jobtitle
ORDER BY employee_count DESC;

7. Which departments exhibit higher employee turnover?
SELECT
    department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN termdate IS NOT NULL THEN 1 ELSE 0 END) AS terminated_employees,
    ROUND(SUM(CASE WHEN termdate IS NOT NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS turnover_rate
FROM hr
WHERE age >= 18
GROUP BY department
ORDER BY turnover_rate DESC;

8. How does employee tenure vary across departments?
SELECT
    department,
    ROUND(AVG(DATEDIFF(termdate, hire_date) / 365), 1) AS avg_tenure_years
FROM hr
WHERE termdate IS NOT NULL
AND age >= 18
GROUP BY department
ORDER BY avg_tenure_years DESC;

🎯 Outcome

This project demonstrates the use of SQL for workforce analysis and Power BI for communicating organizational insights through visual dashboards.

