__________________________________________________________________________
-- Beginner SQL: BETWEEN
-- Purpose: Learn how to filter rows within a range of values
__________________________________________________________________________

-- Scenerio:
  -- You are a junior database developer at a company. Managment needs
  -- reports that filter employees based on ranges (such as salary ranges
  -- or ID ranges) instead of exact values.

  -- Table: employees
    -- id            1       2          3          4          5
    -- first_name  Alice     Bob       Carol       Dave       Eve
    -- last_name   Johnson  Smith      Davis      Wilson     Taylor
    -- department    HR      IT         HR         IT       Finance
    -- role        Manager  Analyst  Assistant  Developer  Accountant
    -- salary       75000    60000      50000     65000      NULL
    -- status      Active   Active    Inactive   Active      Active
  
__________________________________________________________________________
-- 1️ Basic BETWEEN
-- What it does: Filters rows where a value falls within a range 
  -- (inclusive)
-- Why use it: Cleaner and more readable than using >= and <=
-- Syntax: WHERE column_name BETWEEN low_value AND high_value
__________________________________________________________________________
-- Problem: 
  -- Management wants to see employees earning between 60000 and 75000

-- Solution: 
  SELECT first_name, department
    FROM employees
    WHERE salary BETWEEN 60000 AND 75000;

-- Expected Results:
  -- first_name  Alice   Bob   Dave
  -- salary      75000  60000  65000

__________________________________________________________________________
-- 2 BETWEEN with Dates or IDs
-- What it does: Filters records within a numeric or sequential range
-- Why use it: Common for reports based on time periods or ID ranges
__________________________________________________________________________
-- Problem:
  -- Management wants employees with IDs between 2 and 4

-- Solution:
  SELECT first_name, id
    FROM employees
    WHERE id BETWEEN 2 AND 4;

-- Expected Result:
   -- id           2     3     4
  -- first_name  Bob  Carol  Dave

__________________________________________________________________________
-- 3 NOT BETWEEN
-- What it does: Excludes values inside a range
-- Why use it: Helpful when filtering out mid-range values
-- Syntax: WHERE column_name NOT BETWEEN low AND high
__________________________________________________________________________
-- Problem: 
  -- Management wants employees NOT earning between 60000 and 75000

-- Solution: 
  SELECT first_name, salary
    FROM employees
    WHERE salary NOT BETWEEN 60000 AND 75000;

-- Expected Results:
  -- first_name  Carol
  -- salary      50000

