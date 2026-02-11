__________________________________________________________________________
-- Beginner SQL: INNER JOIN
-- Purpose: Learn how to combine related data from multiple tables
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment needs
  -- reports that combine employee inforamtion with related department 
  -- data. The data is stored in separate tables, so you must use INNER
  -- JOIN to return only records that exist in BOTH tables.

  -- Table: employees
    -- id              1      2     3       4     5
    -- first_name    Alice   Bob   Carol  Dave   Eve
    -- department_id  10     20     10     20    NULL
    -- salary        75000  60000  50000  65000  NULL

  -- Table: departments
    -- department_id    10  20    30
    -- department_name  HR  IT  Finance
__________________________________________________________________________
-- 1️ Basic INNER JOIN
-- What it does: Combines rows where matching values exist in both tables
-- Why use it: Retrieves related data stored across tables
-- Syntax: SELECT columns FROM table1 INNER JOIN table2 ON table1.column =
  -- table2.column
__________________________________________________________________________
-- Problem: 
  -- Management wants a list of employees and their department names

-- Solution: 
  SELECT e.first_name, d.department_name
    FROM employees e
    INNER JOIN departments d ON e.department_id = d.department_id;

-- Expected Results:
  -- first_name      Alice  Bob  Carol  Dave
  -- department_name  HR    IT     HR    IT

  -- Eve is excluded because her department_id is NULL

__________________________________________________________________________
-- 2 INNER JOIN with WHERE Clause
-- What it does: Filters joined data based on conditions
-- Why use it: Produces focused business reports
__________________________________________________________________________
-- Problem:
  -- Management wants employees in the IT department only

-- Solution:
  SELECT e.first_name, d.department_name
    FROM employees e
    INNER JOIN departments d ON e.department_id = d.department_id
    WHERE d.department_name = 'IT';

-- Expected Result:
  -- first_name      Bob   Dave
  -- department_name  IT    IT

  -- Eve is excluded because NULL > 60000 is UNKNOWN, not TRUE

__________________________________________________________________________
-- 3 INNER JOIN with Nunmeric Conditions
-- What it does: Applies filters to joined rows
-- Why use it: Combines relational logic with data constraints
__________________________________________________________________________
-- Problem: 
  -- Management wants employees earning more than 60000 and their 
    -- departments

-- Solution: 
  SELECT e.first_name, e.salary, d.department_name
    FROM employees e
    INNER JOIN departments d ON e.department_id = d.department_id
    WHERE e.salary > 60000;

-- Expected Results:
  -- first_name     Alice   Dave
  -- salary         75000  65000
  -- department_name HR     IT

__________________________________________________________________________
-- 4 INNER JOIN with Aliases
-- What it does: Uses short names for tables
-- Why use it: Improves readability in multi-table queries
__________________________________________________________________________
-- Problem:
  -- Management wants a clean, readable report format

-- Solution:
  SELECT e.first_name, d.department_name
    FROM employees AS e 
    INNER JOIN departments AS d ON e.department_id = d.department_id;

-- Expected Result:
  -- first_name      Alice  Bob  Carol  Dave
  -- department_name  HR    IT    HR     IT

__________________________________________________________________________
-- 5 INNER JOIN and NULL Behavior
-- What it does: Shows how NULL affects joins
-- Why use it: Prevents confusion when rows disappear
__________________________________________________________________________
-- Problem: 
  -- Management wants to understand why employees with NULL keys are 
    -- excluded

-- Explanation: 
  -- Inner Join requires a match on both sides
  -- NULL never equals NULL or any value
  -- Rows with NULL join keys are excluded automatically

