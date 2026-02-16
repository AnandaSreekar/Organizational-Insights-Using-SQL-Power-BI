-- Create a dedicated database for the project
CREATE DATABASE projects;
USE projects;

-- View raw data before any transformations
SELECT * FROM hr;

-- Fix column name issue caused by encoding/BOM character
-- Renaming strange column header to a clean identifier
ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

-- Disable safe update mode to allow bulk updates
SET sql_safe_updates = 0;

-- ----------------------------------------------------
-- Standardize Birthdate Column
-- Convert inconsistent text formats into proper DATE
-- ----------------------------------------------------

UPDATE hr
SET birthdate = CASE
    -- Handle slash-based dates (e.g., 12/31/2000)
    WHEN birthdate LIKE '%/%' 
        THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m/%d/%Y'), '%Y-%m-%d')

    -- Handle dash-based dates (e.g., 12-31-2000)
    WHEN birthdate LIKE '%-%' 
        THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m-%d-%Y'), '%Y-%m-%d')

    -- Invalid or unknown values converted to NULL
    ELSE NULL
END;

-- Change column data type for correct date operations
ALTER TABLE hr MODIFY COLUMN birthdate DATE;

-- ----------------------------------------------------
-- Standardize Hire Date Column
-- Same logic applied as birthdate cleanup
-- ----------------------------------------------------

UPDATE hr
SET hire_date = CASE
    WHEN hire_date LIKE '%/%' 
        THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')

    WHEN hire_date LIKE '%-%' 
        THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%Y'), '%Y-%m-%d')

    ELSE NULL
END;

-- Convert to DATE type after cleanup
ALTER TABLE hr MODIFY COLUMN hire_date DATE;

-- ----------------------------------------------------
-- Clean Termination Date Column
-- Remove timestamp + UTC text noise
-- ----------------------------------------------------

UPDATE hr
SET termdate = DATE(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL 
  AND termdate != ' ';

-- Ensure correct DATE data type
ALTER TABLE hr MODIFY COLUMN termdate DATE;

-- ----------------------------------------------------
-- Derive Age Column
-- Age calculated from birthdate
-- ----------------------------------------------------

ALTER TABLE hr ADD COLUMN age INT;

UPDATE hr
SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());
