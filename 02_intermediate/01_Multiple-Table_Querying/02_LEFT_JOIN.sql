__________________________________________________________________________
-- Intermediate SQL: LEFT JOIN
-- Purpose: Learn how to return ALL records from the left table, even if
  -- matching data does NOT exist in the right table
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment needs
  -- reports that show ALL employees - even if they are not assigned to a
  -- department yet. 

-- Unlike INNER JOIN, LEFT JOIN keeps everything from the LEFT table.

  -- Table: employees
    -- id              1      2     3       4     5
    -- first_name    Alice   Bob   Carol  Dave   Eve
    -- department_id  10     20     10     20    NULL
    -- salary        75000  60000  50000  65000  NULL

  -- Table: departments
    -- department_id    10  20    30
    -- department_name  HR  IT  Finance
__________________________________________________________________________
-- 1️ Basic LEFT JOIN
-- What it does: Returns ALL rows from the left table and matching rows
  -- from the right table
-- Why use it: Ensures no primary records are accidentally excluded
-- Syntax: SELECT columns FROM table1 LEFT JOIN table2 ON table1.column =
  -- table2.column
__________________________________________________________________________
-- Problem: 
  -- Management wants a list of ALL employees and their department names

-- Solution: 
  SELECT e.first_name, d.department_name
    FROM employees e
    LEFT JOIN departments d ON e.department_id = d.department_id;

-- Expected Results:
  -- first_name      Alice  Bob  Carol  Dave  Eve
  -- department_name  HR    IT     HR    IT   NULL

  -- Eve appears even though she has no department
  -- Her department_name is NULL because no match was found

__________________________________________________________________________
-- 2 LEFT JOIN with WHERE Clause (Important Behavior)
-- What it does: Filters results after the join happens
-- Why use it: Creates targeted reports
__________________________________________________________________________
-- Problem:
  -- Management wants only wants employees in the IT department

-- Solution:
  SELECT e.first_name, d.department_name
    FROM employees e
    LEFT JOIN departments d ON e.department_id = d.department_id
    WHERE d.department_name = 'IT';

-- Expected Result:
  -- first_name      Bob   Dave
  -- department_name  IT    IT

  -- Even though we used LEFT JOIN, Eve is excluded. Why? Because Where 
  -- removes rows Where department_name is NULL. The LEFT JOIN happened, 
  -- but the WHERE filtered her out.

__________________________________________________________________________
-- 3 LEFT JOIN with Nunmeric Conditions
-- What it does: Applies filters while still preserving left-table rows
-- Why use it: Produces complete reports with conditions
__________________________________________________________________________
-- Problem: 
  -- Management wants employees and their department names, but only for
  -- employees earning more than 60000

-- Solution: 
  SELECT e.first_name, e.salary, d.department_name
    FROM employees e
    LEFT JOIN departments d ON e.department_id = d.department_id
    WHERE e.salary > 60000;

-- Expected Results:
  -- first_name     Alice   Dave
  -- salary         75000  65000
  -- department_name HR     IT

-- Eve is exclued because salary is NULL
-- NULL > 60000 is UNKNOWN, not TRUE

__________________________________________________________________________
-- 4 LEFT JOIN with Aliases
-- What it does: Uses short table names
-- Why use it: Improves readability
__________________________________________________________________________
-- Problem:
  -- Management wants a clean, readable report format

-- Solution:
  SELECT e.first_name, d.department_name
    FROM employees AS e 
    LEFT JOIN departments AS d ON e.department_id = d.department_id;

-- Expected Result:
  -- first_name      Alice  Bob  Carol  Dave
  -- department_name  HR    IT    HR     IT

__________________________________________________________________________
-- 5 LEFT JOIN and NULL Behavior (Key Concept)
-- What it does: Demonstrates how LEFT JOIN handles missing matches
-- Why use it: Prevents confusion when analyzing reports
__________________________________________________________________________
-- Problem: 
  -- Management wants to understand why employees with NULL keys are 
  -- excluded

-- Explanation: 
  -- LEFT JOIN keeps ALL rows from the left table
  -- If no match is found in the right table, columns return NULL
  -- WHERE conditions on the right table can remove NULL rows
  -- To preserve unmatched rows, move conditions into the ON clause

-- Example preserving NULL rows:
  Select e.first_name, d.department_name
    From employee e
    LEFT JOIN department d 
      ON e.department_id = d.department_id 
      AND d.department_name = 'IT';

__________________________________________________________________________
-- 6 LEFT JOIN to Return ONLY NULL (Unmatched) Records
-- What it does: Returns records from the left table that have NO match in
  -- right table
-- Why use it: Finds missing relationships (employees without departments,
  -- members without accounts, etc.)
__________________________________________________________________________
-- Problem: 
  -- Management wants a list of employees who are NOT assigned to any
  -- department

-- Solution:
  Select e.first_name
    From employee e
    LEFT JOIN department d ON e.department_id = d.department_id 
    WHERE d.department_id IS NULL;
