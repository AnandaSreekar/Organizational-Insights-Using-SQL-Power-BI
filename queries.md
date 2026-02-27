PROJECT: Organizational Insights Using SQL & Power BI

ANALYSIS QUESTIONS & SQL QUERIES

1) What is the gender breakdown of employees in the company?

Query:
SELECT gender, COUNT(*) AS employee_count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY gender;

Purpose:
Counts active employees grouped by gender to understand gender distribution.


------------------------------------------------------------

2) What is the race/ethnicity breakdown of employees?

Query:
SELECT race, COUNT(*) AS employee_count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY race
ORDER BY employee_count DESC;

Purpose:
Counts active employees by race and sorts them from highest to lowest to analyze diversity distribution.


------------------------------------------------------------

3) What is the age distribution of employees?

Query:
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

Purpose:
Groups employees into defined age categories and counts active employees in each group.


------------------------------------------------------------

4) How are employees distributed between headquarters and remote locations?

Query:
SELECT location, COUNT(*) AS employee_count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY location;

Purpose:
Counts active employees based on work location (Headquarters vs Remote).


------------------------------------------------------------

5) What is the distribution of job titles across the organization?

Query:
SELECT jobtitle, COUNT(*) AS employee_count
FROM hr
WHERE age >= 18 AND termdate IS NULL
GROUP BY jobtitle
ORDER BY employee_count DESC;

Purpose:
Counts active employees grouped by job role and sorts them by highest frequency.


------------------------------------------------------------

6) Which departments exhibit higher employee turnover?

Query:
SELECT
    department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN termdate IS NOT NULL THEN 1 ELSE 0 END) AS terminated_employees,
    ROUND(SUM(CASE WHEN termdate IS NOT NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS turnover_rate
FROM hr
WHERE age >= 18
GROUP BY department
ORDER BY turnover_rate DESC;

Purpose:
Calculates total employees, number of terminated employees, and turnover percentage for each department.


------------------------------------------------------------

7) How does employee tenure vary across departments?

Query:
SELECT
    department,
    ROUND(AVG(DATEDIFF(termdate, hire_date) / 365), 1) AS avg_tenure_years
FROM hr
WHERE termdate IS NOT NULL
AND age >= 18
GROUP BY department
ORDER BY avg_tenure_years DESC;

Purpose:
Calculates the average number of years employees stayed in each department before leaving.


------------------------------------------------------------

FINAL OUTCOME:
Used SQL to analyze employee data and extract workforce insights such as demographic distribution, job role counts, turnover rates, and tenure analysis. The processed results were visualized using Power BI to create an interactive organizational dashboard.
