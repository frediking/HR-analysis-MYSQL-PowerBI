 CREATE DATABASE projects;
 
 USE project;
 
 SELECT * FROM hr;
 
  -- changing column name
 ALTER TABLE hr
 CHANGE COLUMN MyUnknownColumn emp_id VARCHAR(20) NULL; 

 
DESCRIBE hr;                 -- checking data types for all columns and changing date format

SELECT birthdate FROM hr;

SET sql_safe_updates = 0;    -- change value to 1 for security feature to protect database

 UPDATE hr
 SET birthdate = CASE
   WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
   WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
   ELSE NULL
END;
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

UPDATE hr
 SET hire_date = CASE
   WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
   WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
   ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '',
date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')),'0000-00-00')
WHERE true;

SELECT termdate FROM hr;

SET sql_mode = 'ALLOW_INVALID_DATES';     -- allowing the 0000-00-00 date in the termdate column

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

SELECT termdate FROM hr;

ALTER TABLE hr ADD COLUMN age INT;         -- adding a new column age with integer data type

SELECT * FROM hr;


SELECT birthdate, age FROM hr;

SELECT 
   MIN(age) AS youngest,
   MAX(age) AS oldest
FROM hr;

UPDATE hr
SET birthdate = DATE_SUB(birthdate, INTERVAL '1OO' YEAR)
WHERE birthdate >= '2060-01-01' AND birthdate < '2070-01-01';

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());                                  -- calculating the age using the birthdate column and some functions

SELECT count(*) 
FROM hr 
WHERE timestampdiff(YEAR, birthdate, CURDATE()) > 18;

SELECT birthdate, timestampdiff(year, birthdate, CURDATE()) AS calculated_age
FROM hr
ORDER BY birthdate DESC
LIMIT 5;

