__________________________________________________________________________
-- Beginner SQL: COUNT
-- Purpose: Learn how to count rows in SQL queries
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment needs 
  -- reports on totals, like how many employees are active, in a certain
  -- department, or have missing data. You will use COUNT to measure rows.

  -- Table: employees
    -- id            1       2          3          4          5
    -- first_name  Alice     Bob       Carol       Dave       Eve
    -- last_name   Johnson  Smith      Davis      Wilson     Taylor
    -- department    HR      IT         HR         IT       Finance
    -- role        Manager  Analyst  Assistant  Developer  Accountant
    -- salary       75000    60000      50000     65000      NULL
    -- status      Active   Active    Inactive   Active      Active
  
__________________________________________________________________________
-- 1️ Basic COUNT
-- What it does: Counts the number of rows in a table
-- Why use it: Quickly finds out how many records exist
-- Syntax: SELECT COUNT(*) FROM table_name;
__________________________________________________________________________
-- Problem: 
  -- Management wants to know how many employees exist

-- Solution: 
  SELECT COUNT(*) AS TOTALEmployees
    FROM employees;

-- Expected Results:
  -- TotalEmployees  5

__________________________________________________________________________
-- 2 COUNT with WHERE
-- What it does: Counts rows that match a condition
-- Why use it: Filters results before counting
-- Syntax: SELECT COUNT(*) FROM table_name WHERE condition;
__________________________________________________________________________
-- Problem:
  -- Management wants to know how many employees are in IT

--Solution:
  SELECT COUNT(*) AS ITEmployees
    FROM employees
    WHERE department = 'IT';

-- Expected Result:
  -- ITEmployees  2

__________________________________________________________________________
-- 3 COUNT Distinct Values
-- What it does: Counts unique values in a column
-- Why use it: Avoid counting duplicates
-- Syntax: SELECT COUNT(DISTINCT column_name) FROM table_name;
__________________________________________________________________________
-- Problem:
  -- Management wants to know how many different departments exist

-- Solution:
  SELECT COUNT(DISTINCT department) AS UniqueDepartments 
    FROM employees;

-- Expected Result:
  -- UniqueDepartments  3

__________________________________________________________________________
-- 4 COUNT with NULLs
-- What it does: COUNT(column) ignores NULLs
-- Why use it: Only counts rows with data in the column
-- Syntax: SELECT COUNT(column_name) FROM table_name;
__________________________________________________________________________
-- Problem:
  -- Management wants to know how many employees have a salary recorded

-- Solution:
  SELECT COUNT(salary) AS EmployeeWithSalary
    FROM employees;

-- Expected Result:
  -- EmployeeWithSalary  4

__________________________________________________________________________
-- 5 COUNT with WHERE and NULLs
-- What it does: Counts rows that meet a condition and handles NULLs
-- Why use it: SELECT COUNT(column_name) FROM table_name WHERE column_name
  -- IS NULL;
__________________________________________________________________________
-- Problem: 
  -- Management wants to know how many employees do NOT have a salary

-- Solution: 
  SELECT COUNT(*) AS EmployeesMissingSalary
    FROM employees
    WHERE salary IS NULL;

-- Expected Results:
  -- EmployeeMissingSalary  1

__________________________________________________________________________
-- 6 COUNT with Multiple Conditions
-- What it does: Counts rows matching multiple criteria
-- Why use it: Allows precise metrics and reporting
-- Syntax: SELECT COUNT(*) FROM table_name WHERE condition1 AND conditon2;
__________________________________________________________________________
-- Problem:
  -- Management wants to know how many active employees are in HR

--Solution:
  SELECT COUNT(*) AS ActiveHR
    FROM employees
    WHERE department = 'HR' status = 'Active';

-- Expected Result:
  -- ActiveHR  1
