__________________________________________________________________________
-- Beginner SQL: DISTINCT
-- Purpose: Learn how to return unique values and eliminate duplicates
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment wants
  -- reports that summarize data without repeating the same values. They
  -- are interested in knowing which departments exist, how many unique
  -- roles that are, and avoiding duplicate rows in reports.

  -- Table: employees
    -- id            1       2          3          4          5
    -- first_name  Alice     Bob       Carol       Dave       Eve
    -- last_name   Johnson  Smith      Davis      Wilson     Taylor
    -- department    HR      IT         HR         IT       Finance
    -- role        Manager  Analyst  Assistant  Developer  Accountant
    -- salary       75000    60000      50000     65000      75000
    -- status      Active   Active    Inactive   Active      Active

  
__________________________________________________________________________
-- 1️ DISTINCT on a single column
-- What it does: Returns only unique values from a column
-- Why use it: Helps identify categories, statuses, or types without 
  -- duplicates
-- Syntax: SELECT DISTINCT column FROM table_name;
__________________________________________________________________________
-- Problem: 
  -- Management wants a list of all departments in the company, without
    -- duplicates

-- Solution: 
  SELECT DISTINCT department
    FROM employees;

-- Expected Results
  -- department  HR  IT  Finance

__________________________________________________________________________
-- 2 DISTINCT on mulitple columns
-- What it does: Returns unique combinations of the selected columns
-- Why use it: Useful when uniqueness depends on more than one column
-- Syntax: SELECT DISTINCT column1, column2 FROM table_name;
__________________________________________________________________________
-- Problem:
  -- Management wants to see unique department + role combinations

--Solution:
  SELECT DISTINCT department, role
    FROM employees;

-- Expected Result:
  -- department  HR        HR         IT        IT      Finance
  -- role      Manager  Assistant  Analyst  Developer  Accountant

__________________________________________________________________________
-- 3 DISTINCT vs SELECT *
-- What it does: DISTINCT applies only to the selected columns
-- Why use it: DISTINCT does NOT look at the entire row unless you select
  -- all columns
__________________________________________________________________________
-- Problem: 
  -- A developer tries to remove duplicate departments but selects all
    -- columns

-- Avoid: 
  SELECT DISTINCT *
    FROM employees;

-- Explanation:
  -- Every row is already unique due to different IDDs, nams, or salaries,
    -- so DISTINCT has no effect here

__________________________________________________________________________
-- 4 When to use DISTINCT (and when not to)
-- Use DISTINCT when:
  -- You want unique categories or labels
  -- You are preparing summary-style reports
  -- You want to reduce duplicate-looking results
-- Avoid DISTINCT when:
  -- You don't understand why duplicates exist
  -- It is hiding a join or data modeling issue
  -- You need row-level detail
__________________________________________________________________________
-- Problem:
  -- Management wants a clean list of active employee statuses

--Solution:
  SELECT DISTINCT status
    FROM employees;

-- Expected Result:
  -- status  Active  Inactive

__________________________________________________________________________
-- 4 DISTINCT with filtering
-- What it does: Filters rows first, then removes duplicates
-- Why use it: Helps answer questions like "unique values among a subset"
-- Syntax: SELECT DISTINCT column FROM table_name WHERE condition;
__________________________________________________________________________
-- Problem:
  -- Management wants to know which department currently have active 
    -- employees

--Solution:
  SELECT DISTINCT department
    FROM employees
    WHERE status = 'Active';

-- Expected Result:
  -- department  HR  IT  Finance
