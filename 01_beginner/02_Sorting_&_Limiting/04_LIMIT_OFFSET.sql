__________________________________________________________________________
-- Beginner SQL: LIMIT / OFFSET
-- Purpose: Learn how to restricet the number of rows returned
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment only
  -- wants to see a small number or records, such as top earners or a 
  -- quick preview of the data. You will use LIMIT and OFFSET to control how many
  -- rows are returned and where the results start.

  -- Table: employees
    -- id            1       2          3          4          5
    -- first_name  Alice     Bob       Carol       Dave       Eve
    -- last_name   Johnson  Smith      Davis      Wilson     Taylor
    -- department    HR      IT         HR         IT       Finance
    -- role        Manager  Analyst  Assistant  Developer  Accountant
    -- salary       75000    60000      50000     65000      75000
    -- status      Active   Active    Inactive   Active      Active

  
__________________________________________________________________________
-- 1️ Basic LIMIT
-- What it does: Restricts the number of rows returned
-- Why use it: Prevents large result sets and improves performance
-- Syntax: SELECT columns FROM table_name LIMIT number;
__________________________________________________________________________
-- Problem: 
  -- Management wants to see only the first 3 employees

-- Solution: 
  SELECT first_name, last_name
    FROM employees
    LIMIT 3;

-- Expected Results:
  -- first_name  Alice    Bob   Carol
  -- last_name  Johnson  Smith  Davis

-- *Without ORDER BY, the rows returned are not guaranteed

__________________________________________________________________________
-- 2 LIMIT with ORDER BY
-- What it does: Returns the top N rows after sorting
-- Why use it: Most common and safest use of LIMIT
-- Syntax: SELECT columns FROM table_name ORDER BY column_name LIMIT 
  -- number;
__________________________________________________________________________
-- Problem:
  -- Management wants the top 2 highest-paid employees

--Solution:
  SELECT first_name, salary
    FROM employees
    ORDER BY salary DESC
    LIMIT 2;

-- Expected Result:
  -- first_name  Alice   Eve
  -- salary      75000  75000

__________________________________________________________________________
-- 3 LIMIT with ASC (Lowest Values)
-- What it does: Returns the lowest N values
-- Why use it: Find bottom values or minimum records
-- Syntax: SELECT columns FROM table_name ORDER BY column ASC LIMIT 
  -- number;
__________________________________________________________________________
-- Problem:
  -- Management wants the 2 lowest-paid employees

-- Solution:
  SELECT first_name, salary
    FROM employees
    ORDER BY salary ASC
    LIMIT 2;

-- Expected Result:
  -- first_name  Carol   Bob
  -- salary      50000  60000

__________________________________________________________________________
-- 4 LIMIT with Multiple Sort Rules
-- What it does: Applies LIMIT after multi-column sorting
-- Why use it: Precise ranking and filtering
-- Syntax: SELECT columns FROM table_name ORDER BY col1 DESC, col2 ASC 
  -- LIMIT number;
__________________________________________________________________________
-- Problem:
  -- Management wants the top 3 highest-paid employees, sorted
    -- alphabetically when salaries tie

-- Solution:
  SELECT first_name, salary
    FROM employees
    ORDER BY salary DESC, first_name ASC
    LIMIT 3;

-- Expected Result:
  -- first_name  Alice   Eve   Dave
  -- salary      75000  75000  65000

__________________________________________________________________________
-- 5 LIMIT with WHERE
-- What it does: Limits results after filtering
-- Why use it: Focus on a subset of data
-- Syntax: SELECT columns FROM table_name WHERE condition ORDER BY column
  -- LIMIT number;
__________________________________________________________________________
-- Problem:
  -- Management wants the top 2 highest-paid IT employees

-- Solution:
  SELECT first_name, department, salary
    FROM employees
    WHERE department = 'IT'
    ORDER BY salary DESC
    LIMIT 2;

-- Expected Result:
  -- first_name  Dave    Bob
  -- department   IT     IT
  -- salary      65000  60000

__________________________________________________________________________
-- 6 LIMIT with Aliases
-- What it does: Uses renamed colums in sorting and limiting
-- Why use it: Cleaner and more readable queries
-- Syntax: SELECT columns AS alias FROM table_name ORDER BY alias DESC
  -- LIMIT number;
__________________________________________________________________________
-- Problem:
  -- Management wants the top 3 salaries using a readable column name

-- Solution:
  SELECT first_name, salary AS Pay
    FROM employees
    ORDER BY Pay DESC
    LIMIT 3;

-- Expected Result:
  -- first_name  Alice   Eve   Dave
  -- Pay         75000  75000  65000

__________________________________________________________________________
-- 7 OFFSET (Skipping Rows)
-- What it does: Skips a specific number of rows before returning results
-- Why use it: Pagination and ranked result sets
-- Syntax: SELECT columns FROM table_name ORDER BY column LIMIT number
  -- OFFSET number;
__________________________________________________________________________
-- Problem:
  -- Management wants to skip the highest-paid employee and see the next 2

-- Solution:
  SELECT first_name, salary
    FROM employees
    ORDER BY salary DESC
    LIMIT 2 OFFSET 1;

-- Expected Result:
  -- first_name  Eve   Dave
  -- salary      75000  65000

__________________________________________________________________________
-- 8 LIMIT + OFFSET for Pagination
-- What it does: Returns a specific "page" of results
-- Why use it: Common in applications and reports
__________________________________________________________________________
-- Problem:
  -- Page size is 2 employees per page
  -- Show page 2 (skip first 2, show next 2)

-- Solution:
  SELECT first_name, last_name
    FROM employees
    ORDER BY id
    LIMIT 2 OFFSET 2;

-- Expected Result:
  -- first_name  Carol  Dave
  -- last_name   Davis  Wilson

__________________________________________________________________________
-- 9 OFFSET without ORDER BY (Why It's Dangerous)
-- OFFSET always assumes a stable order
-- Without ORDER BY, skipped rows are unpredictable
__________________________________________________________________________
-- Avoid this:
  SELECT first_name
  FROM employees
  LIMIT 2 OFFSET 2;
