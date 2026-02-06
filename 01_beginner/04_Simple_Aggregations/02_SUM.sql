__________________________________________________________________________
-- Beginner SQL: SUM
-- Purpose: Learn how to calculate total numeric values in SQL queries
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment needs 
  -- reports on totals, like the total payroll, total salary per department
  -- or total sales. You will use SUM to add up numeric columns.

  -- Table: employees
    -- id            1       2          3          4          5
    -- first_name  Alice     Bob       Carol       Dave       Eve
    -- last_name   Johnson  Smith      Davis      Wilson     Taylor
    -- department    HR      IT         HR         IT       Finance
    -- role        Manager  Analyst  Assistant  Developer  Accountant
    -- salary       75000    60000      50000     65000      NULL
    -- status      Active   Active    Inactive   Active      Active
  
__________________________________________________________________________
-- 1️ Basic SUM
-- What it does: Adds up all numeric values in a column
-- Why use it: Quickly finds the total of a metric
-- Syntax: SELECT SUM(column_name) FROM table_name;
__________________________________________________________________________
-- Problem: 
  -- Management wants to know the total salary of all employees

-- Solution: 
  SELECT SUM(salary) AS TOTALSalary
    FROM employees;

-- Expected Results:
  -- TotalSalary  250000

-- *Note: NULL values are ignored automatically

__________________________________________________________________________
-- 2 SUM with WHERE
-- What it does: Adds up values that match a condition
-- Why use it: Totals only a subset of data
-- Syntax: SELECT SUM(column_name) FROM table_name WHERE condition;
__________________________________________________________________________
-- Problem:
  -- Management wants the total salary of employees in IT

--Solution:
  SELECT SUM(salary) AS ITSalaryTotal
    FROM employees
    WHERE department = 'IT';

-- Expected Result:
  -- ITSalaryTotal  125000

__________________________________________________________________________
-- 3 SUM with Multiple Conditions
-- What it does: Adds up values that meet multiple criteria
-- Why use it: Precise totals for filtered subsets
-- Syntax: SELECT SUM(column_name) FROM table_name WHERE condition1 AND
  -- condition2;
__________________________________________________________________________
-- Problem:
  -- Management wants the total salary of active employees in HR

-- Solution:
  SELECT SUM(salary) AS ActiveHRTotal 
    FROM employees
    WHERE department = 'HR' AND status = 'Active';

-- Expected Result:
  -- ActiveHRTotal  75000

__________________________________________________________________________
-- 4 SUM with NULLs
-- What it does: Ignores NULLs automatically
-- Why use it: Prevents missing data from affecting totals
-- Syntax: SELECT SUM(column_name) FROM table_name;
__________________________________________________________________________
-- Problem:
  -- Management wants the total salary including employees with missing
    -- salaries

-- Solution:
  SELECT SUM(salary) AS TotalSalaryIncludingNulls
    FROM employees;

-- Expected Result:
  -- TotalSalaryIncludingNulls  250000

-- *Note: The NULL salary of Eve is ignored

__________________________________________________________________________
-- 5 SUM with Aliases
-- What it does: Uses a readable name for the total
-- Why use it: Makes reports and queries easier to understand
-- Syntax: SELECT SUM(column_name) AS AliasName FROM table_name;
__________________________________________________________________________
-- Problem: 
  -- Management wants the total payroll labeled as "PayrollTotal"

-- Solution: 
  SELECT SUM(salary) AS PayrollTotal
    FROM employees;

-- Expected Results:
  -- PayrollTotal  250000
