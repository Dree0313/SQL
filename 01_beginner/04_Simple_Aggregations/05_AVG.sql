__________________________________________________________________________
-- Beginner SQL: AVG
-- Purpose: Learn how to calculate the average value in a column
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment needs 
  -- reports on average values, such as average salary, typical sales
  -- amounts, or mean performance metrics. You will use AVG to calculate
  -- averages across numeric data.

  -- Table: employees
    -- id            1       2          3          4          5
    -- first_name  Alice     Bob       Carol       Dave       Eve
    -- last_name   Johnson  Smith      Davis      Wilson     Taylor
    -- department    HR      IT         HR         IT       Finance
    -- role        Manager  Analyst  Assistant  Developer  Accountant
    -- salary       75000    60000      50000     65000      NULL
    -- status      Active   Active    Inactive   Active      Active
  
__________________________________________________________________________
-- 1️ Basic AVG
-- What it does: Returns the average (mean) value of a column
-- Why use it: Understands typical or expected values
-- Syntax: SELECT AVG(column_name) FROM table_name;
__________________________________________________________________________
-- Problem: 
  -- Management wants to know the average salary in the company

-- Solution: 
  SELECT AVG(salary) AS AvgSalary
    FROM employees;

-- Expected Results:
  -- AvgSalary  62500

-- *Note: NULL values are ignored automatically

__________________________________________________________________________
-- 2 AVG with WHERE
-- What it does: calculates the average for rows matching a condition
-- Why use it: Focuses on a specific subset of the data
-- Syntax: SELECT AVG(column_name) FROM table_name WHERE condition;
__________________________________________________________________________
-- Problem:
  -- Management wants the average salary in IT

--Solution:
  SELECT AVG(salary) AS ITAvgSalary
    FROM employees
    WHERE department = 'IT';

-- Expected Result:
  -- ITAvgTotal  62500

__________________________________________________________________________
-- 3 AVG with Multiple Conditions
-- What it does: Calculates the average using mulitple filters
-- Why use it: Precise reporting for specific groups
-- Syntax: SELECT AVG(column_name) FROM table_name WHERE condition1 AND
  -- condition2;
__________________________________________________________________________
-- Problem:
  -- Management wants the average salary of active HR employees

-- Solution:
  SELECT AVG(salary) AS ActiveHRAvgSalary
    FROM employees
    WHERE department = 'HR' AND status = 'Active';

-- Expected Result:
  -- ActiveHRAvgSalary  75000

__________________________________________________________________________
-- 4 AVG with NULLs
-- What it does: Ignores NULL values when calculating the average
-- Why use it: Prevents missing data from skewing results
-- Syntax: SELECT AVG(column_name) FROM table_name;
__________________________________________________________________________
-- Problem:
  -- Management wants the average salary, including employees with missing
    -- salaries

-- Solution:
  SELECT AVG(salary) AS AvgSalaryIncludingNulls
    FROM employees;

-- Expected Result:
  -- AvgSalaryIncludingNulls  62500

-- *Note: The NULL salary of Eve is ignored

__________________________________________________________________________
-- 5 AVG with Aliases
-- What it does: Uses a readable name for the calculated average
-- Why use it: SELECT AVG(column_name) AS AliasName FROM table_name;
__________________________________________________________________________
-- Problem: 
  -- Management wants the maximum salary labeled as "HighestPay"

-- Solution: 
  SELECT AVG(salary) AS AveragePay
    FROM employees;

-- Expected Results:
  -- AveragePay  62500
