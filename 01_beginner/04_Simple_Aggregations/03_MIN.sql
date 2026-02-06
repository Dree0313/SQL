__________________________________________________________________________
-- Beginner SQL: MIN
-- Purpose: Learn how to find the smallest value in a column
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment needs 
  -- reports on minimum values, such as the lowest salary, earliest date,
  -- or smallest numberic metric. You will use MIN to identify minimum
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
-- 1️ Basic MIN
-- What it does: Returns the smallest value in a column
-- Why use it: Quickly finds the minimum value of a metric
-- Syntax: SELECT MIN(column_name) FROM table_name;
__________________________________________________________________________
-- Problem: 
  -- Management wants to know the lowest salary in the company

-- Solution: 
  SELECT MINlary) AS MinSalary
    FROM employees;

-- Expected Results:
  -- MinSalary  50000

-- *Note: NULL values are ignored automatically

__________________________________________________________________________
-- 2 MIN with WHERE
-- What it does: Finds the smallest value that matches a condition
-- Why use it: Focuses on a subset of the data
-- Syntax: SELECT MIN(column_name) FROM table_name WHERE condition;
__________________________________________________________________________
-- Problem:
  -- Management wants to know the lowest salary in IT

--Solution:
  SELECT MIN(salary) AS ITMinSalary
    FROM employees
    WHERE department = 'IT';

-- Expected Result:
  -- ITMinTotal  60000

__________________________________________________________________________
-- 3 MIN with Multiple Conditions
-- What it does: Finds the minimum value meeting multiple criteria
-- Why use it: Precise reporting for filtered subsets
-- Syntax: SELECT MIN(column_name) FROM table_name WHERE condition1 AND
  -- condition2;
__________________________________________________________________________
-- Problem:
  -- Management wants the lowest salary of among active HR employees

-- Solution:
  SELECT MIN(salary) AS ActiveHRMinSalary
    FROM employees
    WHERE department = 'HR' AND status = 'Active';

-- Expected Result:
  -- ActiveHRMinSalary  75000

__________________________________________________________________________
-- 4 MIN with NULLs
-- What it does: Ignores NULL values automatically
-- Why use it: Prevents missing data from affecting results
-- Syntax: SELECT MIN(column_name) FROM table_name;
__________________________________________________________________________
-- Problem:
  -- Management wants the minimum salary, including employees with missing
    -- salaries

-- Solution:
  SELECT MIN(salary) AS MinSalaryIncludingNulls
    FROM employees;

-- Expected Result:
  -- MinSalaryIncludingNulls  50000

-- *Note: The NULL salary of Eve is ignored

__________________________________________________________________________
-- 5 MIN with Aliases
-- What it does: Uses a readable name for the total
-- Why use it: SELECT MIN(column_name) AS AliasName FROM table_name;
__________________________________________________________________________
-- Problem: 
  -- Management wants the minimum salary labeled as "LowestPay"
-- Solution: 
  SELECT MIN(salary) AS LowestPay
    FROM employees;

-- Expected Results:
  -- LowestPay  50000
