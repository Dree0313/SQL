__________________________________________________________________________
-- Beginner SQL: MAX
-- Purpose: Learn how to find the largest value in a column
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment needs 
  -- reports on maximum values, such as the highest salary, latest date,
  -- or largest numberic metric. You will use MAX to identify maximum
  -- values in a dataset.

  -- Table: employees
    -- id            1       2          3          4          5
    -- first_name  Alice     Bob       Carol       Dave       Eve
    -- last_name   Johnson  Smith      Davis      Wilson     Taylor
    -- department    HR      IT         HR         IT       Finance
    -- role        Manager  Analyst  Assistant  Developer  Accountant
    -- salary       75000    60000      50000     65000      NULL
    -- status      Active   Active    Inactive   Active      Active
  
__________________________________________________________________________
-- 1️ Basic MAX
-- What it does: Returns the largest value in a column
-- Why use it: Quickly finds the maximum value of a metric
-- Syntax: SELECT MAX(column_name) FROM table_name;
__________________________________________________________________________
-- Problem: 
  -- Management wants to know the highest salary in the company

-- Solution: 
  SELECT MAX(salary) AS MaxSalary
    FROM employees;

-- Expected Results:
  -- MaxSalary  75000

-- *Note: NULL values are ignored automatically

__________________________________________________________________________
-- 2 MAX with WHERE
-- What it does: Finds the largest value that matches a condition
-- Why use it: Focuses on a subset of the data
-- Syntax: SELECT MAX(column_name) FROM table_name WHERE condition;
__________________________________________________________________________
-- Problem:
  -- Management wants to know the highest salary in IT

--Solution:
  SELECT MAX(salary) AS ITMaxSalary
    FROM employees
    WHERE department = 'IT';

-- Expected Result:
  -- ITMaxTotal  65000

__________________________________________________________________________
-- 3 MAX with Multiple Conditions
-- What it does: Finds the maximum value meeting multiple criteria
-- Why use it: Precise reporting for filtered subsets
-- Syntax: SELECT MAX(column_name) FROM table_name WHERE condition1 AND
  -- condition2;
__________________________________________________________________________
-- Problem:
  -- Management wants the highest salary of among active HR employees

-- Solution:
  SELECT MAX(salary) AS ActiveHRMaxSalary
    FROM employees
    WHERE department = 'HR' AND status = 'Active';

-- Expected Result:
  -- ActiveHRMaxSalary  75000

__________________________________________________________________________
-- 4 MAX with NULLs
-- What it does: Ignores NULL values automatically
-- Why use it: Prevents missing data from affecting results
-- Syntax: SELECT MAX(column_name) FROM table_name;
__________________________________________________________________________
-- Problem:
  -- Management wants the maximum salary, including employees with missing
    -- salaries

-- Solution:
  SELECT MAX(salary) AS MaxSalaryIncludingNulls
    FROM employees;

-- Expected Result:
  -- MaxSalaryIncludingNulls  75000

-- *Note: The NULL salary of Eve is ignored

__________________________________________________________________________
-- 5 MAX with Aliases
-- What it does: Uses a readable name for the total
-- Why use it: SELECT MAX(column_name) AS AliasName FROM table_name;
__________________________________________________________________________
-- Problem: 
  -- Management wants the maximum salary labeled as "HighestPay"
-- Solution: 
  SELECT MAX(salary) AS HighestPay
    FROM employees;

-- Expected Results:
  -- HighestPay  75000
